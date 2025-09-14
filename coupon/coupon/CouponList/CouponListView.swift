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
        sortDescriptors: [],
        animation: .default
    ) private var coupons: FetchedResults<CardModel>
    
    var body: some View {
        NavigationStack{
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
                                    deleteCard: {deleteCard(coupon:coupon)}
                                )
                                .padding(10)
                            }
                        }
                    }
                } else {
                    Text("クーポンを追加しましょう")
                        .foregroundStyle(.gray)
                        .padding()
                    Text("1:画面右下の「scan」をタップ")
                        .foregroundStyle(.gray)
                    HStack{
                        Text("2:")
                        Text(Image(systemName: "camera"))
                        Text("をタップ")
                    }
                        .foregroundStyle(.gray)
                    Text("3: 写真を撮ってクーポンをスキャン")
                        .foregroundStyle(.gray)
                    Text("4: 情報を入力して追加完了")
                        .foregroundStyle(.gray)
                    
                }
                
            }
            .navigationTitle("クーポン")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: BellView()) {
                        Image(systemName: "bell")
                    }
                }
            }
        }
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
