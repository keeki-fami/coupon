//
//  couponApp.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/08/29.
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
