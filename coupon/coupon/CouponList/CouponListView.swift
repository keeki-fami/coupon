//
//  CouponListView.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/08/30.
//

import CoreData
import SwiftUI

struct CouponListView: View {
    let x: [Int] = [0,1,2,3,4,5]
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    ) private var coupons: FetchedResults<CardModel>
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    ForEach(coupons,id:\.self){coupon in
                        CardView(
                            companyName: coupon.companyName,
                            couponName: coupon.couponName,
                            limit: coupon.limit,
                            notes: coupon.notes,
                            selectedImage: coupon.selectedImage
                        )
                            .padding(10)
                    }
                }
            }
            .navigationTitle("クーポン")
        }
    }
    
    func fetchItems() -> [CardModel] {
        let request: NSFetchRequest<CardModel> = CardModel.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }

}
