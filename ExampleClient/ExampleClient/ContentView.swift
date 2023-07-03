import APIClient
import Models
import SwiftUI

class ContentModel: ObservableObject {
	let apiClient = APIClient.liveValue
	
	@Published var acronyms: [Acronym] = []
	@Published var acronym: Acronym?
	
	func task() async {
		Task { @MainActor in
			self.acronyms = try await self.apiClient.getAcronyms()
			if let acronym = self.acronyms.last {
				self.acronym = try await self.apiClient.getAcronym(acronym.id)
			}
		}
	}
	
	func deleteAcronyms(_ indexSet: IndexSet) {
		Task {
			for index in indexSet {
				try await self.apiClient.deleteAcronym(self.acronyms[index])
			}
		}
	}
}

struct ContentView: View {
	@ObservedObject var model: ContentModel = ContentModel()
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(self.model.acronyms) { acronym in
					NavigationLink(
						destination: {
							FormView(model: FormModel(acronym: acronym))
						}, label: {
							HStack {
								Text(acronym.short)
								Spacer()
								Text(acronym.long)
							}
						}
					)
				}
				.onDelete { indexSet in
					self.model.deleteAcronyms(indexSet)
				}
			}
			.toolbar {
				ToolbarItem(placement: .bottomBar) {
					if let acronym = self.model.acronym {
						HStack {
							Text(acronym.short)
							Spacer()
							Text(acronym.long)
						}
					}
				}
			}
			
		}
		.task { await self.model.task() }
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class FormModel: ObservableObject {
	@Published var acronym: Acronym
	let apiClient = APIClient.liveValue
	
	init(acronym: Acronym) {
		self.acronym = acronym
	}
	
	func updateAcronym() {
		Task { @MainActor in
			print(try await self.apiClient.updateAcronym(self.acronym))
		}
	}
}

struct FormView: View {
	@ObservedObject var model: FormModel
	
	var body: some View {
		Form {
			TextField("Short", text: self.$model.acronym.short)
			TextField("Long", text: self.$model.acronym.long)
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					self.model.updateAcronym()
				} label: {
					Text("Update")
				}
			}
		}
	}
}
