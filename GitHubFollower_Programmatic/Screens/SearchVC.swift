//
//  SearchVC.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 26.01.2023.
//

import UIKit

class SearchVC: UIViewController, UITextFieldDelegate {

    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActiobButton = GFButton(color: .systemGreen, title: "Get Followers",systemImageName: "person.3")
    
    var isUsernameEntered : Bool { return !usernameTextField.text!.isEmpty }// If is empty it will return false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView,usernameTextField,callToActiobButton)
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        
        guard isUsernameEntered else {
            presentGFAlert(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😃.", buttonTitle: "Ok")
            return }
        
        usernameTextField.resignFirstResponder()
        
        let followerListVC = FollowersListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureLogoImageView() {
//        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant : CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
//        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
//        view.addSubview(callToActiobButton)
        callToActiobButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActiobButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActiobButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActiobButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50 ),
            callToActiobButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
extension SearchVC: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
