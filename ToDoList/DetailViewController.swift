//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Daniel Warner on 10/19/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var item: TodoItem?
    
    var todoList: TodoList?

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func addNotification(sender: UIBarButtonItem) {
        if let dateString = self.dateLabel.text {
            if let date = parseDate(dateString) {
                self.item?.dueDate = date
                self.todoList?.saveItems()
                scheduleNotification(self.item!.todo!, date: date)
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func scheduleNotification(message: String, date: NSDate){
        let localNotification = UILocalNotification()
        localNotification.fireDate = date
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = message
        localNotification.alertTitle = "Recuerda esta tarea!"
        localNotification.applicationIconBadgeNumber = 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("item \(item)")
        showItem()
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.addTarget(self, action: "toggleDatePicker")
        self.dateLabel.addGestureRecognizer(tapGestureRecognizer)
        self.dateLabel.userInteractionEnabled = true
        addGestureRecognizerToImage()
    }
    
    func addGestureRecognizerToImage() {
        let gr = UITapGestureRecognizer()
        gr.numberOfTapsRequired = 1
        gr.numberOfTouchesRequired = 1
        gr.addTarget(self, action: "rotate")
        self.imageView.userInteractionEnabled = true
        self.imageView.addGestureRecognizer(gr)
    }
    
    func rotate() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.y"
        animation.toValue = M_PI * 2.0
        animation.duration = 1
        animation.repeatCount = 10
        self.imageView.layer.addAnimation(animation, forKey: "rotateAnimation")
    }
    
    func showItem() {
        self.descriptionLabel.text = item?.todo
        if let date = item?.dueDate {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            self.dateLabel.text = formatter.stringFromDate(date)
        }
        if let img = item?.image {
            self.imageView.image = img
        }
    }
    
    func toggleDatePicker() {
        if self.datePicker.hidden {
            self.fadeInDatePicker()
        }
        else {
            self.fadeOutDatePicker()
        }
    }

    @IBAction func dateSelected(sender: UIDatePicker) {
        //print("fecha seleccionada \(sender.date)")
        self.dateLabel.text = formatDate(sender.date)
       // self.datePicker.hidden = true
        toggleDatePicker()
    }
    
    @IBAction func addImage(sender: UIBarButtonItem) {
        let imagePickerController = UIImagePickerController()
        //imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePickerController.delegate = self
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    
    func formatDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.stringFromDate(date)
    }
    
    func parseDate(string: String) -> NSDate? {
        let parser = NSDateFormatter()
        parser.dateFormat = "dd/MM/yyyy HH:mm"
        return parser.dateFromString(string)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Animaciones
    
    func fadeInDatePicker() {
        self.datePicker.alpha = 0
        self.datePicker.hidden = false
        UIView.animateWithDuration(1) { () -> Void in
            self.datePicker.alpha = 1
            self.imageView.alpha = 0
        }
    }
    
    func fadeOutDatePicker() {
        self.datePicker.alpha = 1
        self.datePicker.hidden = false
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.datePicker.alpha  = 0
            self.imageView.alpha = 1
            }) { (completed) -> Void in
                if completed {
                    self.datePicker.hidden = true
                }
                
        }
    }
    
    
    //MARK: Image Picker controller methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.item?.image = image
            self.todoList?.saveItems()
            self.imageView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    

}
