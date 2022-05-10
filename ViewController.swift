//
//  ViewController.swift
//  List
//
//  Created by Domenica Torres on 5/1/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dateTF: UITextField!
    
    @IBOutlet var tableview: UITableView!
    
    //creating an array of strings that will hold all the homeworks the user will have
    var tasks = [String]() //calling it tasks

    override func viewDidLoad() {
        super.viewDidLoad()
        let datePicker = UIDatePicker ()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for:UIControl.Event.valueChanged)
        
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTF.inputView = datePicker
        dateTF.text = formatDate(date: Date())
        
        self.title = "Homeworks"
        
    tableview.delegate = self
    tableview.dataSource = self
        
        //setting up the machanism
        if !UserDefaults().bool(forKey: "setUp") {
            UserDefaults().set(true, forKey: "setUp")
            UserDefaults().set(0, forKey: "count") //number of homeworks
        }
        
        func dateChange(datePicker: UIDatePicker){
            dateTF.text = formatDate(date: datePicker.date)
            
        }
        
        func formatDate(date: Date) -> String
        {
            let formatter = DateFormatter ()
            formatter.dateFormat = "MMMM dd yyyy"
            return formatter.string(from: date)
        }

        updateHomeworks()
    }
    
        func updateHomeworks(){
            
            tasks.removeAll() //no showing duplicates
            
            guard let count = UserDefaults().value(forKey: "count") as? Int else {
                return
            }
            
            for x in 0..<count {
                
                if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                    tasks.append(task)
                }
                
            }
            tableview.reloadData()
        }
    
        @IBAction func didTapAdd(){
        //vc= view controller
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        vc.title = "New Homework"
        vc.update = {
            DispatchQueue.main.async { //prioritize updating the homework tasks
                self.updateHomeworks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }

}
    extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        //vc= view controller
        let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! ListViewController
        vc.title = "New Homework"
        vc.task = tasks[indexPath.row]
    
        navigationController?.pushViewController(vc, animated: true)
        }
    }


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
 }
