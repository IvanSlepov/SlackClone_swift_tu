//
//  LoginViewController.swift
//  SlackClone
//
//  Created by Ivan Sliepov on 12.09.2020.
//  Copyright © 2020 Ivan Sliepov. All rights reserved.
//

import Cocoa
import Parse

class LoginViewController: NSViewController {

    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        DispatchQueue.main.asyncAfter(deadline: .now() + .nanoseconds(50)) {
            if var frame = self.view.window?.frame {
                            frame.size = CGSize(width: 480, height: 300)
                self.view.window?.setFrame(frame, display: true, animate: true)
                        }
        }
    }
    
    override func viewWillAppear() {
          if var frame = view.window?.frame {
                  frame.size = CGSize(width: 480, height: 300)
                  view.window?.setFrame(frame, display: true, animate: true)
              }
    }
    
    @IBAction func SignUpClicked(_ sender: Any) {
        
        if let mainWC = view.window?.windowController as? MainWindowController {
            mainWC.moveToSignUp()
        }
        
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: emailTextField.stringValue, password: passwordTextField.stringValue) { (user: PFUser?, error: Error?) in
            if error == nil {
                print("Successful Sign In!")
                if let mainWC = self.view.window?.windowController as? MainWindowController {
                          mainWC.moveToChat()
                      }
            }
            else {
                print("There was an error! when Signing In!")
            }
        }
    }
    
    
}
