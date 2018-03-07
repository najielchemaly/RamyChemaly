//
//  Services.swift
//  ramychemaly
//
//  Created by MR.CHEMALY on 3/4/18.
//  Copyright © 2018 we-devapp. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON

struct ServiceName {
    
    static let getGlobalVariables = "/getGlobalVariables/"
    static let getNews = "/getNews/"
    static let getAboutUs = "/getAboutUs/"
    static let registerUser = "/registerUser/"
    static let getNotifications = "/getNotifications/"
    static let changePassword = "/changePassword/"
    static let editProfile = "/editProfile/"
    static let login = "/login/"
    static let logout = "/logout/"
    static let forgotPassword = "/forgotPassword/"
    static let facebookLogin = "/facebookLogin/"
    
}

enum ResponseStatus: Int {
    
    case SUCCESS = 1
    case FAILURE = 0
    case CONNECTION_TIMEOUT = -1
    case UNAUTHORIZED = -2
    
}

enum ResponseMessage: String {
    
    case SERVER_UNREACHABLE = "An error has occured, please try again."
    case CONNECTION_TIMEOUT = "Check your internet connection."
    
}

class ResponseData {
    
    var status: Int = ResponseStatus.SUCCESS.rawValue
    var message: String = String()
    var json: [NSDictionary]? = [NSDictionary]()
    var jsonObject: JSON? = JSON((Any).self)
    
}

class Services {
    
    private let BaseUrl = "http://www.jdeidetmarjeyoun.com/api"
    private let Suffix = ""
    private static var _AccessToken: String = ""
    var ACCESS_TOKEN: String {
        get {
            if let token = UserDefaults.standard.string(forKey: Keys.AccessToken.rawValue) {
                Services._AccessToken = token
            }
            
            return Services._AccessToken
        }
    }
    private static var _MediaUrl: String = ""
    var MediaUrl: String {
        get {
            return Services._MediaUrl
        }
        set {
            Services._MediaUrl = newValue
        }
    }
    
    func getGlobalVariables() -> ResponseData? {
        
        let serviceName = ServiceName.getGlobalVariables + "?lang=" //+ Localization.currentLanguage()
        return makeHttpRequest(method: .get, serviceName: serviceName)
    }
    
    func getNews(type: String) -> ResponseData? {
        
        let serviceName = ServiceName.getNews + "?lang=" //+ Localization.currentLanguage() + "&type=" + type
        return makeHttpRequest(method: .get, serviceName: serviceName)
    }
    
    func getAboutUs() -> ResponseData? {
        
        let serviceName = ServiceName.getAboutUs + "?lang=" //+ Localization.currentLanguage()
        return makeHttpRequest(method: .get, serviceName: serviceName)
    }
    
