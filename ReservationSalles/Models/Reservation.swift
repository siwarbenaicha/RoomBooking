//
//  Reservation.swift
//  ReservationSalles
//
//  Created by Mobelite-LABS on 7/29/19.
//  Copyright © 2019 Mobelite-LABS. All rights reserved.
//

import Foundation
import Firebase


struct Reservation {
    
    let ref: DatabaseReference?
    let key: String
    let roomName: String
    let projectName: String
    let date: String
    let startTime: String
    let finishTime: String
    let members: String
    let description: String
    let type: String
    let addedByUser: String
    let local : String
    
    
    init(roomName: String, projectName: String, date: String, startTime: String, finishTime: String, members: String, description: String, type: String, addedByUser: String, local : String, key: String = "")
    {
        self.ref = nil
        self.key = key
        self.roomName = roomName
        self.projectName = projectName
        self.date = date
        self.startTime = startTime
        self.finishTime = finishTime
        self.members = members
        self.description = description
        self.type = type
        self.addedByUser = addedByUser
        self.local = local

    }
    
  
   
    
    
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let roomName = value["roomName"] as? String,
            let projectName = value["projectName"] as? String,
            let date = value["date"] as? String,
            let startTime = value["startTime"] as? String,
            let finishTime = value["finishTime"] as? String,
            let members = value["members"] as? String,
            let description = value["description"] as? String,
            let type = value["type"] as? String,
            let addedByUser = value["addedByUser"] as? String,
            let local = value["local"] as? String
        
            else {
                
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.roomName = roomName
        self.projectName = projectName
        self.date = date
        self.startTime = startTime
        self.finishTime = finishTime
        self.members = members
        self.description = description
        self.type = type
        self.addedByUser = addedByUser
        self.local = local
    }
    
    
    func toAnyObject() -> Any {
        return [
            "roomName": roomName,
            "projectName": projectName,
            "date": date,
            "startTime": startTime,
            "finishTime": finishTime,
            "members": members,
            "description": description,
            "type": type,
            "addedByUser": addedByUser,
            "local": local
            
        ]
    }
    
}
