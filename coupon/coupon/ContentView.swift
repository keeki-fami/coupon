//
//  ContentView.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/08/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            TabView{
                CouponListView()
                    .tabItem{
                        Text("List")
                    }
                AddCouponCard()
                    .tabItem{
                        Text("Add")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
