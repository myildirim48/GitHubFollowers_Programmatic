//
//  FollowersListVC.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 27.01.2023.
//

import UIKit

class FollowersListVC: GFDataLoadingVC {
    
    enum Section {
        case main
    }

    var username : String!
    var followers : [Follower] = []
    var filtiredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false //For slow connections
    
    var collectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section,Follower>!
    
    init(username:String){
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(username: username, page: page)
        configureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
   private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
       let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
       navigationItem.rightBarButtonItem = addButton
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
       }

    private func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
    }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower  in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    

    private func getFollowers(username: String, page: Int){
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.GetFollowers(for: username, page: page) { [weak self] result in
            self?.dismissLoadingView()
            
            guard let self = self else {return}
            
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
            case .failure(let failure):
                self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: failure.rawValue, buttonTitle: "Ok")
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    private func updateUI(with followers: [Follower]){
        if followers.count < 100 { self.hasMoreFollowers = false }  //For pagination
        self.followers.append(contentsOf: followers) //For pagination
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them. 😃"
            DispatchQueue.main.async { self.showEmptyStateview(with: message, in: self.view) }
            return
        }
        self.updateData(on:self.followers)
    }
    
    private func updateData(on followers: [Follower]){
        var snapShot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot,animatingDifferences: true)
        }
    }
    
    @objc func addButtonTapped(){
        #warning("AddButton Tapped")
        
        showLoadingView()
        NetworkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else {return}
        self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavorites(with: user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
    }
    private func addUserToFavorites(with user:User){
        let favorite =  Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] err in
            guard let self = self else { return }
            
            guard let error = err else {
                self.presentGFAlertOnMainThread(title: "Success", message: "You have successfully favorited this user.🥳", buttonTitle: "Hooraayy!")
                return
            }
            
            self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
}

extension FollowersListVC : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let hegiht = scrollView.frame.size.height
        
        if offsetY > contentHeight - hegiht {
            guard hasMoreFollowers,!isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filtiredFollowers : followers
        let follower    = activeArray[indexPath.item]
        
        let destVC      = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowersListVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filtiredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching = true
        filtiredFollowers = followers.filter({$0.login.lowercased().contains(filter.lowercased())})
        updateData(on: filtiredFollowers)
    }
}

extension FollowersListVC: UserInfoVCDelegate {
    
    func didRequestFollowers(for username: String) {
        //Get followers for that user
        self.username = username
        title = username
        page = 1
        
        followers.removeAll()
        filtiredFollowers.removeAll()
//        collectionView.setContentOffset(.zero, animated: true)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
