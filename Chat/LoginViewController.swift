//
//  LoginViewController.swift
//  Chat
//
//  Created by Jianyi Gao 高健一 on 2/8/17.
//  Copyright © 2017 Jianyi Gao. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertMessage(titleString: String, messageString: String){
        let alertController = UIAlertController(title: titleString, message: messageString , preferredStyle: .alert)
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }

    }
    
    @IBAction func onSignUp(_ sender: Any) {
        var user = PFUser()
        
        user.email = emailText.text
        user.username = emailText.text
        user.password = passwordText.text
        
        user.signUpInBackground { (succeeded: Bool, error: Error?) in
            if let error = error {
                let errorString = (error as NSError).userInfo["error"] as? String
                self.alertMessage(titleString: "Oops", messageString: errorString!)
                
            } else {
                self.alertMessage(titleString: "Great", messageString: "Successfully signed up!")
                PFUser.logInWithUsername(inBackground: self.emailText.text!, password: self.passwordText.text!)
                print("Loggedin in Signup")
                
                
                let chatView = self.storyboard?.instantiateViewController(withIdentifier: "chatView") as! ChatViewController
                self.present(chatView, animated: true, completion: nil)
            }
        }
    }
    
  
    @IBAction func onLogin(_ sender: Any) {
        if (emailText.text != nil && passwordText.text != nil){
            PFUser.logInWithUsername(inBackground: emailText.text!, password: passwordText.text!) { (user: PFUser?, error: Error?) in
                if let error = error {
                    let errorString = (error as NSError).userInfo["error"] as? String
                    self.alertMessage(titleString: "Ooops",messageString: errorString!)
                    
                } else {
                    self.alertMessage(titleString: "Great", messageString: "Successfully logged in!")
                }
            }
        } else {
            self.alertMessage(titleString: "Danger Zone", messageString: "Debug")
        }
        
    }
    
    
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
