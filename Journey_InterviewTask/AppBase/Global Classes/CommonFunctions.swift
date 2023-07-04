//
//  CommonFunctions.swift
//  Journey_InterviewTask
//
//  Created by Navaldeep Kaur on 03/07/23.
//

import Network
import UIKit
import SystemConfiguration

//For internet check
public class Reachability {
    public func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }
    
}


extension String {
    
    //MARK:- Highlight the searched text
    func highlightText(
          _ text: String,
          with color: UIColor,
          caseInsensitivie: Bool = false,
          font: UIFont = .preferredFont(forTextStyle: .body)) -> NSAttributedString
      {
          let attrString = NSMutableAttributedString(string: self)
          let range = (self as NSString).range(of: text, options: caseInsensitivie ? .caseInsensitive : [])
          attrString.addAttribute(
              .backgroundColor,
              value: color,
              range: range)
          attrString.addAttribute(
              .font,
              value: font,
              range: NSRange(location: 0, length: attrString.length))
          return attrString
      }
    
    //MARK:- Capitalized the first letter of sentence
    var capitalizedSentence: String {
         // 1
         let firstLetter = self.prefix(1).capitalized
         // 2
         let remainingLetters = self.dropFirst().lowercased()
         // 3
         return firstLetter + remainingLetters
     }
    
    
}
