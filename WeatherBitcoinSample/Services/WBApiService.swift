//
//  WBApiService.swift
//  WeatherBitcoinSample
//
//  Created by jatin verma on 13/06/19.
//  Copyright © 2019 jatin verma. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ReachabilitySwift

class WBApiService {
    static var alamofireManager: SessionManager?
    
    class func reachabilityError () -> WBError {
        return WBError(statusCode:0, message:WBConstants.ErrorStrings.noInternetConnection)
    }
    
    class func isReachable() -> Bool {
        do {
            let reachability = Reachability(hostname: WBConstants.Services.WeatherBitcoin.baseURL)
            if reachability!.isReachable {
                return true
            }
        }
        return false
    }
    
    class func request(_ method: HTTPMethod, needLogin: Bool, url:String, params:[String: AnyObject]?, encoding: ParameterEncoding = URLEncoding.default, loginToken: String? = nil, success:((JSON?) -> Void)?, failure:((WBError) -> Void)?) {
        
        if WBApiService.isReachable() {
            let absoluteUrl: String?
            absoluteUrl = WBConstants.Services.WeatherBitcoin.baseURL + url
//            let headers:[String:String]?
            
            if needLogin {
                //TODO: what if token is not available
//                if let token = UserDefaults.ms_getLoginToken() {
//                    headers = ["Authorization": "Token " +  token]
//                }
            }
            
            if alamofireManager == nil {
                let configuration = URLSessionConfiguration.default
                configuration.timeoutIntervalForRequest = 12
                configuration.timeoutIntervalForResource = 12
                alamofireManager = Alamofire.SessionManager(configuration: configuration)
            }
            alamofireManager!.request(absoluteUrl!, method: method, parameters: params, encoding: encoding, headers: nil).validate()
                .responseJSON {
                    response in
                    switch response.result {
                    case .success:
                        if let value = response.result.value  {
                            let json = JSON(value)
                            print("----====success json====----")
                            print(json)
                            print("----====end of success json====----")
                            success?(json)
                        }
                    case .failure:
                        guard response.response != nil else {
                            failure?(WBError(statusCode: 0, message: WBConstants.ErrorStrings.undefinedError))
                            return
                        }
                        
                        if response.response!.statusCode >= 200 && response.response!.statusCode < 300  {
                            print(response)
                            success?(nil)
                        } else {
                            print("----====response data and error====----")
                            print(response.data ?? "nil", response.result.error ?? "nil")
                            print("----====end of response data and error====----")
                            if let responseError = response.result.error {
                                var error: WBError?
                                if responseError.localizedDescription == WBConstants.ErrorStrings.timeOutError {
                                    
                                    // Handling timout
                                    error = WBError(statusCode: 408, message: responseError.localizedDescription)
                                    
                                } else if responseError.localizedDescription == WBConstants.ErrorStrings.noInternetConnection {
                                    
                                    // Handling No Internet
                                    error = WBError(statusCode: 4, message: responseError.localizedDescription)
                                    
                                } else if responseError.localizedDescription == WBConstants.ErrorStrings.networkConnectionLost {
                                    
                                    // Handling Lost Connection
                                    error = WBError(statusCode: -1005, message: responseError.localizedDescription)
                                    
                                } else {
                                    print("handling error")
                                    // Handling all other Errors
                                    let jsonString = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) as String?
                                    
                                    if jsonString == nil || jsonString!.wb_length() == 0 {
                                        error = WBError(statusCode: -1, message: WBConstants.ErrorStrings.undefinedError)
                                    } else {
                                        let json = JSON.init(jsonString ?? "")
                                        let js = JSON(parseJSON: json.string!)
                                        print("----====end of MS object:====----")
                                        error = WBError(json: json)
                                        if js["msg"].string == "Invalid token" || js["msg"].string == "You are not enrolled in this course" || js["msg"].string == "User inactive or deleted."
                                        {
                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "invalidtoken"), object: nil)
                                        }
                                    }
                                    
                                }
                                failure?(error!)
                            }
                        }
                    }
            }
        } else {
            failure?(WBApiService.reachabilityError())
        }
    }
}



