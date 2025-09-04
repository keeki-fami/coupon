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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(isEditView)
        }
    }
}
