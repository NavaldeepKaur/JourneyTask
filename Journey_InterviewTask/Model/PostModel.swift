//
//  PostModel.swift
//  Journey_InterviewTask
//
//  Created by Navaldeep Kaur on 03/07/23.
//

import Foundation

// MARK: - PostModel
struct PostModel : Decodable {
    let userId, id: Int?
    let title, body: String?

}

typealias PostElements = [PostModel]
