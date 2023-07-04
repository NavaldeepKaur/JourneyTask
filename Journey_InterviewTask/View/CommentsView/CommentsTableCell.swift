//
//  CommentsTableCell.swift
//  Journey_InterviewTask
//
//  Created by Navaldeep Kaur on 02/07/23.
//

import UIKit

class CommentsTableCell: UITableViewCell {
    
    //MARK:- Outlet and Variables
    
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelComment: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var btnReply: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK:- set comments data
    func setData(commentData : CommentModel,view:UIViewController,searchText:String){
        
        //I created a common method "capitalizedSentence" to capitalise the initial letter of sentences and a "highlightedSearchText" method to highlight the content that was searched.
        labelName.attributedText = highlightedSearchText(text: commentData.name?.capitalizedSentence ?? "", searchedText: searchText)
        labelComment.attributedText = highlightedSearchText(text: commentData.body?.capitalizedSentence ?? "", searchedText: searchText)
        labelEmail.text = commentData.email ?? ""
        //show name Initial on image
        view.createImageWithNameInitial(name: String(labelName.text!.first!), imageView: imageUser)
 
    }
    
    //MARK:- Highlight the searched text
    func highlightedSearchText(text:String,searchedText:String) -> NSMutableAttributedString{
        let attrTitleString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: searchedText, options: .caseInsensitive)
        attrTitleString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: range)
        return attrTitleString
    }
}
