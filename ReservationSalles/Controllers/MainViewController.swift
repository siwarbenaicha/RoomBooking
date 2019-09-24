//
//  MainViewController.swift
//  ReservationSalles
//
//  Created by Mobelite-LABS on 7/15/19.
//  Copyright © 2019 Mobelite-LABS. All rights reserved.
//

import UIKit
import Firebase




class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource{

    
    
 
    
    

    
    //Mark:properties
    var reservations = [Reservation]()
    var reservations1 = [Reservation]()
    var reservations2 = [Reservation]()
    var reservations3 = [Reservation]()

    
    
    var user: User!
    
  
    let ref = Database.database().reference(withPath: "reservations")
    
    
    
    //Displaying a List of Online Users
    let usersRef = Database.database().reference(withPath: "online")
    
    var selectedLocal : String?
   
   // var selectedDate : String?
    
   
    
    //constants

     var pickerData: [String] = ["Monastir","Tunis","France"]
    

   
 let searchController = UISearchController(searchResultsController: nil)
 var filteredReservations = [Reservation]()
    
    
    //Mark:Lifecycle
    
    
    override func viewDidLoad() {
        
       // getCurrentDateTime()
        
       //print( "hellooooooo",(findDateDiff(time1Str: "02:31 PM",time2Str: "04:30 PM")))
       // print( "hellooooooo",(findDateDiff(time1Str: "04:31 PM",time2Str: "02:30 PM")))
        // print( "hellooooooo",(findDateDiff(time1Str: "04:31 PM",time2Str: "04:31 PM")))
        

        
    //DatePicker
        
  /*      DatePicker.datePickerMode = UIDatePicker.Mode.date
        
        DatePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        

        
   //customize date picker
    
        //with hex to uicolor converter
        DatePicker.backgroundColor = UIColor(red:0.92, green:1.00, blue:1.00, alpha:1.0)
        DatePicker.setValue(UIColor.green, forKeyPath: "textColor")
        DatePicker.setValue(0.8, forKeyPath: "alpha")
        
  */
     
        
        
    //UIserach controller
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter Date"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    Tableview.tableHeaderView = searchController.searchBar
        searchController.searchBar.backgroundColor = UIColor(red:0.92, green:1.00, blue:1.00, alpha:1.0)
        searchController.searchBar.tintColor = UIColor(red:0.92, green:1.00, blue:1.00, alpha:1.0)
        
        
        super.viewDidLoad()

        //Buttons configuration
        
        LogoutButton.layer.borderWidth = 3
        LogoutButton.layer.cornerRadius = 10
        LogoutButton.layer.borderColor = UIColor.darkGray.cgColor
        
        AddButton.layer.borderWidth = 3
        AddButton.layer.cornerRadius = 30
        AddButton.layer.borderColor = UIColor.darkGray.cgColor
       
        
        
        
        
        
        // Connect data:
        self.Picker.delegate = self
        self.Picker.dataSource = self
        
        // Input the data into the array
       //   pickerData = ["Monastir", "Tunis", "France"]
        
        
        
        
        
        
      
        
        //initialisation parametré du user bch nestaamalha mbaed fi addedbyUser mttee ay res ajouté (statique)
        user = User(uid: "123", email: "benaichasiwar@gmail.com")
        
        
        
        
        
        
        //idakhel les champs then segue to the GroceryListTableViewController eli hia fel viewdidload mtee logincontroller
        //then When users add items, their email eli amlou bih login will show in the detail of the cell.
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)

        
        
            
            
            
            
            
            
        // 1
        //Create a child reference using a user’s uid, which is generated when Firebase creates an account.
        let currentUserRef = self.usersRef.child(self.user.uid)
        // 2
        //Use this reference to save the current user’s email.
        currentUserRef.setValue(self.user.email)
        // 3
        //Call onDisconnectRemoveValue() on currentUserRef. This removes the value at the reference’s location after the connection to Firebase closes, for instance when a user quits your app. This is perfect for monitoring users who have gone offline
        currentUserRef.onDisconnectRemoveValue()
        
