//
//  ViewController.swift
//  Journey_InterviewTask
//
//  Created by Navaldeep Kaur on 30/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Outlet and Variables
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var tableViewPost: UITableView!
    
    var viewModel : PostViewModel?
    var postList = PostElements()
    var searchedPosts = PostElements()
    var searching = false
    
    //MARK:- View Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //clear search when user come back to post
        searchView.text = ""
        searching = false
        searchedPosts.removeAll()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //call transactionList Api
        postListApiCall()
    }

    //MARK:- Other functions
    func setView(){
        viewModel = PostViewModel.init(Delegate: self, view: self)
        tableViewPost.delegate = self
        tableViewPost.dataSource = self
        tableViewPost.separatorStyle = .none
        tableViewPost.reloadData()
        
        searchView.delegate = self
    }
    
    //MARK:- IBAction
    @IBAction func likeCommentAction(_ sender: Any) {
        showAlertMessage(titleStr: "", messageStr: AlertTitles.comingSoon)
    }
    
    //post api call
    func postListApiCall(){
        viewModel?.postListApi(completion: { [weak self] response in
            guard let self = self else {
                return
              }
            self.postList = response
            self.searchedPosts = self.postList
            //setEmptyMessage method created to show error message on label incase there is no data
            DispatchQueue.main.async {
                self.tableViewPost.setEmptyMessage("")
                self.tableViewPost.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning()
       {
           super.didReceiveMemoryWarning()
       }
}

//MARK:- TransanctionDelegate
extension ViewController : PostDelegate{
    //this method is call in case there is no data return from api end
    func didError(error: String) {
        self.tableViewPost.setEmptyMessage(error)
        self.tableViewPost.reloadData()
    }
}

//MARK:- UITableViewDelegateAndDataSource
extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searching ? searchedPosts.count : postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableCell")as! PostTableCell
        let data = searching ? searchedPosts[indexPath.row] : postList[indexPath.row]
        cell.btnLike.tag = indexPath.row
        cell.btnComment.tag = indexPath.row
        cell.setData(postData:data,searchText: searchView.text ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let CommentsVC = Navigation.GetInstance(of: .CommentsVC) as! CommentsVC
        CommentsVC.postId = searching ? searchedPosts[indexPath.row].id : postList[indexPath.row].id
        self.navigationController?.pushViewController(CommentsVC, animated: false)
    }
}

//MARK:- UISearchBarDelegate

extension ViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            searching = false
            searchedPosts.removeAll()
        }else{
            searching = true
            searchedPosts = postList.filter{$0.title?.range(of: searchText, options: .caseInsensitive) != nil || $0.body?.range(of: searchText, options: .caseInsensitive) != nil}
        }
        if searchedPosts.count == 0{
            self.tableViewPost.setEmptyMessage(AlertTitles.errorMessage)
            tableViewPost.reloadData()
        }else{
            self.tableViewPost.setEmptyMessage("")
            tableViewPost.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}


