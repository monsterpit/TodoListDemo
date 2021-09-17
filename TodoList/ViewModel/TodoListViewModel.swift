//
//  TodoListViewModel.swift
//  TodoList
//
//  Created by Vikas S on 17/09/21.
//

import Foundation

final class TodoListViewModel{
    private var context = PersistentStorage.shared.context
    var items = Box([TodoListItem]())
    
    init(selectIndex: Int = 0){
        getTodoList(selectIndex: selectIndex)
    }
    
    func getTodoList(selectIndex: Int){
        items.value = PersistentStorage.shared.getAllSearchedItems(searchText: getCreatedAt(index: selectIndex))
    }
    
    func addTask(title: String,desc: String?,selectIndex: Int){
        PersistentStorage.shared.createItem(title: title, desc: desc, createdAt: getCreatedAt(index: selectIndex))
        getTodoList(selectIndex: selectIndex)
    }
    
    func modifyTask(title: String,desc: String?,selectedItem: TodoListItem,selectIndex: Int){
        PersistentStorage.shared.updateItem(item: selectedItem, title: title, desc: desc)
        getTodoList(selectIndex: selectIndex)
    }
    
    func deleteTask(selectedItem: TodoListItem,selectIndex: Int){
        PersistentStorage.shared.deleteItem(item: selectedItem)
        getTodoList(selectIndex: selectIndex)
    }
    
    private func getCreatedAt(index selectIndex: Int) -> String{
        switch selectIndex{
        case 0:
            return Constants.today
        case 1:
            return Constants.tomorrow
        case 2:
            return Constants.upcoming
        default:
            return ""
        }
    }

    private struct Constants{
        static let today = "today"
        static let tomorrow = "tomorrow"
        static let upcoming = "upcoming"
    }
}

