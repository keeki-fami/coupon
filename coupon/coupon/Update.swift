

import SwiftUI

class Update {
    private var currentVersion: String?
    private var newVersion: String?
    
    init() {
        currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    
    func fetchLatestVersion(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://itunes.apple.com/lookup?bundleId=com.keeki.coupon") else {
            completion()
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let results = json["results"] as? [[String: Any]],
                  let appInfo = results.first,
                  let appStoreVersion = appInfo["version"] as? String else {
                completion()
                return
            }
            
            self.newVersion = appStoreVersion
            completion()
        }
        
        
        task.resume()
        
    }
    
    func compareVersion() -> Bool {
        guard let current = currentVersion else {
            print("・現在のバージョンを取得できない")
            print("・currentVersion:\(currentVersion)")
            return false
        }
        
        guard let new = newVersion else {
            print("・最新のバージョンを取得できない")
            print("・newVersion:\(newVersion)")
            return false
        }
        
        if current != new {
            print("最新版がある:new=\(new),current=\(current)")
            return true
        } else {
            print("取得に成功したが、最新版はない。")
            return false
        }
    }
    
}
