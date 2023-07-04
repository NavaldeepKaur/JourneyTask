//
//  NavigationHandling.swift
//  Journey_InterviewTask
//
//  Created by Navaldeep Kaur on 03/07/23.
//

import UIKit

class Navigation
{
    enum Controller
    {
        case CommentsVC
        
        var obj: UIViewController?
        {
            switch self
            {
            case .CommentsVC :
            return StoryBoards.Main.obj?.instantiateViewController(withIdentifier: "CommentsVC")

            }}
    }

    enum StoryBoards
    {
        case Main
        
        var obj: UIStoryboard?
        {
            switch self
            {
            case .Main:
                return UIStoryboard(name: "Main", bundle: nil)
            }
        }
        
    }

   static func GetInstance(of controller : Controller) -> UIViewController
    {
        return controller.obj!
    }

}
