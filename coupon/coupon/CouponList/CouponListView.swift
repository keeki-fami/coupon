//
//  CouponListView.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/08/30.
//

import CoreData
import SwiftUI


struct CouponListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CardModel.limit, ascending: true)],
        animation: .default
    ) private var coupons: FetchedResults<CardModel>
    
    
    var body: some View {
        // NavigationStack{
            VStack{
                if coupons.count != 0 {
                    ScrollView{
                        VStack{
                            ForEach(coupons,id:\.self){coupon in
                                CardView(
                                    companyName: coupon.companyName,
                                    couponName: coupon.couponName,
                                    limit: coupon.limit,
                                    notes: coupon.notes,
                                    selectedImage: coupon.selectedImage,
                                    couponId: coupon.identifier,
                                    deleteCard: {deleteCard(coupon:coupon)}
                                )
                                .padding(10)
                            }
                        }
                    }
                } else {
                    Text(String(localized: "CouponListViewDescription_0"))
                        .foregroundStyle(.gray)
                        .padding()
                    Text(String(localized: "CouponListViewDescription_1"))
                        .foregroundStyle(.gray)
                    HStack{
                        Text(String(localized: "CouponListViewDescription_2-1"))
                        Text(Image(systemName: "camera"))
                        Text(String(localized: "CouponListViewDescription_2-2"))
                    }
                        .foregroundStyle(.gray)
                    Text(String(localized: "CouponListViewDescription_3"))
                        .foregroundStyle(.gray)
                    Text(String(localized: "CouponListViewDescription_4"))
                        .foregroundStyle(.gray)
                    // BannerViewContainer(adSize)
                      // .frame(width: adSize.size.width, height: adSize.size.height)
                }
                
            }
           // .navigationTitle("クーポン")
        //}
    }
    
    func deleteCard(coupon: CardModel) {
        viewContext.delete(coupon)
        try? viewContext.save()
    }
    
    //    func fetchItems() -> [CardModel] {
    //        let request: NSFetchRequest<CardModel> = CardModel.fetchRequest()
    //        do {
    //            return try viewContext.fetch(request)
    //        } catch {
    //            print("Fetch error: \(error)")
    //            return []
    //        }
    //    }
    
}