      print(self.user.email)
        
        }

        
        
        
        
     //displaying reservations
       print("hiiiiiiiiii1")
        
        ref.observe(.value, with: { snapshot in
            
           var newReservations: [Reservation] = []
             var newReservations1: [Reservation] = []
             var newReservations2: [Reservation] = []
              var newReservations3: [Reservation] = []
            
            
            for child in snapshot.children {
                
                
                if let snapshot = child as? DataSnapshot,
                    
                    let reservation = Reservation(snapshot: snapshot) {
                    
                    
                    
                    let formatter = DateFormatter()
                   
                    
                    formatter.dateFormat = "dd MMM yyyy h:mm a"
                   
                    
                    let currentDate = formatter.string(from: Date())
                    
                    
                    let date = formatter.date(from: reservation.date+" "+reservation.finishTime)
                    // let Time = formatter.date(from: reservation.finishTime)
                    
                    let resDate = formatter.string(from: date!)
                    // let resTime = formatter.string(from: Time!)
                    
                    
                    
                    
                    if (reservation.local == "Monastir") && ( currentDate.compare(resDate) == .orderedAscending )  {
                        newReservations1.append(reservation)
                        
                    }
                        
                    else if (reservation.local == "France") && ( currentDate.compare(resDate) == .orderedAscending ) {
                        newReservations2.append(reservation)
                        
                    }
                        
                    else if (reservation.local == "Tunis") && ( currentDate.compare(resDate) == .orderedAscending ) {
                        newReservations3.append(reservation)
                        
                    }
                    
                    if (( currentDate.compare(resDate) == .orderedAscending ) )
                    { newReservations.append(reservation)
                    }
                    
                    print(reservation.date)
             
                   
                }
                print("reservations count=",self.reservations.count)
            }
            self.reservations = newReservations
            self.reservations1 = newReservations1
            self.reservations2 = newReservations2
            self.reservations3 = newReservations3

            self.Tableview.reloadData()
            
      print("Monastir",newReservations1)
            print("france",newReservations2)
            print("tunis",newReservations3)

        })
        
    
        
 
     
        
  
   /*     ref.observe(.value, with: { snapshot in
            
            // var newSalles: [Salle] = []
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot,
                    
                    let salle = Reservation(snapshot: snapshot) {
                    self.reservations.append(salle)
                }
                print("siwar ",self.reservations.count)
             
                
            }
            //  self.salles = newSalles

            // print(newSalles)
            
        })
      
*/
    }
    

    
