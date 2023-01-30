//
//  FollowersListVC.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 27.01.2023.
//

import UIKit

class FollowersListVC: UIViewController {
    
    enum Section {
        case main
    }

    var username : String!
    var followers : [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section,Follower>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(username: username, page: page)
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
   private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
       }

    private func getFollowers(username: String, page: Int){
        showLoadingView()
        NetworkManager.shared.fetFollowers(for: username, page: page) { [weak self] result in
            #warning("Call Dismiss")
            self?.dismissLoadingView()
            guard let self = self else {return}
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }  //For pagination
                self.followers.append(contentsOf: followers) //For pagination
                self.updateData()
            case .failure(let failure):
                self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: failure.rawValue, buttonTitle: "Ok")
            }
        }
    }
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower  in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData(){
        var snapShot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot,animatingDifferences: true)
        }
    }
}

extension FollowersListVC : UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let hegiht = scrollView.frame.size.height
        
        if offsetY > contentHeight - hegiht {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}
