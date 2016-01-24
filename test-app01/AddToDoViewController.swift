//
//  AddToDoViewController.swift
//  test-app01
//
//  Created by ds-131860 on 12.01.16.
//  Copyright (c) 2016 ds-131860. All rights reserved.
//

import UIKit
import CoreData

class AddToDoViewController: UIViewController {
    
    
    @IBOutlet weak var outlet_textfield_title: UITextField!
    @IBOutlet weak var outlet_textfield_desc: UITextField!
    @IBOutlet weak var outlet_datepicker: UIDatePicker!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // do not allow dates in past
        outlet_datepicker.minimumDate = NSDate()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
     * Function to manage first responder
     */
    @IBAction func resignKeyboard(sender: AnyObject) {
        if(sender as! NSObject == outlet_textfield_title){
            // input field 'title resigns first responder
            sender.resignFirstResponder()
            // input field 'description' gets first responder
            outlet_textfield_desc.becomeFirstResponder()
        }
        else {
            // input field 'description' resigns first responder
            sender.resignFirstResponder()
         }
    } 
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    /**
     * User clicked save button - save input data in core data
     */
    @IBAction func clicked_save_button(sender: UIButton) {
        // verify if user entered a title for this ToDo
        if(outlet_textfield_title.text == ""){ // no input - show alert
            let alertController = UIAlertController(title: "ERROR", message: "ToDo Title is missing", preferredStyle: .Alert);
            alertController.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil);
        }
        else {
            // save data
            
            let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
            let context:NSManagedObjectContext! = appDel.managedObjectContext;
            
            let todo_item = NSEntityDescription.insertNewObjectForEntityForName("ToDoEntity", inManagedObjectContext: context) ;
            
            // get user input
            todo_item.setValue(outlet_textfield_title.text, forKey: "todo_title");
            todo_item.setValue(outlet_textfield_desc.text, forKey: "todo_desc");
            todo_item.setValue(outlet_datepicker.date, forKey: "todo_date");
            
            // save data persistent
            do {
                try  todo_item.managedObjectContext?.save()
                
                // show alert to notify user about successfull save
                let alertController = UIAlertController(title: "", message: "saved ToDo", preferredStyle: .Alert);
                alertController.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil);
            }
            catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
                
                // show alert to notify user about error
                let alertController = UIAlertController(title: "Error", message: "could not save ToDo", preferredStyle: .Alert);
                alertController.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil);
            }

            
            // reset user input in GUI
            outlet_textfield_title.text = ""
            outlet_textfield_desc.text = ""
            outlet_datepicker.date = NSDate()
        }
        
   }
}
