//
//  CommentsVC.swift
//  Journey_InterviewTask
//
//  Created by Navaldeep Kaur on 02/07/23.
//

import UIKit

//MARK:- Outlet and Variables

class CommentsVC: UIViewController {

    //MARK:- Outlet and Variables
    @IBOutlet weak var tableViewComments: UITableView!
    @IBOutlet weak var searchBarComment: UISearchBar!
    
    var viewModel : CommentsViewModel?
    var commentList = CommentElements()
    var postId : Int?
    var searchedComments = CommentElements()
    var searching = false
    
    //MARK:- View Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //call transactionList Api
        commentsListApiCall()
    }
    
    //MARK:- Other functions
    func setView(){
        viewModel = CommentsViewModel.init(Delegate: self, view: self)
        tableViewComments.delegate = self
        tableViewComments.dataSource = self
        tableViewComments.separatorStyle = .none
        tableViewComments.reloadData()
        
        searchBarComment.delegate = self
        
        self.navigationItem.title = AlertTitles.commentsTitle
        let image = UIImage(named: "blackBack")?.withRenderingMode(.alwaysTemplate)
        let backItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButton))
        backItem.tintColor = .white
        self.navigationItem.leftBarButtonItem = backItem

    }
    
    //MARK:- IBAction
    @IBAction func replyAction(_ sender: Any) {
        showAlertMessage(titleStr: "", messageStr: AlertTitles.comingSoon)
    }
    
    @objc func backButton(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: false)
    }
    //comments list APi call
    func commentsListApiCall()
    {
        viewModel?.commentsListApi(postId: postId, completion: { [weak self] response in
            guard let self = self else {

                return

              }
            self.commentList = response
            self.searchedComments = self.commentList
            //setEmptyMessage method created to show error message on label incase there is no data
            DispatchQueue.main.async {
                self.tableViewComments.setEmptyMessage("")
                self.tableViewComments.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning()
       {
           super.didReceiveMemoryWarning()
       }
}

//MARK:- TransanctionDelegate
extension CommentsVC : CommentsDelegate{
    //this method is call in case there is no data return from api end
    func didError(error: String) {
        self.tableViewComments.setEmptyMessage(error)
        self.tableViewComments.reloadData()
    }
}

//MARK:- UITableViewDelegateAndDataSource
extension CommentsVC : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searching ? searchedComments.count : commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableCell")as! CommentsTableCell
        let data = searching ? searchedComments[indexPath.row] : commentList[indexPath.row]
        cell.btnLike.tag = indexPath.row
        cell.btnReply.tag = indexPath.row
        cell.setData(commentData: data,view: self, searchText: searchBarComment.text ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: false)
       
    }
}


//MARK:- UISearchBarDelegate

extension CommentsVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searching = false
            searchedComments.removeAll()
        }else{
            searching = true
            searchedComments = commentList.filter{$0.name?.range(of: searchText, options: .caseInsensitive) != nil || $0.body?.range(of: searchText, options: .caseInsensitive) != nil}
        }
        if searchedComments.count == 0{
            self.tableViewComments.setEmptyMessage(AlertTitles.errorMessage)
            tableViewComments.reloadData()
        }else{
            self.tableViewComments.setEmptyMessage("")
            tableViewComments.reloadData()
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}


