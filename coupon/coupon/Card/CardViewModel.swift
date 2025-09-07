//
//  CardViewModel.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/09/07.
//
import SwiftUI

func dateToString(date: Date?) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd"
    
    if let exactDate = date {
        return formatter.string(from:exactDate)
    } else {
        return nil
    }
    
}
