//
//  CommentViewModel.swift
//  Journey_InterviewTask
//
//  Created by Navaldeep Kaur on 03/07/23.
//

import Foundation

protocol CommentsDelegate
{
    func didError(error:String)
}

class CommentsViewModel
{
    typealias successHandler = (CommentElements) -> Void
    var delegate : CommentsDelegate
    var view : CommentsVC
    
    init(Delegate : CommentsDelegate, view : CommentsVC)
    {
        delegate = Delegate
        self.view = view
    }
   
    
    //MARK: - CommentsListApi
    func commentsListApi(postId:Int?,completion: @escaping successHandler)
    {
        let commentApiUrl = APIAddress.postListApi + "/\(postId ?? 0)/comments"
        guard let url = URL(string: commentApiUrl) else {
                   return
               }
               var request = URLRequest(url: url)
               request.httpMethod = ApiMethods.get.rawValue
               self.view.showLoader()
            _ = RestClient.Shared.apiRequest(request, target: self.view) { data, response, error in
        
        guard data != nil else {
                self.delegate.didError(error: AlertTitles.errorMessage)
                return
                       }
                       let decoder = JSONDecoder()
                   if let decodedData = try? decoder.decode(CommentElements.self, from: data!){
                    completion(decodedData)
                    self.view.hideLoader()
                }else{
                    self.view.hideLoader()
                    self.delegate.didError(error: AlertTitles.errorMessage)
                }
      }
    }
}

