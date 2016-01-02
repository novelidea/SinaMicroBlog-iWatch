//
//  InterfaceController.swift
//  SinaMicroBlog WatchKit Extension
//
//  Created by XingPengfei on 12/28/15.
//  Copyright © 2015 Pengfei Xing. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {

    let session : WCSession = WCSession.defaultSession()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        session.delegate = self;
        session.activateSession()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
//        let account : MBAccountTool = MBAccountTool()
//        account.accountWithDict(message)
//        MBAccountTool.saveAccount(account)
        
        print("test is ")
        print(message["code"])
    }

}
