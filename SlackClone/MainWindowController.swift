//
//  MainWindowController.swift
//  SlackClone
//
//  Created by Ivan Sliepov on 12.09.2020.
//  Copyright © 2020 Ivan Sliepov. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    var signInVC : LoginViewController?
    var createAccountVC : CreateAccountViewController?
    var splitViewController : SplitViewController?
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        signInVC = contentViewController as? LoginViewController
    }
    
    func moveToSignUp() {
        
        if createAccountVC == nil {
            createAccountVC = storyboard?.instantiateController(withIdentifier: "createAccountVC") as? CreateAccountViewController
        }
    
        window?.contentView = createAccountVC?.view

    }
    
    func moveToChat() {
        if splitViewController == nil {
                splitViewController = storyboard?.instantiateController(withIdentifier: "splitVC") as? SplitViewController
            }
        
            window?.contentView = splitViewController?.view
    }
        
    func moveToSignIn() {
        window?.contentView = signInVC?.view
    }

}
