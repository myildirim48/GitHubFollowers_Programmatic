//
//  GFEmptyStateView.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 30.01.2023.
//

import UIKit

class GFEmptyStateView: UIView {
    let messagelabel = GFTitleLabel(textAligment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   convenience init(message: String) {
       self.init(frame: .zero)
        messagelabel.text = message
    }
    
    private func configure() {
        addSubviews(messagelabel,logoImageView) 
        configureMessagelabel()
        configureLogoImageView()
    }
    
    private func configureMessagelabel(){
//        addSubview(messagelabel)
        messagelabel.numberOfLines = 3
        messagelabel.textColor = .secondaryLabel
        
        let labelCenterYConstant : CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        let messagelabelCenterYConstraint = messagelabel.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: labelCenterYConstant)
        messagelabelCenterYConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            messagelabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messagelabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messagelabel.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    private func configureLogoImageView(){
//        addSubview(logoImageView)
        
        logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoImageBottomConstant : CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        let logoImageViewBottomConstraint = logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: logoImageBottomConstant)
        logoImageViewBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor,multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 170)
        ])
    }
}
