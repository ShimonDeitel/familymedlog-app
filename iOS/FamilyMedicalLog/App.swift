import SwiftUI

@main
struct FamilyMedicalLogApp: App {
    @StateObject private var store = Store()
    @StateObject private var purchaseManager = PurchaseManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environmentObject(purchaseManager)
                .preferredColorScheme(.dark)
        }
    }
}
