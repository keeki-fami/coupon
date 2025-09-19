//
//  CalendarView.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/09/08.
//

import SwiftUI

struct CalendarView: View {
    @Binding var limit:Date
    var body: some View {
        DatePicker("", selection: $limit, displayedComponents: .date)
            .datePickerStyle(.graphical)
            .padding()
    }
}
