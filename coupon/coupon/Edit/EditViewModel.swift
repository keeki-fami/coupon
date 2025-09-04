//
//  EditViewModel.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/09/02.
//

import SwiftUI

class EditViewModel: ObservableObject {
    var companyList:[String]
    
    init() {
        // Todo : companyListのdecode処理
        self.companyList = ["セブンイレブン", "ローソン", "スターバックス", "ファミリーマート","セブン-イレブン"]
    }
    
    func extractCompany(from text: String) -> String? {
        
        let pattern = companyList.joined(separator: "|")
        
        guard let regex = try? Regex(pattern) else {
            fatalError("正規表現の作成に失敗")
        }

        // マッチ結果を配列で取得
        let matches = text.matches(of: regex).map { match in
            String(text[match.range])
        }

        print(matches) // ["セブンイレブン", "スターバックス"]
        
        if let lastMatches = matches.last {
            return lastMatches
        } else {
            return nil
        }
    }
    
    func extractDateRange(from text: String) -> String? {
        
        var jpResults:[String] = []
        var symbolResults:[String] = []
        /// O月O日に対する正規表現
        let jpPattern = #"(\d{1,2}月\d{1,2}日)"#
        /// O/Oまたは、O-Oに対する正規表現
        let symbolPattern = #"(\d{1,2}[/-]\d{1,2})"#
        
        let jpRegex = try? Regex(jpPattern)
        let symbolRegex = try? Regex(symbolPattern)
        
        if let jpregex = jpRegex {
            jpResults = text.matches(of: jpregex).map { match in
                String(text[match.range])
            }
        }
        if let symbolregex = symbolRegex {
            symbolResults = text.matches(of: symbolregex).map { match in
                String(text[match.range])
            }
        }
        
        if let lastJpResult = jpResults.last {
            return lastJpResult
        } else if let lastSymbolResult = symbolResults.last {
            return lastSymbolResult
        } else {
            return nil
        }
    }
}

