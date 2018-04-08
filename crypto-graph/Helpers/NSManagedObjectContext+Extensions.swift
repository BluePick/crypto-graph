//
//  NSManagedObjectContext+Extensions.swift
//  crypto-graph
//
//  Created by Александр Пономарев on 26.02.18.
//  Copyright © 2018 Base team. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {

    func insertObject<A: NSManagedObject>() -> A where A: Managed {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else { fatalError("Wrong object type") }
        return obj
    }

    func saveOrRollback() -> Bool {
        do {
            try save()
            print("Save")
            return true
        } catch {
            rollback()
            print("Error: \(error.localizedDescription)")
            return false
        }
    }

    func performChanges(block: @escaping () -> ()) {
        perform {
            block()
            _ = self.saveOrRollback()
        }
    }
}
