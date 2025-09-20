//
//  CalendarLimitView.swift
//  coupon
//
//  Created by 櫻田聖和 on 9/20/25.
//

import SwiftUI

struct CalendarListView: View {
    @Binding var limit:Date
    var body: some View {
        DatePicker("", selection: $limit, displayedComponents: .hourAndMinute)
            .datePickerStyle(.wheel)
            .padding()
    }
}
