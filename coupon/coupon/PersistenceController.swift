//
//  PersistenceController.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/09/06.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CardModel") // モデル名
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data store: \(error)")
            }
        }
    }
}
