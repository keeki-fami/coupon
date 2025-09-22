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
                Text("1日前").tag(1)
                Text("2日前").tag(2)
                Text("3日前").tag(3)
                Text("4日前").tag(4)
                Text("5日前").tag(5)
                Text("6日前").tag(6)
                Text("7日前").tag(7)
            }
            .pickerStyle(.wheel)
        //}
    }
}
