//
//  ViewController.swift
//  Todos
//
//  Created by Gheorghianu Alexandru on 5/7/20.
//  Copyright © 2020 Gheorghianu Alexandru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet fileprivate var tableView: UITableView!
    @IBOutlet private var keyboardHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        setupNavigation()
        setupTableView()
        observerForKeyoard()
    }
    
    func setupNavigation() {
        navigationItem.prompt = "Swift"
        title = "Todos"
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: "TodosHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: TodosHeaderView.kHeaderViewReuseIdentifier)
        self.tableView.register(UINib(nibName: "TodosFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: TodosFooterView.kFooterViewReuseIdentifier)
    }
    
    func observerForKeyoard() {
        // observer for Keyboards
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc private func keyboardWillShow(notification:NSNotification) {
        
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        if #available(iOS 11.0, *) {
            self.keyboardHeight.constant =  keyboardHeight - view.safeAreaInsets.bottom
        } else {
            self.keyboardHeight.constant =  keyboardHeight
        }

    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let animationDuration: TimeInterval = userInfo.object(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as! TimeInterval
        
        self.keyboardHeight.constant = 0;
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
        
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Todo.shared.listTodo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTodoCell.kIdentifierCell , for: indexPath) as! ItemTodoCell
        
        let item = Todo.shared.listTodo[indexPath.row]
        cell.item = item
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: TodosHeaderView.kHeaderViewReuseIdentifier) as? TodosHeaderView
        header?.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: TodosFooterView.kFooterViewReuseIdentifier) as? TodosFooterView
        footer?.setCountItems(Todo.shared.listTodo.count)
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return TodosHeaderView.kHeaderViewHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return TodosFooterView.kFooterViewHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        Todo.shared.listTodo.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        let footer = self.tableView.footerView(forSection: indexPath.section) as! TodosFooterView
        footer.setCountItems(Todo.shared.listTodo.count)
        print("Deleted")
      }
    }
    
}

extension ViewController: TodoAddToListDelegate {
    
    func addNewTodoItem(_ item: ItemTodo) {
        Todo.shared.listTodo.append(item)
        let footer = self.tableView.footerView(forSection: 0) as! TodosFooterView
        footer.setCountItems(Todo.shared.listTodo.count)
        self.tableView.insertRows(at: [IndexPath(item: Todo.shared.listTodo.count-1, section: 0)], with: .automatic)
    }
    
}
