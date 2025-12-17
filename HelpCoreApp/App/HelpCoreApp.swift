import SwiftUI

@main
struct HelpCoreApp: App {
    @StateObject private var store = CharityDataStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
