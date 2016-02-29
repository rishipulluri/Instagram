//
//  LoginViewController.swift
//  InstaGram
//
//  Created by saritha on 2/25/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet var passwordField: UITextField!
    @IBOutlet var UsernameFIeld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signUp(sender: AnyObject) {
        let newuser = PFUser()
        newuser.username = UsernameFIeld.text
        newuser.password = passwordField.text
    
        newuser.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if (success)
            {
                print("success")
                 self.performSegueWithIdentifier("loginsegue", sender: nil)
                
            }
            else
            {
                print(error?.localizedDescription)
                if (error!.code == 202)
                {
                    print("UserName is Taken")
                }
            }
        }
    }

    @IBAction func SignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(UsernameFIeld.text!, password: passwordField.text!) { (user: PFUser?, error:NSError?) -> Void in
            if user != nil{
                print("Your logged in")
                self.performSegueWithIdentifier("loginsegue", sender: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
