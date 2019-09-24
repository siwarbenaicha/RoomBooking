//
//  SignUpViewController.swift
//  ReservationSalles
//
//  Created by Mobelite-LABS on 7/9/19.
//  Copyright © 2019 Mobelite-LABS. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    
    
    //Mark:constants
    
 let GoToMainFromRegister = "GoToMainFromRegister"
    
    
    
    //Mark:outlets
    
   
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var StaticImage: UIImageView!
    
    
    //Button outlet for configuration
     @IBOutlet weak var RegisterButton: UIButton!
    
    
    
    
    //Mark:properties
    
    
    
    //Mark:Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        //Buttons configuration
        
        RegisterButton.layer.borderWidth = 3
        RegisterButton.layer.cornerRadius = 10
        RegisterButton.layer.borderColor = UIColor.darkGray.cgColor
        
    
    }
    

    func isValidEmail(emailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@mobelite+\\.fr{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }


    //Mark:Actions

 
    @IBAction func RegisterButtonTouched(_ sender: Any) {
        
        guard
            let email = EmailTextField.text,
            let password = PasswordTextField.text,
            email.count > 0,
            password.count > 0
            else {
                
              //  return print ("fields are empty")
                
                
                let alert = UIAlertController(title: "alert",
                                              message: "fields are empty",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                return  self.present(alert, animated: true, completion: nil)
                
        }
        
        
        
        guard
            let email2 = EmailTextField.text,
    
            !email2.contains("admin"),
          
             isValidEmail(emailStr: email2)
        
            
            
            else {
                
                //  return print ("fields are empty")
                
                
                let alert = UIAlertController(title: "alert",
                                              message: "Please enter a mobelite email adress",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                return  self.present(alert, animated: true, completion: nil)
                
        }
        
        
        

        
        
        
        
        
        
    
        Auth.auth().createUser(withEmail: email , password: password ) { user, error in
            if let error = error, user == nil {
           print(error)
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
            else {
                print("Registration successful")
                self.performSegue(withIdentifier: self.GoToMainFromRegister, sender: nil)
                }
            
            }
       }
    
    
    
    
    
}
