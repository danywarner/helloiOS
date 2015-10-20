//
//  ViewController.swift
//  ToDoList
//
//  Created by Daniel Warner on 10/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var itemTextField:UITextField!
    @IBOutlet weak var tableView:UITableView!
    let todoList = TodoList()
    
    @IBAction func addButtonPressed(sender: UIButton){
        print("agregando un elemento a la lista: \(itemTextField.text)")
        todoList.addItem(itemTextField.text!)
        tableView.reloadData()
        self.itemTextField?.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = todoList
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableViewDelegate Methods
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.itemTextField?.resignFirstResponder()
    }


}

