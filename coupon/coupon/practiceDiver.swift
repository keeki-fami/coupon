//
//  practiceDiver.swift
//  coupon
//
//  Created by 櫻田聖和 on 9/18/25.
//

import SwiftUI

struct practiceDivider: View {
    var body: some View {
        ZStack{
            Rectangle()
            VStack(){
                HStack{
                    Text("aaa")
                        .padding(.horizontal)
                    Spacer()
                    Text("5本")
                        .padding(.horizontal)
                }
                Divider()
                HStack{
                    Text("bbb")
                        .padding(.horizontal)
                    Spacer()
                    Text("7本")
                        .padding(.horizontal)
                }
            }
            .frame(width:250)
            .background(Color.white)
            .cornerRadius(3)
            .shadow(color:.gray,radius:5,x:2,y:2)
            
        }
    }
}

#Preview {
    practiceDivider()
}
