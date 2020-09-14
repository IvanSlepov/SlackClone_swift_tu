//
//  CreateAccountViewController.swift
//  SlackClone
//
//  Created by Ivan Sliepov on 12.09.2020.
//  Copyright © 2020 Ivan Sliepov. All rights reserved.
//

import Cocoa
import Parse

class CreateAccountViewController: NSViewController {

    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var profilePicImageView: NSImageView!
    
    var profilePicFile : PFFileObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        if let mainWC = view.window?.windowController as? MainWindowController {
            mainWC.moveToSignIn()
        }
    }
    
    @IBAction func chooseImageClicked(_ sender: Any) {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = true
        openPanel.canChooseFiles = true
        
        openPanel.begin { (result) in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                if let imageURL = openPanel.urls.first {
                    if let image = NSImage(contentsOf: imageURL) {
                        self.profilePicImageView.image = image
                        
                        let imageData = self.jpegDataFrom(image: image)
                        
                        
                        self.profilePicFile = PFFileObject(data: imageData)
                        self.profilePicFile?.saveInBackground()
                    }
                }
            }
        }
    }
    
    func jpegDataFrom(image:NSImage) -> Data {
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])!
        return jpegData
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        PFUser.logOut()
        let user = PFUser()
        user.email = emailTextField.stringValue
        user.password = passwordTextField.stringValue
        user.username = emailTextField.stringValue
        user["name"] = nameTextField.stringValue
        user["profilePic"] = profilePicFile
        
        user.signUpInBackground { (success:Bool, error:Error?	) in
            if success {
                print("Hello new user!")
                if let mainWC = self.view.window?.windowController as? MainWindowController {
                    mainWC.moveToChat()
                }
            }
            else {
                print("Ooops, an error!")
            }
        }
    }
    
}
