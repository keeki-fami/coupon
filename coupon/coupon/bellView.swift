//
//  bellView.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/09/14.
//

import SwiftUI

struct BellView: View {
    @State private var isCalendar = false
    @State private var date: Date = Date()
    @AppStorage("notificationHour") private var hour: Int = 0
    @AppStorage("notificationMinute") private var minute: Int = 0
    var body: some View {
        Text("notification centerです")
        
        DatePicker("時間を選択", selection: $date, displayedComponents: .hourAndMinute)
            .datePickerStyle(.wheel)
        
        Button("登録") {
            let calendar = Calendar.current
            hour = calendar.component(.hour, from: date)
            minute = calendar.component(.minute, from: date)
        }
    }
}
