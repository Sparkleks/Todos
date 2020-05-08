//
//  ItemTodoCell.swift
//  Todos
//
//  Created by Gheorghianu Alexandru on 5/7/20.
//  Copyright © 2020 Gheorghianu Alexandru. All rights reserved.
//

import UIKit

class ItemTodoCell: UITableViewCell {
    
    static let kIdentifierCell = "cell"
    @IBOutlet private var checkBtn: UIButton?
    @IBOutlet private var itemText: UILabel?
    var item: ItemTodo? {
        didSet {
            itemText?.text = item?.text
            checkBtn?.isSelected = item?.check ?? false
            strikethroughStyle(item?.check ?? false)
        }
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        itemText?.attributedText = nil
        checkBtn?.isSelected = false
    }
    
    @IBAction func checkItem(_ button: UIButton) {
        button.isSelected = !button.isSelected
        strikethroughStyle(button.isSelected)
        Todo.shared.listTodo[tag].check = button.isSelected
    }
    
    func strikethroughStyle(_ done: Bool) {
        if let text = itemText?.text {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: done ? 2 : 0, range: NSMakeRange(0, attributeString.length))
            itemText?.attributedText = attributeString
        }
    }
        
}
