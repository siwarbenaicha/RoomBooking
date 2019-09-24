//
//  Salle.swift
//  ReservationSalles
//
//  Created by Mobelite-LABS on 7/29/19.
//  Copyright © 2019 Mobelite-LABS. All rights reserved.
//

import Foundation
import Firebase


struct Salle {
    
    let ref: DatabaseReference?
    let key: String
    let name: String
    let local : String
    
    init(name: String, local: String,key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
        self.local = local
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let local = value["local"] as? String
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.local = local
    }
    
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "local": local
        ]
    }
    
}
