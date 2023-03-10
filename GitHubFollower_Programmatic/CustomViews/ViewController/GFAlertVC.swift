//
//  GFAlertVC.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 27.01.2023.
//

import UIKit

class GFAlertVC: UIViewController {

    let containerView = GFAlertContainerView()
    let titleLabel = GFTitleLabel(textAligment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAligment: .center)
    let actionButton = GFButton(color: .systemPink, title: "Ok", systemImageName: SFSymbols.checkMark)
    
    var alerTitle : String?
    var message : String?
    var buttonTitle : String?
    
    let padding : CGFloat = 20
    
    init(alerTitle: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alerTitle = alerTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView,titleLabel,actionButton,messageLabel)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    func configureContainerView() {
//        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
//        containerView.addSubview(titleLabel)
        titleLabel.text = alerTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
    }
    
    func configureActionButton() {
//        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dissmisVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLabel() {
//        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete the request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor,constant: -12)
        ])
    }
    
    @objc func dissmisVC() {
        dismiss(animated: true)
    }
}
