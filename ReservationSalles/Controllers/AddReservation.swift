//
//  AddReservation.swift
//  ReservationSalles
//
//  Created by Mobelite-LABS on 7/26/19.
//  Copyright © 2019 Mobelite-LABS. All rights reserved.
//

import UIKit
import Firebase



class AddReservation: UITableViewController ,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    //Mark:Constants
    let gotosecondadd = "GoToSecondAdd"
    
    
  
    
    

    var user: User!
   let ref1 = Database.database().reference(withPath: "reservations")
    
    
    

    //Mark:properties
    
    
    var salles = [Salle]()
    
    var pickerData: [String] = []
    
    
    var LocalData : [String] = ["Monastir","Tunis","France"]
    
    
    var reservations = [Reservation]()
    var reservationsdate: [String] = [""]
    var reservationsstarttime: [String] = [""]
    var reservationsfinishtime: [String] = [""]
    var reservationsroomname: [String] = [""]
    
    var reservationsstarttime1: [String] = [""]
    var reservationsfinishtime1: [String] = [""]
    
    
    
    let ref = Database.database().reference(withPath: "salles")
    
    
    var selectedRoom : String?
    var selectedLocal: String?
    
    
    
    
    var key2 = ""
    var date1 = ""
    var starttime1 = ""
    var roomname1 = ""
    var finishtime1 = ""
    var local1 = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NextButton.layer.borderWidth = 3
        NextButton.layer.cornerRadius = 10
        NextButton.layer.borderColor = UIColor.darkGray.cgColor
        
        // Connect data:
        self.pickerview.delegate = self
        self.pickerview.dataSource = self
        
        self.PickerLocal.delegate = self
        self.PickerLocal.dataSource = self
        
        
        
        
        
        //for dispalying the picker view
        //retrieve data from firebase
        
        ref.observe(.value, with: { snapshot in
            
   
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot,
                    
                    let salle = Salle(snapshot: snapshot) {
                    
                    self.pickerData.append(salle.name)
                  
                }
                
            }

            self.pickerview.reloadAllComponents()
            
        })
     
 
    
        
        //getuser
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
        
            }
        
        
        
        
      
        //observing reservations data to retrieve date and time for comparing with textfields in add
        
        ref1.observe(.value, with: { snapshot in
            
 
            
            for child in snapshot.children {
               
               
                
                if let snapshot = child as? DataSnapshot,
                    
                    let reservation = Reservation(snapshot: snapshot) {
                    
                  
                    self.reservationsdate.append(reservation.date)
                    
                    
                    
                    self.reservationsstarttime.append(reservation.startTime)
                    
                   
                        
                    self.reservationsfinishtime.append(reservation.finishTime)
                    
                    
                    self.reservationsroomname.append(reservation.roomName)
                    
                    
                   // print("this is dates",reservation.date)
                   
                self.reservations.append(reservation)
                    
                }
              
            }
 
        })
    
    }


    
   
  
    
    
 //pickerview methods
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        if pickerView.tag == 1 {
            return pickerData.count
        } else {
            return LocalData.count
        }
    }
    
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
  
        if pickerView.tag == 1 {
            return pickerData[row]
        } else {
            return LocalData[row]
        }
        
        
    }
    
    
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //row is an integer -> pickerData[2]=france
        //store the selected variable into a string variable
        
        selectedRoom = pickerData[row]
        selectedLocal = LocalData[row]
    }
    
    
    
    
    //outlets
   
    
   
    
    @IBOutlet weak var pickerview: UIPickerView!
    
    @IBOutlet weak var DateTextfieldOutlet: UITextField!
    
    @IBOutlet weak var StartTimeTextFieldOutlet: UITextField!
    
    
    @IBOutlet weak var FinishTimeTextFieldOutlet: UITextField!
 
    
    @IBOutlet weak var NextButton: UIButton!
    
  
    @IBOutlet weak var PickerLocal: UIPickerView!
    
    
    
    
    //Actions
 
    
    @IBAction func BackButtontouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        print("back button touched")
    }
    
    
    
    
    
    //AddReservation
    
    @IBAction func NextButtonPressed(_ sender: Any) {
       
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
         let currentDate = formatter.string(from: Date())
       /*let date2 = formatter.date(from: DateTextfieldOutlet.text!)
        let resDate = formatter.string(from:  date2!)*/
        
        
        
        guard
            
            let date = DateTextfieldOutlet.text,
            let StartTime = StartTimeTextFieldOutlet.text,
             let FinishTime = FinishTimeTextFieldOutlet.text,
            let roomname = selectedRoom,
            let local = selectedLocal,
            
            date.count > 0,
            StartTime.count > 0,
            FinishTime.count > 0,
            roomname.count > 0,
            local.count > 0
        
            else {
                //  return print ("fields are empty")
                
                let alert = UIAlertController(title: "alert",
                                              message: "Please enter empty fields",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                return  self.present(alert, animated: true, completion: nil)
                
        }
        
        guard
            
          
            let StartTime1 = StartTimeTextFieldOutlet.text,
            let FinishTime1 = FinishTimeTextFieldOutlet.text,
          
            
            StartTime1 < FinishTime1
            
            else {
                //  return print ("fields are empty")
                
                let alert = UIAlertController(title: "alert",
                                              message: "Start time has to be smaller than finish time",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                return  self.present(alert, animated: true, completion: nil)
                
        }
        
  /*     guard
     
     let  date2 = DateTextfieldOutlet.text,
    //let date2 = formatter.date(from: DateTextfieldOutlet.text!),
      //  let resDate = formatter.string(from:  date2),
      
      currentDate.compare(date2) == .orderedAscending
            
            else {
         
                let alert = UIAlertController(title: "alert",
                                              message: "Choose a correct date",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                return  self.present(alert, animated: true, completion: nil)
                
        }*/
        
        
      let key1 = ref1.childByAutoId().key
        
        
        
        let reservation  = Reservation  (
            
           roomName: selectedRoom!,
           projectName: "",
           date: DateTextfieldOutlet.text!,
           startTime: StartTimeTextFieldOutlet.text!,
           finishTime: FinishTimeTextFieldOutlet.text!,
           members: "",
           description: "",
           type: "",
           addedByUser: self.user.email,
           local : selectedLocal!,
           key:key1!
      
            
            )
       

        
  /*     let formatter1 = DateFormatter()
        formatter1.dateFormat = "h:mm a"
        
        
        
        for i in 0...reservationsstarttime.count {
            
            
            let date1 = formatter1.date(from: StartTime)
            let resstartDate = formatter1.string(from: date1!)
            
            let date2 = formatter1.date(from: reservationsstarttime[i])
            print ("this is date2",date2!)
            let resstartDate1 = formatter1.string(from: date2!)
           
           print ("this is resstartDate1",resstartDate1)
            
            
            //  start time akber mn reservationsstarttime[i] w asgher mn reservationsfinishtime[i]
            if ( resstartDate.compare(resstartDate1) == .orderedAscending )  {
                
                reservationsstarttime1 = [reservationsstarttime[i]]
                
            }
        }
        
        
        
        for i in 0...reservationsfinishtime.count {
            
            let date2 = formatter1.date(from: FinishTime)
            let resstartDate1 = formatter1.string(from: date2!)
            
            let date3 = formatter1.date(from: reservationsfinishtime[i])
            
            print ("this is date3",date3!)
            
            let resstartDate2 = formatter1.string(from: date3!)
            
            print ("this is resstartDate2",resstartDate2)
            
            
            // finishtime akber mn reservationsstarttime[i] w asgher mn reservationsfinishtime[i]
            
            if (resstartDate2.compare(resstartDate1) == .orderedAscending ) {
                
                reservationsfinishtime1 = [reservationsfinishtime[i]]
                
            }
        }


       */
        
        
        
        
     //   if reservationsroomname.contains(selectedRoom!) && reservationsdate.contains(date) && (reservations.startTime < StartTime ) && (FinishTime < reservations.finishTime) &&   (reservations.startTime < FinishTime ) && (FinishTime < reservations.finishTime)  {
        
        
      if reservationsroomname.contains(selectedRoom!) && reservationsdate.contains(date) && reservationsstarttime.contains(StartTime) && reservationsfinishtime.contains(FinishTime) {
        
            let alert = UIAlertController(title: "alert",
                                          message: "this room is already reserved at that time",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            return  self.present(alert, animated: true, completion: nil)
            
            
        }
     
            
            
        
        else
        
        {
            
        let groceryItemRef = self.ref1.child(key1!)
        
        
     
        groceryItemRef.setValue(reservation.toAnyObject())
        
        
            key2 = key1!
            roomname1 = selectedRoom!
            date1 = DateTextfieldOutlet.text!
            starttime1 = StartTimeTextFieldOutlet.text!
            finishtime1 =  FinishTimeTextFieldOutlet.text!
            local1 = selectedLocal!
            
         
            print("key2=",key2)
            
         performSegue(withIdentifier: gotosecondadd, sender: nil)
        
    }
    
    }
    
    
    
  //passing key parameter to next add
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToSecondAdd"{
            
           // let indexPath = sender as! IndexPath
            let destViewController = segue.destination as! UINavigationController
            
            let destinationViewController = destViewController.viewControllers.first as! SecondAddReservation
            
            print("key2 between segue",key2)
            
            destinationViewController.key3 = self.key2
            destinationViewController.date = self.date1
            destinationViewController.starttime = self.starttime1
            destinationViewController.finishtime = self.finishtime1
            destinationViewController.roomname = self.roomname1
            destinationViewController.localdest = self.local1
            
            
            print("okkkkk",key2)

        }
    }

   
    
    
  
      //datepicker
    @IBAction func DateTextEditing(_ sender: UITextField) {
        //This code will initialise datepicker & set its mode to select date. After that set datepicker as textfields input view
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
       
       //self.datePickerView.minimumDate = currentDate;
    }
    

     //add code that will trigger method when datepicker value is changed. Add following method
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        DateTextfieldOutlet.text = dateFormatter.string(from: sender.date)
    }

    
 
    
    
    
    //time pickers
    
    
    
    
    
    @IBAction func StartTimeTextEditing(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(handleTimePicker(sender:)), for: .valueChanged)
    }
    
    
    
 
    
    
    @IBAction func FinishTimeTextEditing(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(handleTimePicker1(sender:)), for: .valueChanged)
       
    }
    
    
    
    
    
  @objc func handleTimePicker(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        StartTimeTextFieldOutlet.text = formatter.string(from: sender.date)
        
    }
    
    @objc func handleTimePicker1(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        FinishTimeTextFieldOutlet.text = formatter.string(from: sender.date)
        
    }
}
