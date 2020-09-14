//
//  ChannelsViewController.swift
//  SlackClone
//
//  Created by Ivan Sliepov on 13.09.2020.
//  Copyright © 2020 Ivan Sliepov. All rights reserved.
//

import Cocoa
import Parse

class ChannelsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate{

    

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var profilePicImageView: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    
    var channels : [PFObject] = []
    var chatVC : ChatViewController?
    var addChannelWC : NSWindowController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewDidAppear() {
        getChannels()
        if let user = PFUser.current() {
             if let name = user["name"] as? String {
                 nameLabel.stringValue = name
             }
            if let imageFile = user["profilePic"] as? PFFileObject {
                imageFile.getDataInBackground( { (data:Data?, error:Error?) in
                    if error == nil {
                        if data != nil {
                            let image = NSImage(data: data!)
                            self.profilePicImageView.image = image
                        }
                    }
                })
            }
         }
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        chatVC?.clearChat()	
        PFUser.logOut()
        if let mainWC = view.window?.windowController as? MainWindowController {
            mainWC.moveToSignIn()
        }
    }
    
    @IBAction func addClicked(_ sender: Any) {
       addChannelWC =  storyboard?.instantiateController(withIdentifier: "addChannelWC") as? NSWindowController
        addChannelWC?.showWindow(nil)
    }
    
    func getChannels() {
        let query = PFQuery(className: "Channel")
        query.order(byAscending: "title")
        query.findObjectsInBackground { (channels:[PFObject]?, error:Error?) in
            if channels != nil {
                self.channels = channels!
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfRows(in tableViewNew: NSTableView) -> Int {
        return channels.count
    }
 
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let channel = channels[row]
        
        if let gell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "channelCell"), owner: nil) as? NSTableCellView {
            
            if let title = channel["title"] as? String {
                gell.textField?.stringValue = "#\(title)"
                return gell
            }
        }
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRow < 0 {
            
        }
        else {
            let channel = channels[tableView.selectedRow]
            chatVC?.updateWithChannel(channel: channel)
        }
    }
}
