//
//  AppConstants.swift
//  Journey_InterviewTask
//
//  Created by Navaldeep Kaur on 03/07/23.
//
import UIKit

enum ApiMethods : String {
    case get = "GET"
    case post = "POST"
}

struct APIAddress {
    static let postListApi = "https://jsonplaceholder.typicode.com/posts"
}

struct AlertTitles {
    static let errorMessage : String = "No Data Found!"
    static let ok : String = "Ok"
    static let noInternetTitle : String = "No internet connection"
    static let internetMessage : String = "It look like you've lost your internet connection.Try again once your connection is back."
    static let commentsTitle = "Comments"
    static let comingSoon = "Coming Soon!"
}

