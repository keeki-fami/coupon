//
//  bellView.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/09/14.
//

import SwiftUI

struct BellView: View {
    var body: some View {
        Text("notification centerです")
        
        Button("12:05に通知が送られます。") {
            scheduleNotification(
                date: Date(),
                coupon: "couponName",
                id: UUID().uuidString
            )
        }
    }
}
