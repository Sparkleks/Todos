//
//  Todo.swift
//  Todos
//
//  Created by Gheorghianu Alexandru on 5/8/20.
//  Copyright © 2020 Gheorghianu Alexandru. All rights reserved.
//

import Foundation

final internal class Todo {

    // Can't init is singleton
    private init() { listTodo = loadItems() }
    static let shared: Todo = Todo()
    
    var listTodo: [ItemTodo] = []
    
    func save() {
        let items: [ItemTodo] = listTodo
        let data = items.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: "SavedTodoList")
    }

    func loadItems() -> [ItemTodo] {
        guard let encodedData = UserDefaults.standard.array(forKey: "SavedTodoList") as? [Data] else {
            return []
        }

        return encodedData.map { try! JSONDecoder().decode(ItemTodo.self, from: $0) }
    }
    
}
