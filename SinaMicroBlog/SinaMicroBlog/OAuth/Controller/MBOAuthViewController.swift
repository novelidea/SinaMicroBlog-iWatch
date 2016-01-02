//
//  MBOAuthViewController.swift
//  SinaMicroBlog
//
//  Created by XingPengfei on 12/28/15.
//  Copyright © 2015 Pengfei Xing. All rights reserved.
//

import UIKit
import WatchConnectivity

class MBOAuthViewController: UIViewController, UIWebViewDelegate, WCSessionDelegate {

    let session : WCSession = WCSession.defaultSession()
    
    var userInfo : [String : String] = ["client_id" : "1196253863", "code" : ""]
    
    let MBBase_url : String = "https://api.weibo.com/oauth2/authorize"
    let MBClient_id : String = "1196253863"
    let MBRedirect_url : String = "http://www.pengfeixing.com"
    let MBClient_secrete : String = "c8d6454613cb54d886e5500c1c35f67d"
    
    let MBKeyWindow = UIApplication.sharedApplication().keyWindow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session.delegate = self
        session.activateSession()  
        
        let webView : UIWebView = UIWebView(frame: self.view.frame)
        self.view.addSubview(webView);
        
        let urlString : String = "https://api.weibo.com/oauth2/authorize?client_id=1196253863&redirect_uri=http://www.pengfeixing.com"
        
        let url : NSURL = NSURL(string: urlString)!
        
        let request : NSURLRequest = NSURLRequest(URL: url)

        webView.loadRequest(request)
        
        webView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlString = request.URL?.absoluteString
        print(urlString)
        if let range = urlString!.rangeOfString("code="){
            let startIndex = range.startIndex.advancedBy(5)
            let code : String = (urlString?.substringWithRange(Range<String.Index>(start: startIndex, end: (urlString?.endIndex)!)))!
            self.userInfo.updateValue(code, forKey: "code")
            self.sendUserInfo()
//            print(self.userInfo)
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func sendUserInfo(){
        session.sendMessage(self.userInfo, replyHandler: { replyDict in
            }, errorHandler: { error in
        })
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
