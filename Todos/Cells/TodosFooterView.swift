//
//  TodosFooterView.swift
//  Todos
//
//  Created by Gheorghianu Alexandru on 5/7/20.
//  Copyright © 2020 Gheorghianu Alexandru. All rights reserved.
//

import UIKit

class TodosFooterView: UITableViewHeaderFooterView {
    
    static let kFooterViewReuseIdentifier = "footer"
    static let kFooterViewHeight: CGFloat = 40.0;
    
    @IBOutlet private var itemsCount: UILabel?
    
    func setCountItems(_ count: Int) {
        itemsCount?.text = "\(count) items left"
    }
    
}
