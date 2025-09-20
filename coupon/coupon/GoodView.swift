//
//  GoodView.swift
//  coupon
//
//  Created by 櫻田聖和 on 9/19/25.
//

import SwiftUI

struct GoodView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .frame(width:100,height:70)
                .shadow(color: Color.black.opacity(0.5), radius: 2, x:2, y:2)
                .overlay(
                    Rectangle()
                        .stroke(.gray,lineWidth: 2)
                )
                
            Text("Good!")
                .foregroundColor(.black)
        }
    }
}
