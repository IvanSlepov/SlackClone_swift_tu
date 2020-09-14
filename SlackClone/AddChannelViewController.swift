//
//  AddChannelViewController.swift
//  SlackClone
//
//  Created by Ivan Sliepov on 13.09.2020.
//  Copyright © 2020 Ivan Sliepov. All rights reserved.
//

import Cocoa
import Parse

class AddChannelViewController: NSViewController {

    @IBOutlet weak var addChannelLabel: NSTextField!
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var descriptionTextField: NSTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func addChannelClicked(_ sender: Any) {
        let channel = PFObject(className: "Channel")
        channel["title"] = titleTextField.stringValue
        channel["description"] = descriptionTextField.stringValue
        channel.saveInBackground { (success: Bool, error: Error?) in
            if success {
                print("Channel created!")
                self.view.window?.close()
            }
            else {
                print("Fucking error!")
            }
        }
    }
    
}
