//
//  RequestManager.swift
//  GitHubManager
//
//  Created by Jonathan Martins on 05/03/20.
//  Copyright © 2020 Jonathan Martins. All rights reserved.
//

import Alamofire
import Foundation

/// The expected data type of the requests, so we can check for erros
enum RequestResult<T:Codable>{
    case success(T)
    case failure(String)
    case noInternetConection
}

class RequestManager<T:Codable>{
    
    /// Checks if there is active internet connection
    private static var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    /// Returns the Base URL, according to the development environment (Debug or Release)
    private static var BASE_URL:String {
        guard let url = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            fatalError("Missing BASE_URL in info.plist")
        }
        return url
    }
  
    /// Performs the GET requests
    static func get(to provider: ProviderDelegate, callback:@escaping(RequestResult<T>)->()){
        if !isConnectedToInternet{
            callback(.noInternetConection)
            return
        }
        
        printAccess(to: provider)
        Alamofire.request("\(BASE_URL)\(provider.path)", method: .get, parameters: nil, headers: provider.headers).responseJSON { (response) in
            self.printResult(response)
            callback(self.resultBlock(response))
        }
    }

    /// Handles the request response traying to parse the result into a 'T' given type or returning an error
    private static func resultBlock(_ response: DataResponse<Any>)->RequestResult<T>{
        guard let _ = response.response?.statusCode else {
            return .failure("Unknown Error")
        }
        guard let data = response.data else {
            return .failure(response.error?.localizedDescription ?? "Unknown Error")
        }
        
           let result = decodeResult(from: data)
        if let object = result.object {
            return .success(object)
        }
        else {
            return .failure(result.message)
        }
    }

    /// Decodes the response object data to a given class type
    private static func decodeResult(from data:Data)->(object:T?, message:String ){
        do{
            let object = try JSONDecoder().decode(T.self, from: data)
            return (object, "")
        }
        catch{
            return (nil, error.localizedDescription)
        }
    }
    
    /// Prints the request
    private static func printAccess(to provider: ProviderDelegate){
        #if Release
            return
        #endif
        
        if let param = provider.parameters, let theJSONData = try? JSONSerialization.data( withJSONObject: param, options: []) {
            let theJSONText = String(data: theJSONData, encoding: .ascii)
            print("\n ======== URL SENDO ACESSADA ======== \n\n - URL:\n \(provider.path) \n\n - PARAMETROS:\n \(theJSONText ?? "Erro!")\n\n ==================================== \n")
        } else {
            print("\n ======== URL SENDO ACESSADA ======== \n\n - URL:\n \(provider.path) \n\n - PARAMETROS:\n -\n\n ==================================== \n")
        }
    }
    
    /// Prints the result
    private static func printResult(_ result:DataResponse<Any>?){
        #if Release
            return
        #endif
        
        var message:String = ""
        if let result = result {
            let code  = result.response?.statusCode != nil ? "Status: \(result.response!.statusCode)":""
            let value = result.value ?? ""
            message = "\(code)\n\(value)"
        }
        print("\n ======== RESPOSTA DO REQUEST ======== \n\n \(message) \n\n ==================================== \n")
    }
}
