//
//  couponApp.swift
//  coupon
//
//  main
//

import SwiftUI

@main
struct couponApp: App {
    @StateObject private var isEditView = IsEditView()
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(isEditView)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
