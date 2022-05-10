//
//  EntryViewController.swift
//  List
//
//  Created by Domenica Torres on 5/5/22.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    //user will enter the task of the homework
    
    @IBOutlet var field: UITextField!
    
    //updating the table view by creating a var
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        //add a button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveList))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveList()
        
        return true
    }
    
    @objc func saveList() {
        //save the content
        //make sure field is not empty
        
        guard let text = field.text, !text.isEmpty else {
            return
        }
        //increment the number by 1 and save the homework
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        
        //save the homwework task
        UserDefaults().set(text, forKey: "homework_ \(newCount)")
        
        //call the update button
        update?()
        //dismiss view controller
        navigationController?.popViewController(animated: true)
        
    }

}
