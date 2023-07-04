//
//  PostTableCell.swift
//  Journey_InterviewTask
//
//  Created by Navaldeep Kaur on 02/07/23.
//

import UIKit

class PostTableCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelLike: UILabel!
    @IBOutlet weak var labelComments: UILabel!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(postData: PostModel,searchText:String){

        //I created a common method "capitalizedSentence" to capitalise the initial letter of sentences and a "highlightedSearchText" method to highlight the content that was searched.
        labelTitle.attributedText = highlightedSearchText(text: postData.title?.capitalizedSentence ?? "", searchedText: searchText)
        labelDescription.attributedText = highlightedSearchText(text: postData.body?.capitalizedSentence ?? "", searchedText: searchText)
        
    }
    
    //MARK:- Highlight the searched text
    func highlightedSearchText(text:String,searchedText:String) -> NSMutableAttributedString{
        let attrTitleString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: searchedText, options: .caseInsensitive)
        attrTitleString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: range)
        return attrTitleString
    }

}
