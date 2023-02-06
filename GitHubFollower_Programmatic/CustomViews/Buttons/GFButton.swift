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
    
    convenience init(color: UIColor, title: String, systemImageName:String) {
        self.init(frame: .zero)
        set(color: color, title: title, systemImageName: systemImageName)
    }
    private func configure() {
        
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
        
        //        layer.cornerRadius = 10
        //        setTitleColor(.white, for: .normal)
        //        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    final func set(color:UIColor, title:String, systemImageName:String){
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
        
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
        
        //        self.backgroundColor = backgroundColor
        //        setTitle(title, for: .normal)
    }
}
