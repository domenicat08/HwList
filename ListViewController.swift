//
//  ListViewController.swift
//  List
//
//  Created by Domenica Torres on 5/5/22.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
     
    var task: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "delete", style: .done, target: self, action: #selector(deleteHomework))

        // Do any additional setup after loading the view.
    }
    
    @objc func deleteHomework (){
        
        
    }
  
}
