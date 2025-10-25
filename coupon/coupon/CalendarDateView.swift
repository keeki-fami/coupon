//
//  CalendarDateView.swift
//  coupon
//
//  Created by 櫻田聖和 on 9/22/25.
//
import SwiftUI

struct CalendarDateView: View {
    @Binding var selection:Int    // 選択値と連携するプロパティ
    
    var body: some View {
        //Form {
            Picker("フルーツを選択", selection: $selection) {
                /// 選択項目の一覧
                Text(String(localized: "CalendarDateViewOneDayBefore")).tag(1)
                Text(String(localized: "CalendarDateViewTwoDayBefore")).tag(2)
                Text(String(localized: "CalendarDateViewThreeDayBefore")).tag(3)
                Text(String(localized: "CalendarDateViewFourDayBefore")).tag(4)
                Text(String(localized: "CalendarDateViewFiveDayBefore")).tag(5)
                Text(String(localized: "CalendarDateViewSixDayBefore")).tag(6)
                Text(String(localized: "CalendarDateViewSevenDayBefore")).tag(7)
            }
            .pickerStyle(.wheel)
        //}
    }
}
