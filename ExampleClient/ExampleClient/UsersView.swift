import APIClient
import Models
import SwiftUI

public class UsersModel: ObservableObject {
	@Published var users: [User] = []
	let apiClient = APIClient.liveValue
	@Published var addUserIsPresented = false
	
	public init() {}
	
	func onAppear() {
		Task { @MainActor in
			do {
				self.users = try await self.apiClient.getUsers()
			} catch {
				print(error)
			}
		}
	}
	
	func addUser() {
		self.addUserIsPresented = true
	}
}

public struct UsersView: View {
	@ObservedObject var model: UsersModel
	
	public var body: some View {
		List {
			ForEach(self.model.users) { user in
				NavigationLink(
					destination: { UserDetailView(model: UserDetailModel(id: user.id)) },
					label: {
						VStack {
							Text(user.username)
								.font(.body)
							Text(user.name)
								.font(.caption)
						}
					}
				)
			}
		}
		.onAppear {
			self.model.onAppear()
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					self.model.addUser()
				} label: {
					Text("Add")
				}
			}
		}
		.sheet(
			isPresented: self.$model.addUserIsPresented
		) {
			NavigationStack {
				AddUserView(model: AddUser())
			}
		}
	}
}

public class UserDetailModel: ObservableObject {
	let id: UUID
	let apiClient = APIClient.liveValue
	@Published var user: User?
	
	public init(id: UUID) {
		self.id = id
	}
	
	func onAppear() {
		Task { @MainActor in
			self.user = try await self.apiClient.getUser(id)
		}
	}
}

public struct UserDetailView: View {
	@ObservedObject var model: UserDetailModel
	
	public var body: some View {
		VStack {
			if let user = self.model.user {
				VStack {
					Text(user.username)
						.font(.body)
					Text(user.name)
						.font(.caption)
				}
			}
		}
		.onAppear {
			self.model.onAppear()
		}
	}
}

class AddUser: ObservableObject {
	let apiClient = APIClient.liveValue
	@Environment(\.dismiss) var dismiss
	
	@Published var user = User(name: "", username: "")
	
	func addUser() {
		Task { @MainActor in
			try await self.apiClient.createUser(self.user)
			self.dismiss()
		}
	}
}

struct AddUserView: View {
	@ObservedObject var model: AddUser
	@Environment(\.dismiss) var dismiss
	
	var body: some View {
		Form {
			TextField("", text: self.$model.user.username)
			TextField("", text: self.$model.user.name)
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					self.model.addUser()
				} label: {
					Text("Add User")
				}
			}
		}
	}
}
