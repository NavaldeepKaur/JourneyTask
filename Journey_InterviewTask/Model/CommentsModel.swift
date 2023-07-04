//
//  CommentsModel.swift
//  Journey_InterviewTask
//
//  Created by Navaldeep Kaur on 03/07/23.
//

import Foundation

// MARK: - CommentModel
struct CommentModel : Decodable {
    let postId, id: Int?
    let name, email, body: String?

}

typealias CommentElements = [CommentModel]
