//
//  SecondAddReservation.swift
//  ReservationSalles
//
//  Created by Mobelite-LABS on 7/26/19.
//  Copyright © 2019 Mobelite-LABS. All rights reserved.
//

import UIKit
import Firebase
import Toast_Swift



class SecondAddReservation: UITableViewController,UIPickerViewDataSource,UIPickerViewDelegate{
    
    
   let gotomain = "gotomain"
   
    
    //Mark:Properties
    
     var key3 = ""
    var date = ""
    var starttime = ""
    var finishtime = ""
    var roomname = ""
    var localdest = ""
    
    
      var user: User!
    
    
    
     let ref1 = Database.database().reference(withPath: "reservations")
    
    var selectedType : String?
    
    

    
    var pickerData: [String] = ["Demo","Backlog grooming","Daily","Retrospective","Technical debt","Team monotoring","Trainees monotoring","Other"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

      print("hello3 this is view didload")
        
        AddButton.layer.borderWidth = 3
        AddButton.layer.cornerRadius = 10
        AddButton.layer.borderColor = UIColor.darkGray.cgColor
        
        
        print("key3=",key3 )
        

        
        // Connect data:
        self.pickerviewoutlet.delegate = self
        self.pickerviewoutlet.dataSource = self
 

        
        //getuser
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            
        }
        
        
    }
        


    
    //outlets
    
    
    @IBOutlet weak var AddButton: UIButton!
    
    @IBOutlet weak var pickerviewoutlet: UIPickerView!
    
    @IBOutlet weak var membersoutlet: UITextView!
    
    @IBOutlet weak var descriptionoutlet: UITextView!
    
    @IBOutlet weak var projectnameoutlet: UITextView!
    
    
    //actions
    
 @IBAction func AddButtonPressed(_ sender: Any) {
    
    
    
    guard
        let members = membersoutlet.text,
        let projectname = projectnameoutlet.text,
        let description = descriptionoutlet.text,
        let type = selectedType,
        members.count > 0,
        projectname.count > 0,
        description.count > 0,
        type.count > 0
        else {
            
            //  return print ("fields are empty")
            
            
            let alert = UIAlertController(title: "alert",
                                          message: "Please enter empty fields",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            return  self.present(alert, animated: true, completion: nil)
            
    }
    
    
    let reservation  = Reservation(
        
        roomName: roomname,
        projectName: projectnameoutlet.text!,
        date: date,
        startTime: starttime,
        finishTime: finishtime,
        members:  membersoutlet.text!,
        description: descriptionoutlet.text!,
        type: selectedType!,
        addedByUser: self.user.email,
        local : localdest,
        key: key3
        
        
    )
    
 
        let groceryItemRef = self.ref1.child(key3)
        
        
        
        groceryItemRef.setValue(reservation.toAnyObject())
    
    
        
     performSegue(withIdentifier: gotomain, sender: nil)
    
    
    
    //toast with extension
    //showToast(message: "add success", font: UIFont (name: "Helvetica Neue", size: 30)!)
    
    
    //toast with cocoapoads
    //self.view.makeToast("success add!")
  //  self.view.makeToast("This is a piece of toast", duration: 10, position: .bottom)
    
  //showToast(controller: self, message: "success add!", seconds: 3)
   
    
        
   // var style = ToastStyle()
   // style.messageColor = .blue
   // self.view.makeToast("success add!", duration: 0.8, position: .bottom, style: style)
    
   
    }
    
    
    
    @IBAction func BackButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
 
    
    
    

    
    //Picker view methods
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //row is an integer -> pickerData[2]=france
        //store the selected variable into a string variable
        
        selectedType = pickerData[row]
        
    }
   
    
    
    func showToast(controller: UIViewController, message : String, seconds: Double){
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    

    
}







/*extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5, delay: 5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }*/
