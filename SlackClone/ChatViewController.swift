//
//  ChatViewController.swift
//  SlackClone
//
//  Created by Ivan Sliepov on 14.09.2020.
//  Copyright © 2020 Ivan Sliepov. All rights reserved.
//

import Cocoa
import Parse

class ChatViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var channelDescription: NSTextField!
    @IBOutlet weak var messageTextField: NSTextField!
    
    var channel : PFObject?
    var chats : [PFObject] = []
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func updateWithChannel(channel: PFObject) {
        self.channel = channel
        getChats()
        if let title = channel["title"] as? String {
            titleLabel.stringValue = "#\(title)"
            messageTextField.placeholderString = "Message #\(title)"
        }
        
        if let description = channel["description"] as? String {
            channelDescription.stringValue = "#\(description)"
        }
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer:Timer) in
            print("Tick")
            self.getChats()
        }
        
    }
    
    override func viewWillAppear() {
        clearChat()
    }
    
    func clearChat() {
        channel = nil
        chats = []
        tableView.reloadData()
        titleLabel.stringValue = ""
        channelDescription.stringValue = ""
        messageTextField.placeholderString = ""
        timer?.invalidate()
    }
    
    func getChats() {	
        if channel != nil {
            let query = PFQuery(className: "Chat")
            query.includeKey("user")
            query.whereKey("channel", equalTo: channel!)
            query.order(byAscending: "createdAt")
            query.findObjectsInBackground { (chats:[PFObject]?, error:Error?) in
                if error == nil {
                    if chats != nil {
                        if chats?.count != self.chats.count {
                            self.chats = chats!
                            self.tableView.reloadData()
                            self.tableView.scrollRowToVisible(self.chats.count - 1)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendClicked(_ sender: Any) {
        let chat = PFObject(className: "Chat")
        chat["message"] = messageTextField.stringValue
        chat["user"] = PFUser.current()
        chat["channel"] = channel
        
        chat.saveInBackground { (success:Bool, error:Error?) in
            if success {
                print("Hooray!")
                self.messageTextField.stringValue = ""
                self.getChats()
            }
            else {
                print("It did not worked(")
            }
        }
    }
    
    
    @IBAction func enterClicked(_ sender: Any) {
        let chat = PFObject(className: "Chat")
         chat["message"] = messageTextField.stringValue
         chat["user"] = PFUser.current()
         chat["channel"] = channel
         
         chat.saveInBackground { (success:Bool, error:Error?) in
             if success {
                 print("Hooray!")
                 self.messageTextField.stringValue = ""
                 self.getChats()
             }
             else {
                 print("It did not worked(")
             }
         }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "chatCell"), owner: nil) as? ChatSell{
                let chat = chats[row]
                if let message = chat["message"] as? String {
                    cell.messageTextField.stringValue = message
                    
                    if let user = chat["user"] as? PFUser {
                         if let name = user["name"] as? String {
                            cell.nameLabel.stringValue = name
                         }
                        if let imageFile = user["profilePic"] as? PFFileObject {
                            imageFile.getDataInBackground( { (data:Data?, error:Error?) in
                                if error == nil {
                                    if data != nil {
                                        let image = NSImage(data: data!)
                                        cell.profilePicImage.image = image
                                    }
                                }
                            })
                        }
                     }
                    if let date = chat.createdAt {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MMM d h:mm a"
                        cell.dateLabel.stringValue = formatter.string(from: date)
                        
                    }
                    
                }
                return cell
            }
            return nil
        }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100.0
    }
    
}
