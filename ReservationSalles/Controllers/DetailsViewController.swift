//
//  DetailsViewController.swift
//  ReservationSalles
//
//  Created by Mobelite-LABS on 7/31/19.
//  Copyright © 2019 Mobelite-LABS. All rights reserved.
//

import UIKit

class DetailsViewController: UITableViewController {
    
   
    
    //Mark:properties
    
    
    var roomname : String?
    var date : String?
    var starttime : String?
    var finishtime : String?
    var addedbyuser : String?
    var projectname : String?
    var type : String?
    var members : String?
    var descriptionres : String?
     var local : String?
    

    
    //outlets:
    
    @IBOutlet weak var roomnameoutlet: UILabel!
    
    @IBOutlet weak var dateoutlet: UILabel!
    
    @IBOutlet weak var startdateoutlet: UILabel!
    
    
    @IBOutlet weak var finishdateoutlet: UILabel!
    
    @IBOutlet weak var addedbyuseroutlet: UILabel!
    
    @IBOutlet weak var projectnameoutlet: UILabel!
    
    @IBOutlet weak var typeoutlet: UILabel!
    
    
    @IBOutlet weak var membersoutlet: UILabel!
    
    
    @IBOutlet weak var descriptionoutlet: UILabel!
    
    
    @IBOutlet weak var Localoutlet: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    roomnameoutlet.text = roomname
    dateoutlet .text = date
    startdateoutlet.text = starttime
    finishdateoutlet.text = finishtime
    addedbyuseroutlet.text = addedbyuser
    projectnameoutlet.text = projectname
    typeoutlet.text = type
    membersoutlet.text = members
    descriptionoutlet.text = descriptionres
    Localoutlet.text = local
    

    }

   
    
    //Actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
       
    }
    


}
