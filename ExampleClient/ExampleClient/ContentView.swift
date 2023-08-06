import APIClient
import Models
import SwiftUI



class ContentModel: ObservableObject {
	let apiClient = APIClient.liveValue
	
	@Published var tab: Tab
	
	public init(tab: Tab = .users) {
		self.tab = tab
	}
	
	@Published var acronyms: [Acronym] = []
	@Published var acronym: Acronym?
	@Published var searchIsPresented = false
	@Published var data = Data()
	
	func task() async {
		Task { @MainActor in
			do {
				self.data = try await self.apiClient.download()
			} catch {
				print(error.localizedDescription)
			}
			
			
			
//			for try await line in try await self.apiClient.getTicker("AAPL") {
//				print(line)
//			}
//			
			
//			let (bytes, response) = try await URLSession.shared.bytes(for: URLRequest(url: URL(string: "http://localhost:8080/littlejohn/ticker?AAPL")!))
//
//			for try await line in bytes.lines {
//			  print(line)
//			}
			
//			self.acronyms = try await self.apiClient.getAcronyms()
//			if let acronym = self.acronyms.last {
//				self.acronym = try await self.apiClient.getAcronym(acronym.id)
//			}
		}
	}
	
	func deleteAcronyms(_ indexSet: IndexSet) {
		Task {
			for index in indexSet {
				try await self.apiClient.deleteAcronym(self.acronyms[index])
			}
		} 
	}
	
	func search() {
		self.searchIsPresented = true
	}
}

struct ContentView: View {
	@ObservedObject var model: ContentModel = ContentModel()
	
	var body: some View {
		TabView(selection: self.$model.tab) {
			NavigationStack {
				UsersView(
					model: UsersModel()
				)
			}
			.tabItem { Text("Users") }
			.tag(Tab.users)
			
			VStack {
				FilePreview(fileData: self.model.data)
			}
			.tabItem { Text("Acronyms") }
			.tag(Tab.acronyms)
			
			Text("Categories")
				.tabItem { Text("Categories") }
				.tag(Tab.categories)
		}
//		NavigationStack {
//			List {
//				ForEach(self.model.acronyms) { acronym in
//					NavigationLink(
//						destination: {
//							FormView(model: FormModel(acronym: acronym))
//						}, label: {
//							HStack {
//								Text(acronym.short)
//								Spacer()
//								Text(acronym.long)
//							}
//						}
//					)
//				}
//				.onDelete { indexSet in
//					self.model.deleteAcronyms(indexSet)
//				}
//			}
//			.navigationDestination(
//				isPresented: self.$model.searchIsPresented,
//				destination: { SearchView(model: SearchModel()) }
//			)
//			.toolbar {
//				ToolbarItem(placement: .bottomBar) {
//					if let acronym = self.model.acronym {
//						HStack {
//							Text(acronym.short)
//							Spacer()
//							Text(acronym.long)
//						}
//					}
//				}
//				ToolbarItem(placement: .primaryAction) {
//					Button {
//						self.model.search()
//					} label: {
//						Text("Search")
//					}
//				}
//			}
//
//		}
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

class SearchModel: ObservableObject {
	let apiClient = APIClient.liveValue
	@Published var acronyms: [Acronym] = []
	
	func search() {
		Task { @MainActor in
			self.acronyms = try await self.apiClient.searchAcronym("What The Fudge")
		}
	}
}

struct SearchView: View {
	@ObservedObject var model: SearchModel
	
	var body: some View {
		List {
			ForEach(self.model.acronyms) { acronym in
				HStack {
					Text(acronym.short)
					Spacer()
					Text(acronym.long)
				}
			}
		}
		.onAppear {
			self.model.search()
		}
	}
}

struct FilePreview: View {
  let fileData: Data
  var body: some View {
	 Section("Preview") {
		VStack(alignment: .center) {
		  if let image = UIImage(data: fileData) {
			 Image(uiImage: image)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(maxHeight: 200)
				.cornerRadius(10)
		  } else {
			 Text("No preview")
		  }
		}
	 }
  }
}
