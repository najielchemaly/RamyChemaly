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
    
    static let getNews = "/getNews/"
    static let getAboutUs = "/getAboutUs/"
    static let registerUser = "/registerUser/"
    static let getNotifications = "/getNotifications/"
    static let changePassword = "/changePassword/"
    static let editUser = "/editUser/"
    static let login = "/login/"
    static let logout = "/logout/"
    static let forgotPassword = "/forgotPassword/"
    static let facebookLogin = "/facebookLogin/"
    static let updateAvatar = "/updateAvatar/"
    static let contactUs = "/contactUs/"
    static let getBiography = "/getBiography/"
    static let getDiscography = "/getDiscography/"
    static let getBreadOfLife = "/getBreadOfLife/"
    static let uploadBreadOfLife = "/uploadBreadOfLife/"
    
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
    
    private static var _AccessToken: String = ""
    var ACCESS_TOKEN: String {
        get {
            if let token = UserDefaults.standard.string(forKey: Keys.AccessToken.rawValue) {
                Services._AccessToken = token
            }
            
            return Services._AccessToken
        }
    }
    
    static let ConfigUrl = "http://config.ramychemaly.com/"
//    private let ConfigUrl = "http://localhost/ramychemaly/services/getConfig/"
    
    private static var _BaseUrl: String = ""
    var BaseUrl: String {
        get {
            return Services._BaseUrl
        }
        set {
            Services._BaseUrl = newValue
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
    
    func getConfig() -> ResponseData? {
        return makeHttpRequest(method: .post, isConfig: true)
    }
    
    func getNews(type: String) -> ResponseData? {
        
        let serviceName = ServiceName.getNews
        return makeHttpRequest(method: .get, serviceName: serviceName)
    }
    
    func getAboutUs() -> ResponseData? {
        
        let serviceName = ServiceName.getAboutUs
        return makeHttpRequest(method: .get, serviceName: serviceName)
    }
    
    func registerUser(fullname: String, email: String, password: String, phoneNumber: String) -> ResponseData? {
        
        let parameters = [
            "fullname": fullname,
            "email": email,
            "password": password,
            "phoneNumber": phoneNumber
        ]
        
        let serviceName = ServiceName.registerUser
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters)
    }

    func getNotifications() -> ResponseData? {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ACCESS_TOKEN
        ]
        
        let serviceName = ServiceName.getNotifications //+ "?lang=" + Localization.currentLanguage()
        return makeHttpRequest(method: .post, serviceName: serviceName, headers: headers)
    }
    
    func getBiography() -> ResponseData? {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ACCESS_TOKEN
        ]
        
        let serviceName = ServiceName.getBiography //+ "?lang=" + Localization.currentLanguage()
        return makeHttpRequest(method: .post, serviceName: serviceName, headers: headers)
    }
    
    func getDiscography() -> ResponseData? {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ACCESS_TOKEN
        ]
        
        let serviceName = ServiceName.getDiscography //+ "?lang=" + Localization.currentLanguage()
        return makeHttpRequest(method: .post, serviceName: serviceName, headers: headers)
    }
    
    func getBreadOfLife() -> ResponseData? {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ACCESS_TOKEN
        ]
        
        let serviceName = ServiceName.getBreadOfLife //+ "?lang=" + Localization.currentLanguage()
        return makeHttpRequest(method: .post, serviceName: serviceName, headers: headers)
    }

    func changePassword(id: String, oldPassword: String, newPassword: String) -> ResponseData? {
        
        let parameters: Parameters = [
            "id": id,
            "oldPassword": oldPassword,
            "newPassword": newPassword
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ACCESS_TOKEN
        ]
        
        let serviceName = ServiceName.changePassword
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters, headers: headers)
    }
    
    func editUser(id: String, fullname: String, phoneNumber: String, email: String) -> ResponseData? {
        
        let parameters: Parameters = [
            "id": id,
            "fullname": fullname,
            "phoneNumber": phoneNumber,
            "email": email
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ACCESS_TOKEN
        ]
        
        let serviceName = ServiceName.editUser
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters, headers: headers)
    }
    
    func login(email: String, password: String) -> ResponseData? {
        
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        let serviceName = ServiceName.login
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters)
    }
    
    func logout(id: String) -> ResponseData? {
        
        let parameters: Parameters = [
            "id": id
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ACCESS_TOKEN
        ]
        
        let serviceName = ServiceName.logout
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters, headers: headers)
    }
    
    func forgotPassword(email: String) -> ResponseData? {
        
        let parameters: Parameters = [
            "email": email
        ]
        
        let serviceName = ServiceName.forgotPassword
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters)
    }
    
    func facebookLogin(user: User) -> ResponseData? {
        
        let parameters: Parameters = [
            "facebook_id": user.facebook_id ?? "",
            "facebook_token": user.facebook_token ?? "",
            "fullname": user.fullname ?? "",
            "email": user.email ?? "",
            "gender": user.gender ?? "",
        ]
        
        let serviceName = ServiceName.facebookLogin
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters)
    }
    
    func contactUs(name: String, email: String, phone: String, message: String) -> ResponseData? {
        
        let parameters: Parameters = [
            "fullname": name,
            "email": email,
            "phone": phone,
            "message": message
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ACCESS_TOKEN
        ]
        
        let serviceName = ServiceName.contactUs
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters, headers: headers)
    }
    
    func uploadBreadOfLife(type: String, title: String, message: String) -> ResponseData? {
        
        let parameters: Parameters = [
            "type": type,
            "title": title,
            "message": message
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + ACCESS_TOKEN
        ]
        
        let serviceName = ServiceName.uploadBreadOfLife
        return makeHttpRequest(method: .post, serviceName: serviceName, parameters: parameters, headers: headers)
    }
    
    func updateAvatar(userId: String, image : UIImage, completion:@escaping(_:ResponseData)->Void) {
        self.uploadImageData(userId: userId, serviceName: ServiceName.updateAvatar, imageFile: image, completion: completion)
    }

    func uploadImageData(userId: String, serviceName: String, imageFile : UIImage, completion:@escaping(_:ResponseData)->Void) {
        
        let headers: HTTPHeaders = [
            "User-Id": userId
        ]
        
        let imageData = imageFile.jpeg(.medium)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData!, withName: "file", fileName: "image.jpeg", mimeType: "image/jpeg")
        }, to: BaseUrl + serviceName, headers: headers)
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
    
    private func makeHttpRequest(method: HTTPMethod, serviceName: String = "", parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, isConfig: Bool = false) -> ResponseData {
        
        var requestUrl = BaseUrl
        if isConfig {
            requestUrl = Services.ConfigUrl
        }
        
        let response = manager.request(requestUrl + serviceName, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON(options: .allowFragments)
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
        
        if responseData.status == ResponseStatus.UNAUTHORIZED.rawValue {
            if let baseVC = currentVC as? BaseViewController {
                baseVC.logout()
            }
        }
        
        return responseData
        
    }
    
    let manager: SessionManager = {
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = 5
        return SessionManager(configuration: configuration)
        
    }()
    
    static func getBaseUrl() -> String {
        return _BaseUrl
    }
    
    static func setBaseUrl(url: String) {
        _BaseUrl = url
    }
    
    static func getMediaUrl() -> String {
        return _MediaUrl
    }
    
    static func setMediaUrl(url: String) {
        _MediaUrl = url
    }
}
