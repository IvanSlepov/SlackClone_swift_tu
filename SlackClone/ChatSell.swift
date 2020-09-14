//
//  ChatSell.swift
//  SlackClone
//
//  Created by Ivan Sliepov on 14.09.2020.
//  Copyright © 2020 Ivan Sliepov. All rights reserved.
//

import Cocoa

class ChatSell: NSTableCellView {

    @IBOutlet weak var profilePicImage: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var dateLabel: NSTextField!
    @IBOutlet weak var messageTextField: NSTextField!
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
