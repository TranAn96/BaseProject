//
//  APIManage.swift
//  BaseSwift
//
//  Created by Quynh Nguyen on 6/18/17.
//  Copyright © 2017 Quynh Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON

fileprivate enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

class APIManage: NSObject {
    private let TIMEOUT_REQUEST:TimeInterval = 30
    
    //MARK: Shared Instance
    static let shared:APIManage = APIManage()
    
    //MAKR: private
    fileprivate func request(urlString: String,
                             param: [String: Any]?,
                             method: HTTPMethod,
                             complete: Completion?)
    {
        self.request(urlString: urlString, param: param, method: method, showLoading: true, complete: complete)
    }
    
    fileprivate func request(urlString: String,
                             param: [String: Any]?,
                             method: HTTPMethod,
                             showLoading: Bool,
                             complete: Completion?)
    {
        self.displayLoading(showLoading)
        
        var request:URLRequest!
        
        // set method & param
        if method == .get {
            if let parameterString = param?.stringFromHttpParameters() {
                request = URLRequest(url: URL(string:"\(urlString)?\(parameterString)")!)
            }
            else {
                request = URLRequest(url: URL(string:urlString)!)
            }
        }
        else if method == .post {
            request = URLRequest(url: URL(string:urlString)!)
            
            // content-type
            let headers: Dictionary = ["Content-Type": "application/json"]
            request.allHTTPHeaderFields = headers
            
            let parameterString = param?.stringFromHttpParameters()
            if parameterString != nil {
                request.httpBody = parameterString?.data(using: .utf8)
            }
        }
        
        request.timeoutInterval = TIMEOUT_REQUEST
        request.httpMethod = method.rawValue
        
        //
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            self.hideLoading(showLoading)
            
            // check for fundamental networking error
            guard let data = data, error == nil else {
                if let block = complete {
                    block(false, error)
                }
                
                return
            }
            
            // check for http errors
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200, let res = response {
                BLog("statusCode should be 200, but is \(httpStatus.statusCode)")
                BLog("response = \(res)")
            }
            
            if let block = complete {
                if let json = self.dataToJSON(data: data) {
                    BLog("response json = \(json)")
                    block(true, json)
                }
                else if let responseString = String(data: data, encoding: .utf8) {
                    BLog("response string = \(responseString)")
                    block(true, error)
                }
            }
        }
        task.resume()
    }
    
    private func dataToJSON(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: [])
        } catch let myJSONError {
            BLog("convert to json error: \(myJSONError)")
        }
        return nil
    }
    
    private func displayLoading(_ allow:Bool) {
        //        if allow {
        //            if let view = UIApplication.shared.keyWindow {
        //                DispatchQueue.main.async {
        //                    MBProgressHUD.showAdded(to:view , animated: true)
        //                }
        //            }
        //        }
    }
    
    private func hideLoading(_ allow:Bool) {
        //        if allow {
        //            if let view = UIApplication.shared.keyWindow {
        //                DispatchQueue.main.async {
        //                    MBProgressHUD.hide(for:view , animated: true)
        //                }
        //            }
        //        }
    }
    
    //MARK: public
    
}

//MARK: API for user define
extension APIManage {
    private func handleTranslate(data: Data?, response: URLResponse?, error: Error?, completion: @escaping Completion) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            if let responseHTTP = response as? HTTPURLResponse {
                if responseHTTP.statusCode == 200 {
                    guard let information = data else { return }
                    
                    var translate: String = ""
                    do {
                        let result = try JSONSerialization.jsonObject(with: information, options: JSONSerialization.ReadingOptions.allowFragments)
                        let json = JSON(result)
                        
                        for i in 0..<(json[0].array?.count)! {
                            print((json[0][i].array?.first?.stringValue)!)
                            translate += (json[0][i].array?.first?.stringValue)!
                        }
                        
                        DispatchQueue.main.async {
                            completion(true, translate)
                        }
                        
                    } catch {
                        DispatchQueue.main.async {
                            completion(false, data)
                        }
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        completion(false, data)
                    }
                }
            }
        }
    }
    
    func translateDetected(langTo: String, word: String, completion: @escaping Completion) {
        let url: String = "https://translate.googleapis.com/translate_a/single?" + "client=gtx&" + "sl=auto" + "&tl=" + langTo + "&dt=t&ie=UTF-8&oe=UTF-8&q=" + word
        
        let encodeText = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let urlRequest: URLRequest = URLRequest(url: URL(string: encodeText!)!)
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            self.handleTranslate(data: data, response: response, error: error, completion: completion)
            
        }) .resume()
    }
    
    func translate(langFrom: String, langTo: String, word: String, completion: @escaping Completion) {
        
        //        var data = {
        //            client: 't',
        //            sl: opts.from,
        //            tl: opts.to,
        //            hl: opts.to,
        //            dt: ['at', 'bd', 'ex', 'ld', 'md', 'qca', 'rw', 'rm', 'ss', 't'],
        //            ie: 'UTF-8',
        //            oe: 'UTF-8',
        //            otf: 1,
        //            ssel: 0,
        //            tsel: 0,
        //            kc: 7,
        //            q: text
        //        };
        
        let url: String = "https://translate.googleapis.com/translate_a/single?" + "client=gtx&" + "sl=" + langFrom +
            "&tl=" + langTo +
            "&dt=t&ie=UTF-8&oe=UTF-8&q=" + word
        
        let encodeText = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let urlRequest: URLRequest = URLRequest(url: URL(string: encodeText!)!)
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            self.handleTranslate(data: data, response: response, error: error, completion: completion)
            
        }) .resume()
        
    }
    
}

