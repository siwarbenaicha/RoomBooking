//
//  MyreservationsViewController.swift
//  ReservationSalles
//
//  Created by Mobelite-LABS on 8/4/19.
//  Copyright © 2019 Mobelite-LABS. All rights reserved.
//

import UIKit
import Firebase



class MyreservationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    //Mark:properties
    
      var user: User!
    
     let ref = Database.database().reference(withPath: "reservations")

       var reservations = [Reservation]()
    
//outlets
    

    @IBOutlet weak var Tableview: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)

    }
    
        
        
        
        //displaying reservations
    
        
        ref.observe(.value, with: { snapshot in
            
            var newReservations: [Reservation] = []
            
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
                    
                    
                    
                    if ( reservation.addedByUser) == self.user.email && (( currentDate.compare(resDate) == .orderedAscending ) ){
                        
                    newReservations.append(reservation)
                        
                    }
                }
              
            }
            self.reservations = newReservations
            
            self.Tableview.reloadData()
            
            
        })
        
        
    }
    
    


    
  //tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyReservation", for: indexPath)
        
        let contentView = cell.viewWithTag(0)
        
        let nameroom = contentView?.viewWithTag(1) as! UILabel
        let date = contentView?.viewWithTag(2) as! UILabel
        let starttime = contentView?.viewWithTag(3) as! UILabel
        let finishtime = contentView?.viewWithTag(4) as! UILabel
        let local = contentView?.viewWithTag(5) as! UILabel
        
        // Configure the cell...
        let reservation = reservations[indexPath.row]
        
        nameroom.text = reservation.roomName
        date.text = reservation.date
        starttime.text = reservation.startTime
        finishtime.text = reservation.finishTime
        local.text = reservation.local
        
        
        
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toEdit", sender: indexPath)
    }
    
  
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEdit" {
            
            
            let indexPath = sender as! IndexPath
        
                
                let reservation = reservations[indexPath.row]
                
                let destinationViewController = segue.destination as? EditViewController
                
                destinationViewController?.roomname = reservation.roomName
                
                destinationViewController?.date = reservation.date
                
                destinationViewController?.starttime = reservation.startTime
                
                destinationViewController?.finishtime = reservation.finishTime
            
               destinationViewController?.key3 = reservation.key
            
            destinationViewController?.members = reservation.members
            
            destinationViewController?.type = reservation.type

            destinationViewController?.projectname = reservation.projectName
            
            destinationViewController?.desc = reservation.description
            
            destinationViewController?.localdest = reservation.local

            
            


            
            
            
            }
            
            
    }
    
//for deleting an item
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //this method removes a grocery item from the local array using the index path’s row.
        //if editingStyle == .delete {
        //   items.remove(at: indexPath.row)
        //   tableView.reloadData()
        // }
        
        
        //Each GroceryItem has a Firebase reference property named ref, and calling removeValue() on that reference causes the listener you defined in viewDidLoad() to fire. The listener has a closure attached that reloads the table view using the latest data
        
        if editingStyle == .delete {
            let groceryItem = reservations[indexPath.row]
            groceryItem.ref?.removeValue()
        }
        
    }

 
    
    
    
    
    

    
    
}
