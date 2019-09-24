//
//  ViewController.swift
//  ReservationSalles
//
//  Created by Mobelite-LABS on 7/9/19.
//  Copyright © 2019 Mobelite-LABS. All rights reserved.
//

import UIKit
import Firebase





class LoginViewController: UIViewController {

    //Mark:constants
    
    // let gotosignup = "GoToSignUp"
    let GoToMainFromLogin = "GoToMainFromLogin"
    
    
    //Mark:outlets
    
    @IBOutlet weak var EmailTextField: UITextField!
    
     @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var StaticImage: UIImageView!
    
    
   //buttons outlets for configuration
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    
    
    //Mark:properties
    
  
    
    
    
    
    
    //Mark:lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
   //Buttons configuration
    
    LoginButton.layer.borderWidth = 3
    LoginButton.layer.cornerRadius = 10
    LoginButton.layer.borderColor = UIColor.darkGray.cgColor
        
    SignUpButton.layer.borderWidth = 3
    SignUpButton.layer.cornerRadius = 10
    SignUpButton.layer.borderColor = UIColor.darkGray.cgColor
       
        
        
       
        
        
    
        // 1
        //Create an authentication observer using addStateDidChangeListener(_:). The block is passed two parameters: auth and user.
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            
            // 2
            //Test the value of user. Upon successful user authentication, user is populated with the user’s information. If authentication fails, the variable is nil.
            
            if user != nil {
                
                // 3
                //On successful authentication, perform the segue and clear the text fields’ text. It may seem strange that you don’t pass the user to the next controller, but you’ll see how to get this within GroceryListTableViewController.swift.
                
               // self.performSegue(withIdentifier: self.GoToMainFromLogin, sender: nil)
                
                self.EmailTextField.text = nil
                self.PasswordTextField.text = nil
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    //Mark:Actions
  
    
    
    
    
    @IBAction func LoginButtonDidTouch(_ sender: Any) {
        
        
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
        
       
     
        Auth.auth().signIn(withEmail: email , password: password) { user, error in
            if let error = error, user == nil {
                print(error)
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
            
                print("Authentication successful")
                self.performSegue(withIdentifier: self.GoToMainFromLogin, sender: nil)
            }
                
            
    }
    
    
    
    @IBAction func SignUpButtonDidTouch(_ sender: Any) {
        
        
    }
    
    

    
  
    
}



//meme nom que ce view controller
//delegtae sur les textfields


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == EmailTextField {
            PasswordTextField.becomeFirstResponder()
        }
        if textField == PasswordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
