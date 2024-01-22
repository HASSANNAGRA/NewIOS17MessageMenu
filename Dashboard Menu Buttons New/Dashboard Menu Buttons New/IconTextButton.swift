//
//  iconTextButton.swift
//  2nd-assignment
//
//  Created by Hassan Azhar on 06/12/2023.
//

import Foundation
import UIKit

protocol IconTextButtonDelegate {
    func btnpressed(selectedButton : IconTextButton)
}

struct IconTextButtonViewModel {
    let text: String
    let imageName : String
}

final class IconTextButton: UIButton{
    
    var delegate : IconTextButtonDelegate?
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    let icon : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        return imageView
    }()
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(label)
        addSubview(icon)
        isSelected = true
    }
    required init?(coder:NSCoder){
        fatalError()
    }
    func configure(with model:IconTextButtonViewModel){
        label.text = model.text
        icon.image = UIImage(named: model.imageName)?.withRenderingMode(.alwaysTemplate)
        self.addTarget(nil, action: #selector(self.btnClicked(_:)), for: .touchUpInside)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: icon.trailingAnchor,constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    @objc func btnClicked(_ sender: AnyObject?) {
        if sender === self {
            delegate?.btnpressed(selectedButton: sender as! IconTextButton)
        }
    }
}