//tableview lifecycle
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if isFiltering() {
            return filteredReservations.count
        }
        
       if(selectedLocal == "Monastir"){
    
        return reservations1.count
        }
       else if(selectedLocal == "France"){
            return reservations2.count
        }
       else if(selectedLocal == "Tunis"){
            return reservations3.count
        }
    return reservations.count
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath)
       
        let contentView = cell.viewWithTag(0)
        
         let nameroom = contentView?.viewWithTag(1) as! UILabel
         let date = contentView?.viewWithTag(2) as! UILabel
         let starttime = contentView?.viewWithTag(3) as! UILabel
         let finishtime = contentView?.viewWithTag(4) as! UILabel
        
      
        if isFiltering() {
           let reservation = filteredReservations[indexPath.row]
           
            nameroom.text = reservation.roomName
            date.text = reservation.date
            starttime.text = reservation.startTime
            finishtime.text = reservation.finishTime
            
            return cell
        
        }
        if(selectedLocal == "Monastir"){
            let reservation = reservations1[indexPath.row]
           
            nameroom.text = reservation.roomName
            date.text = reservation.date
            starttime.text = reservation.startTime
            finishtime.text = reservation.finishTime
            
            return cell
        }
        
        else if (selectedLocal == "France"){
            
            let reservation = reservations2[indexPath.row]
            nameroom.text = reservation.roomName
            date.text = reservation.date
            starttime.text = reservation.startTime
            finishtime.text = reservation.finishTime
            
            return cell
        }
        
        else if (selectedLocal == "Tunis"){
            
            let reservation = reservations3[indexPath.row]
            nameroom.text = reservation.roomName
            date.text = reservation.date
            starttime.text = reservation.startTime
            finishtime.text = reservation.finishTime
            
            return cell
        }
        // Configure the cell...
        let reservation = reservations[indexPath.row]
        
        nameroom.text = reservation.roomName
        date.text = reservation.date
        starttime.text = reservation.startTime
        finishtime.text = reservation.finishTime
        
        return cell
    }
    
    
    
    
   
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: indexPath)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetails"{
            
            
            let indexPath = sender as! IndexPath
         
            
             if isFiltering() {
            
                
                let reservation = filteredReservations[indexPath.row]
                
                let destinationViewController = segue.destination as? DetailsViewController
                
                destinationViewController?.roomname = reservation.roomName
                
                destinationViewController?.date = reservation.date
                
                destinationViewController?.starttime = reservation.startTime
                
                destinationViewController?.finishtime = reservation.finishTime
                
                destinationViewController?.addedbyuser = reservation.addedByUser
                
                destinationViewController?.projectname = reservation.projectName
                
                destinationViewController?.type = reservation.type
                
                destinationViewController?.members = reservation.members
                
                destinationViewController?.descriptionres = reservation.description
                
                destinationViewController?.local = reservation.local
                
            }
            
            if(selectedLocal == "Monastir"){


             let reservation = reservations1[indexPath.row]

            let destinationViewController = segue.destination as? DetailsViewController

            destinationViewController?.roomname = reservation.roomName

            destinationViewController?.date = reservation.date

            destinationViewController?.starttime = reservation.startTime

             destinationViewController?.finishtime = reservation.finishTime

             destinationViewController?.addedbyuser = reservation.addedByUser

             destinationViewController?.projectname = reservation.projectName

             destinationViewController?.type = reservation.type

             destinationViewController?.members = reservation.members

              destinationViewController?.descriptionres = reservation.description

            destinationViewController?.local = reservation.local
         }

            else if (selectedLocal == "France"){


                let reservation = reservations2[indexPath.row]

                let destinationViewController = segue.destination as? DetailsViewController

                destinationViewController?.roomname = reservation.roomName

                destinationViewController?.date = reservation.date

                destinationViewController?.starttime = reservation.startTime

                destinationViewController?.finishtime = reservation.finishTime

                destinationViewController?.addedbyuser = reservation.addedByUser

                destinationViewController?.projectname = reservation.projectName

                destinationViewController?.type = reservation.type

                destinationViewController?.members = reservation.members

                destinationViewController?.descriptionres = reservation.description

                destinationViewController?.local = reservation.local
            }

            else if (selectedLocal == "Tunis"){



                let reservation = reservations3[indexPath.row]

                let destinationViewController = segue.destination as? DetailsViewController

                destinationViewController?.roomname = reservation.roomName

                destinationViewController?.date = reservation.date

                destinationViewController?.starttime = reservation.startTime

                destinationViewController?.finishtime = reservation.finishTime

                destinationViewController?.addedbyuser = reservation.addedByUser

                destinationViewController?.projectname = reservation.projectName

                destinationViewController?.type = reservation.type

                destinationViewController?.members = reservation.members

                destinationViewController?.descriptionres = reservation.description

                destinationViewController?.local = reservation.local
            }
            
     
                //quand le user se connecte selectedlocal est nil car la valeur par defaut est nulle :var selectedLocal : String?
                //si nn on peut l'initialiser a monastir......
                // si on supp else if maadch yarjaa lel boucle w yabka yafichi fi details reservations kahaw
                
            else if (selectedLocal == nil){
                
            let reservation = reservations[indexPath.row]
            
            let destinationViewController = segue.destination as? DetailsViewController

            destinationViewController?.roomname = reservation.roomName

            destinationViewController?.date = reservation.date

            destinationViewController?.starttime = reservation.startTime

            destinationViewController?.finishtime = reservation.finishTime

            destinationViewController?.addedbyuser = reservation.addedByUser

            destinationViewController?.projectname = reservation.projectName

            destinationViewController?.type = reservation.type

            destinationViewController?.members = reservation.members

            destinationViewController?.descriptionres = reservation.description

            destinationViewController?.local = reservation.local
            }
            
        }
        
        
    }
    
    
    
    
    
    
    //outlets
    
    
    @IBOutlet weak var Picker: UIPickerView!
    
    @IBOutlet weak var LogoutButton: UIButton!
    
    
    @IBOutlet weak var AddButton: UIButton!
    
    
    @IBOutlet weak var Tableview: UITableView!
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    
    //Mark:Actions


    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        
        
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
            

        } catch (let error) {
            print("Auth sign out failed: \(error)")
            
        
        }
        
        print("before guard")
        guard(navigationController?.popToRootViewController(animated: true)) != nil
            
            else {print("you are signed out")
                return
        }
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
        
        selectedLocal = pickerData[row]
        print(selectedLocal!)
       
      
Tableview.reloadData()
    }
    
  
    
    
    
    
    
    
    //get current date and time
    
 /* func getCurrentDateTime() {
        
        let formatter = DateFormatter()
       // let formatter1 = DateFormatter()
        
       // formatter.dateStyle = .long
       // formatter.timeStyle = .medium
        formatter.dateFormat = "dd MMM yyyy h:mm a"
       // formatter1.dateFormat = "h:mm a"
        let str = formatter.string(from: Date())
        //let str1 = formatter1.string(from: Date())
     
    if (str.compare("06 aug 2019 05:01 PM") == .orderedAscending)
     { print ("true") } else { print ("false") }
        
        
        print(str)
        //print(str1)
    }*/
    
   /* func getSingle() {
     
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
     
     print("\(year):\(month):\(day):"
        
    }*/
    
    
 
    
    //DatePicker handler
    
 /*   @objc func handleDatePicker(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        selectedDate = dateFormatter.string(from: sender.date)
        
        print(selectedDate!)
        
    }
     */
 
    
    
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredReservations = reservations.filter({( reservation : Reservation) -> Bool in
            return reservation.date.lowercased().contains(searchText.lowercased())
        })
        
        Tableview.reloadData()
        
       // if filteredReservations.count == 0 {
        //    print ("no reservations matches your query")
       // }
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    


    
}






//UIsearchcontroller
extension MainViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
}
