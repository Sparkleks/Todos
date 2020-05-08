//
//  TodosHeaderView.swift
//  Todos
//
//  Created by Gheorghianu Alexandru on 5/7/20.
//  Copyright © 2020 Gheorghianu Alexandru. All rights reserved.
//

import UIKit

protocol TodoAddToListDelegate {
    func addNewTodoItem(_ item: ItemTodo)
}

class TodosHeaderView: UITableViewHeaderFooterView {

    static let kHeaderViewReuseIdentifier = "header"
    static let kHeaderViewHeight: CGFloat = 50.0;
    var delegate: TodoAddToListDelegate?
    
}

extension TodosHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let itemText = textField.text {
            if textField.text != "" {
                delegate?.addNewTodoItem(ItemTodo(check: false, text: itemText))
                textField.text = ""
            }else{
                endEditing(true)
            }
            return true
        }else {
            endEditing(true)
            return false
        }
    }
    
}
