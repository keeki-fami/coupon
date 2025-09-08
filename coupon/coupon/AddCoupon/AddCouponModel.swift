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
    
    func clean() {
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
        if let limitString = limit {
            let format = exactDateFormatter(stringDate: limitString)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            
            if let date = dateFormatter.date(from: limitString) {
                let calendar = Calendar.current
                
                let month = calendar.component(.month, from: date)
                let day = calendar.component(.day, from: date)
                let year = calendar.component(.year, from: Date())
                
                var components = DateComponents()
                components.year = year
                components.month = month
                components.day = day
                
                if let finalDate = calendar.date(from: components) {
                    self.limit = finalDate
                }
            }
        }
    }
}
