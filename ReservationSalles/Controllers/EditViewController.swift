//
//  EditViewController.swift
//  ReservationSalles
//
//  Created by Mobelite-LABS on 8/13/19.
//  Copyright © 2019 Mobelite-LABS. All rights reserved.
//

import UIKit
import Firebase


class EditViewController: UITableViewController {
    
    let gotomyreservations = "gotomyreservations"
    
    
    //Mark:Properties
  

    
    
   let ref1 = Database.database().reference(withPath: "reservations")
   
    var roomname = ""
    var date = ""
    var starttime = ""
    var finishtime = ""
    var key3 = ""
    var members = ""
    var localdest = ""
    var type = ""
    var desc = ""
    var projectname = ""
    
    
    var user: User!

  
    //outlets
    
    
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var NameOutlet: UILabel!
    @IBOutlet weak var DateTextfield: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var FinishTimeTextfield: UITextField!
    @IBOutlet weak var EditButtonOutlet: UIButton!
    
    
    
    //Actions
    
    @IBAction func EditDate(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
   
    
 
    @IBAction func EditStarttime(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(handleTimePicker(sender:)), for: .valueChanged)
    }
    
    @IBAction func EditFinishtime(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(handleTimePicker1(sender:)), for: .valueChanged)
    }
    
   
    @IBAction func EditButtonDidtouch(_ sender: Any) {
        
        
        let reservation  = Reservation(
            
            roomName: roomname,
            projectName: projectname,
            date: DateTextfield.text!,
            startTime: startTimeTextField.text!,
            finishTime: FinishTimeTextfield.text!,
            members:  members,
            description: desc,
            type: type,
            addedByUser: self.user.email,
            local : localdest,
            key: key3
            
            
        )
        
        let groceryItemRef = self.ref1.child(key3)
        
        
        
        groceryItemRef.setValue(reservation.toAnyObject())
        
        
        
        performSegue(withIdentifier: gotomyreservations, sender: nil)
        
        
        
    }
    
    
    @IBAction func BackButtonDidTouch(_ sender: Any) {
      dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //getuser
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            
        }
        
        
     NameOutlet.text = roomname
    DateTextfield.text = date
    startTimeTextField.text = starttime
    FinishTimeTextfield.text = finishtime
        
        
        
        EditButtonOutlet.layer.borderWidth = 3
        EditButtonOutlet.layer.cornerRadius = 10
        EditButtonOutlet.layer.borderColor = UIColor.darkGray.cgColor
    
    }


    @objc func handleDatePicker(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        DateTextfield.text = dateFormatter.string(from: sender.date)
    }


    
    @objc func handleTimePicker(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        startTimeTextField.text = formatter.string(from: sender.date)
        
    }
    
    @objc func handleTimePicker1(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        FinishTimeTextfield.text = formatter.string(from: sender.date)
        
    }
    
}
