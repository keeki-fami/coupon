//
//  AddCouponModel.swift
//  coupon
//
//  クーポン（カード）のモデル
//
import SwiftUI

class AddCouponModel: ObservableObject {
    @Published var couponName: String
    @Published var companyName: String
    @Published var limit: Date
    @Published var selectedImage: UIImage
    @Published var notes: String
    
    init() {
        self.couponName = ""
        self.companyName = ""
        self.limit = Date()
        self.selectedImage = UIImage(imageLiteralResourceName: "defaultImage")
        self.notes = ""
    }
    
    func setStart(limit:String?,
                  companyName:String?,
                  couponName:String?,
                  selectedImage:UIImage?) {
        if let companyname = companyName {
            self.companyName = companyname
        }
        if let couponname = couponName {
            self.couponName = couponname
        }
        if let image = selectedImage {
            self.selectedImage = image
        }
    }
    
    func addCoreDataToCard() {
        
    }
}
