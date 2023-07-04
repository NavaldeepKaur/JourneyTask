//
//  RestClient.swift
//  Journey_InterviewTask
//
//  Created by Navaldeep Kaur on 03/07/23.
//

import Foundation
import Network
import UIKit

class RestClient {
    
    static let Shared = RestClient()
    var session: URLSession
      
    init() {
        session = URLSession(configuration: .default)
    }
    
    func apiRequest(_ request: URLRequest, target : UIViewController,completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask? {
        
        if Reachability().isConnectedToNetwork() == true {
            let sessionTask = session.dataTask(with: request, completionHandler: completionHandler)
            sessionTask.resume()
            return sessionTask
        }else{
            target.hideLoader()
            target.showAlertMessage(titleStr: AlertTitles.noInternetTitle, messageStr: AlertTitles.internetMessage)
            return nil
        }
        
        
    }
    
    func cancelAllTasks() {
        session.getAllTasks { (tasks) in
            for task in tasks {
                task.cancel()
            }
        }
    }
    
}