    func registerUser(fullName: String, username: String, password: String, phoneNumber: String) -> ResponseData? {
        
        let parameters = [
            "fullName": fullName,
            "userName": username,
            "password": password,
            "phoneNumber": phoneNumber
        ]
        
        let serviceName = ServiceName.registerUser
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters)
    }

    func getNotifications() -> ResponseData? {
        
        let serviceName = ServiceName.getNotifications + "?lang=" //+ Localization.currentLanguage()
        return makeHttpRequest(method: .get, serviceName: serviceName)
    }

    func changePassword(id: String, password: String) -> ResponseData? {
        
        let parameters: Parameters = [
            "id": id,
            "password": password
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ACCESS_TOKEN
        ]
        
        let serviceName = ServiceName.changePassword
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters, headers: headers)
    }
    
    func editProfile(id: String, fullName: String, phoneNumber: String, email: String, address: String) -> ResponseData? {
        
        let parameters: Parameters = [
            "id": id,
            "fullName": fullName,
            "phoneNumber": phoneNumber,
            "email": email,
            "address": address
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ACCESS_TOKEN
        ]
        
        let serviceName = ServiceName.editProfile
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters, headers: headers)
    }
    
    func login(username: String, password: String) -> ResponseData? {
        
        let parameters: Parameters = [
            "userName": username,
            "password": password
        ]
        
        let serviceName = ServiceName.login
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters)
    }
    
    func logout(userId: String) -> ResponseData? {
        
        let parameters: Parameters = [
            "userId": userId
        ]
        
        let serviceName = ServiceName.logout
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters)
    }
    
    func forgotPassword(email: String) -> ResponseData? {
        
        let parameters: Parameters = [
            "email": email
        ]
        
        let serviceName = ServiceName.forgotPassword
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters)
    }
    
    func facebookLogin() -> ResponseData? {
        
        let parameters: Parameters = [
            "facebookID": "",
            "facebookToken": "",
            "firstName": "",
            "email": "",
            "gender": "",
            ]
        
        let serviceName = ServiceName.facebookLogin
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters)
    }

    func uploadImageData(imageFile : UIImage, completion:@escaping(_:ResponseData)->Void) {
        
        let imageData = imageFile.jpeg(.medium)// UIImageJPEGRepresentation(imageFile , 0.5)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData!, withName: "file", fileName: "image.jpeg", mimeType: "image/jpeg")
        }, to: BaseUrl + "/uploadImage/")
        { (result) in
            let responseData = ResponseData()
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                })
                
                upload.responseJSON { response in
                    
                    if let json = response.result.value as? NSDictionary {
                        responseData.status = ResponseStatus.SUCCESS.rawValue
                        responseData.json = [json]
                        
                        completion(responseData)
                    } else {
                        responseData.status = ResponseStatus.FAILURE.rawValue
                        responseData.message = ResponseMessage.SERVER_UNREACHABLE.rawValue
                        responseData.json = nil
                        completion(responseData)
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
                responseData.status = ResponseStatus.FAILURE.rawValue
                responseData.json = nil
                completion(responseData)
            }
        }
    }
    
    // MARK: /************* SERVER REQUEST *************/
    
    private func makeHttpRequest(method: HTTPMethod, serviceName: String, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> ResponseData {
        
        let response = manager.request(BaseUrl + Suffix + serviceName, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON(options: .allowFragments)
        let responseData = ResponseData()
        responseData.status = ResponseStatus.FAILURE.rawValue
        responseData.message = ResponseMessage.SERVER_UNREACHABLE.rawValue
        if let token = response.response?.allHeaderFields[Keys.AccessToken.rawValue] as? String{
            UserDefaults.standard.set(token, forKey: Keys.AccessToken.rawValue)
        }
        if let jsonArray = response.result.value as? [NSDictionary] {
            let json = jsonArray.first
            if let status = json!["status"] as? Int {
                let boolStatus = status == 1 ? true : false
                switch boolStatus {
                case true:
                    responseData.status = ResponseStatus.SUCCESS.rawValue
                    break
                default:
                    responseData.status = ResponseStatus.FAILURE.rawValue
                    break
                }
            }
            if let message = json!["message"] as? String {
                responseData.message = message
            }
            if let message = json!["message"] as? Bool {
                responseData.message = String(message)
            }
            
            if let json = jsonArray.last {
                responseData.json = [json]
            }
            
        } else if let json = response.result.value as? NSDictionary {
            if let status = json["status"] as? Int {
                let boolStatus = status == 1 ? true : false
                switch boolStatus {
                case true:
                    responseData.status = ResponseStatus.SUCCESS.rawValue
                    break
                default:
                    responseData.status = ResponseStatus.FAILURE.rawValue
                    break
                }
            }
            if let message = json["message"] as? String {
                responseData.message = message
            }
            if let message = json["message"] as? Bool {
                responseData.message = String(message)
            }
            
            responseData.json = [json]
            
        } else if let jsonArray = response.result.value as? NSArray {
            if let jsonStatus = jsonArray.firstObject as? NSDictionary {
                if let status = jsonStatus["status"] as? Int {
                    responseData.status = status
                }
            }
            
            if let jsonData = jsonArray.lastObject as? NSArray {
                responseData.json = [NSDictionary]()
                for jsonObject in jsonData {
                    if let json = jsonObject as? NSDictionary {
                        responseData.json?.append(json)
                    }
                }
            }
        } else {
            responseData.status = ResponseStatus.FAILURE.rawValue
            responseData.message = ResponseMessage.SERVER_UNREACHABLE.rawValue
            responseData.json = nil
        }
        
        return responseData
        
    }
    
    let manager: SessionManager = {
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = 5
        return SessionManager(configuration: configuration)
        
    }()
    
    func getBaseUrl() -> String {
        return self.BaseUrl
    }
    
    static func getMediaUrl() -> String {
        return _MediaUrl
    }
    
    static func setMediaUrl(url: String) {
        _MediaUrl = url
    }
}
