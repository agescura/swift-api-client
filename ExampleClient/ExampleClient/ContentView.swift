import APIClient
import Models
import SwiftUI

class ContentModel: ObservableObject {
	let apiClient = APIClient.liveValue
	
	@Published var fruit: Fruit?
	
	func task() async {
		Task { @MainActor in
			self.fruit = try await self.apiClient.fruit("Banana")
		}
	}
}

struct ContentView: View {
	@ObservedObject var model: ContentModel = ContentModel()
	
	var body: some View {
		NavigationStack {
			VStack {
				Text("\(self.model.fruit?.id ?? 0)")
				Text(self.model.fruit?.family ?? "")
				Text(self.model.fruit?.order ?? "")
			}
			.navigationTitle(self.model.fruit?.name ?? "")
		}
		.task { await self.model.task() }
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
