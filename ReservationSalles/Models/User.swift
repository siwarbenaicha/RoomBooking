//
//  User.swift
//  ReservationSalles
//
//  Created by Mobelite-LABS on 7/14/19.
//  Copyright © 2019 Mobelite-LABS. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase


struct User {

    let uid: String
    let email: String
   
    
    init(authData: Firebase.User)
    {
      uid = authData.uid
      email = authData.email!
   
    }
    
    
    init(uid: String,email: String) {
        
        self.uid = uid
        self.email = email
        
      }
}
