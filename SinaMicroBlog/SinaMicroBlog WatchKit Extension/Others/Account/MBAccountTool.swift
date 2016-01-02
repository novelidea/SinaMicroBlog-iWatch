//
//  MBAccountTool.swift
//  SinaMicroBlog
//
//  Created by XingPengfei on 1/1/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

import UIKit

class MBAccountTool: NSObject {
    var access_token : String
    var expires_in : String
    var uid : String
    var expires_date : NSDate
    var name : String
    
    var account : MBAccountTool
    
    let MBBase_url : String = "https://api.weibo.com/oauth2/authorize"
    let MBClient_id : String = "1196253863"
    let MBRedirect_url : String = "http://www.pengfeixing.com"
    let MBClient_secrete : String = "c8d6454613cb54d886e5500c1c35f67d"
    
    func getAccount() -> MBAccountTool {
        let MBAccountFileName : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0].stringByAppendingString("account.data")
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(MBAccountFileName) as! MBAccountTool
        
        if(NSDate().compare(account.expires_date) == NSComparisonResult.OrderedDescending){
            return MBAccountTool()
        }
        
        return account;
    }
    
    class func saveAccount(account : MBAccountTool){
        let MBAccountFileName : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0].stringByAppendingString("account.data")
        NSKeyedArchiver.archiveRootObject(account, toFile: MBAccountFileName)
    }
    
    
    func accountWithDict(dict: NSDictionary) -> MBAccountTool {
        account.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
        return account;
    }
    
    override init() {
        access_token = ""
        expires_in  = ""
        uid  = ""
        expires_date  = NSDate()
        name  = ""
        account = MBAccountTool()
    }
    
    
    class func accountWithCode(code : String, success:(() -> Void), failure:(() -> Void)){
        let parameter : MBAccountParameters = MBAccountParameters()
        parameter.code = code
        
    }
    
    func postRequest(urlString : String, parameters : AnyObject, success : ((responseObject : AnyObject) -> Void), failure : (error : ErrorType) -> Void){
        
    }
    
    
    
//    + (void)POST:(NSString *)URLString
//    parameters:(id)parameters
//    success:(void (^)(id responseObject))success
//    failure:(void (^)(NSError *error))failure{
//    AFHTTPRequestOperationManager *mng = [AFHTTPRequestOperationManager manager];
//    [mng POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    success(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    failure(error);
//    }];
//    }

    

}
