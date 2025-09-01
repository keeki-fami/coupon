//
//  CouponListView.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/08/30.
//

import SwiftUI

struct CouponListView: View {
    let x: [Int] = [0,1,2,3,4,5]
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    ForEach(x,id:\.self){_ in
                        CardView()
                            .padding(10)
                    }
                }
            }
            .navigationTitle("クーポン")
        }
    }
}
