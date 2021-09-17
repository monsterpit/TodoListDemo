//
//  TodoListItem+CoreDataProperties.swift
//  TodoList
//
//  Created by Vikas S on 17/09/21.
//
//

import Foundation
import CoreData


extension TodoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoListItem> {
        return NSFetchRequest<TodoListItem>(entityName: "TodoListItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var createdAt: String?

}

extension TodoListItem : Identifiable {

}
