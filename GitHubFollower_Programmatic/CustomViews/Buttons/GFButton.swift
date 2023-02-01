//
//  GFButton.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 26.01.2023.
//

import UIKit

class GFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init( backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    private func configure() {
        layer.cornerRadius = 10
//        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor:UIColor, title:String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
