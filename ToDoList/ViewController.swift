//
//  ViewController.swift
//  ToDoList
//
//  Created by Daniel Warner on 10/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var itemTextField:UITextField!
    @IBOutlet weak var tableView:UITableView!
    let todoList = TodoList()
    var selectedItem: TodoItem?
    
    static let MAX_TEXT_SIZE = 50
    
    
    
    @IBAction func addButtonPressed(sender: UIButton){
        print("agregando un elemento a la lista: \(itemTextField.text)")
        let todoItem = TodoItem()
        todoItem.todo = itemTextField.text
        todoList.addItem(todoItem)
        tableView.reloadData()
        self.itemTextField.text = nil
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
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedItem = self.todoList.getItem(indexPath.row)
        self.performSegueWithIdentifier("showItem", sender: self)
       /* let detailVC = DetailViewController()
        detailVC.item = self.selectedItem
        self.navigationController?.pushViewController(detailVC, animated: true)*/
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detailViewController = segue.destinationViewController as? DetailViewController {
            detailViewController.item = self.selectedItem
            detailViewController.todoList = self.todoList
        }
    }

    //MARK: TextFieldDelegate Methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let tareaString = textField.text as? NSString {
            let updatedString = tareaString.stringByReplacingCharactersInRange(range, withString: string)
            return updatedString.characters.count <= ViewController.MAX_TEXT_SIZE
        }
        else{
            return true
        }
    }

}

