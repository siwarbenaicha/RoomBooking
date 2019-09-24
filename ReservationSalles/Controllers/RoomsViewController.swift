//
//  RoomsViewController.swift
//  ReservationSalles
//
//  Created by Mobelite-LABS on 8/13/19.
//  Copyright © 2019 Mobelite-LABS. All rights reserved.
//

import UIKit
import Firebase



class RoomsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
 
    var reservations = [Reservation]()
    
    
    let ref = Database.database().reference(withPath: "reservations")
    
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredReservations = [Reservation]()
    
    
    
    
    //outlets
    
    
    @IBOutlet weak var Tableview: UITableView!
    
    
    @IBOutlet weak var AddButton: UIButton!
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredReservations.count
        }
        
        
        return reservations.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomsdispo", for: indexPath)
        
        let contentView = cell.viewWithTag(0)
        
        let nameroom = contentView?.viewWithTag(1) as! UILabel
        let local = contentView?.viewWithTag(2) as! UILabel
        let date = contentView?.viewWithTag(3) as! UILabel
        let starttime = contentView?.viewWithTag(4) as! UILabel
        let finishtime = contentView?.viewWithTag(5) as! UILabel
        
        
        if isFiltering() {
            
            let reservation = filteredReservations[indexPath.row]
            
            nameroom.text = reservation.roomName
            local.text = reservation.local
            date.text = reservation.date
            starttime.text = reservation.startTime
            finishtime.text = reservation.finishTime
            
            return cell
    }
    
        let reservation = reservations[indexPath.row]
        
        nameroom.text = reservation.roomName
        local.text = reservation.local
        date.text = reservation.date
        starttime.text = reservation.startTime
        finishtime.text = reservation.finishTime
        
        return cell
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UIserach controller
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter room name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        Tableview.tableHeaderView = searchController.searchBar
        searchController.searchBar.backgroundColor = UIColor(red:0.92, green:1.00, blue:1.00, alpha:1.0)
        searchController.searchBar.tintColor = UIColor(red:0.92, green:1.00, blue:1.00, alpha:1.0)
        
        
        
        
        AddButton.layer.borderWidth = 3
        AddButton.layer.cornerRadius = 10
        AddButton.layer.borderColor = UIColor.darkGray.cgColor
        
        
        
        //displaying reservations
        
        
        ref.observe(.value, with: { snapshot in
            
            var newReservations: [Reservation] = []
            
            for child in snapshot.children {
                
                
                if let snapshot = child as? DataSnapshot,
                    
                    let reservation = Reservation(snapshot: snapshot) {
                    
                    newReservations.append(reservation)
                    
                }
                
            }
            self.reservations = newReservations
            
            self.Tableview.reloadData()
            
            
        })
        
    }
        
    

    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredReservations = reservations.filter({( reservation : Reservation) -> Bool in
            return reservation.roomName.lowercased().contains(searchText.lowercased())
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
extension RoomsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
}


