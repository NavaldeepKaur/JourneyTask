//
//  PostViewModel.swift
//  Journey_InterviewTask
//
//  Created by Navaldeep Kaur on 03/07/23.
//

import UIKit

protocol PostDelegate
{
    func didError(error:String)
}

class PostViewModel
{
    typealias successHandler = (PostElements) -> Void
    typealias successHandlerComments = (CommentElements) -> Void
    var delegate : PostDelegate
    var view : UIViewController
    
    init(Delegate : PostDelegate, view : UIViewController)
    {
        delegate = Delegate
        self.view = view
    }
   

    //MARK: - PostListApi
    func postListApi(completion: @escaping successHandler)
    {
        guard let url = URL(string: APIAddress.postListApi) else {
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
                   if let decodedData = try? decoder.decode(PostElements.self, from: data!){
                    completion(decodedData)
                    self.view.hideLoader()
                }else{
                    self.view.hideLoader()
                    self.delegate.didError(error: AlertTitles.errorMessage)
                }
               
      }
    }
}
