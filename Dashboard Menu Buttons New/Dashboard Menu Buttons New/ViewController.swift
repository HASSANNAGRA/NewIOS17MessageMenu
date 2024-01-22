//
//  ViewController.swift
//  Dashboard Menu Buttons New
//
//  Created by Hassan Azhar on 04/12/2023.
//

import UIKit

class ViewController: UIViewController,IconTextButtonDelegate {
    func btnpressed(selectedButton: IconTextButton) {
        btnpressed()
    }
    
    
    
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    @IBOutlet weak var animView: UIView!
    @IBOutlet weak var heightAnimView: NSLayoutConstraint!
    @IBOutlet weak var leadingAnimView: NSLayoutConstraint!
    
    var list: [IconTextButtonViewModel] = [
        IconTextButtonViewModel(text: "Analyze", imageName: "analyze_float_icon"),
        IconTextButtonViewModel(text: "Edit", imageName: "edit_float_icon"),
        IconTextButtonViewModel(text: "Notify", imageName: "notify_float_icon"),
        IconTextButtonViewModel(text: "Preview", imageName: "preview_float_icon"),
        IconTextButtonViewModel(text: "Publish", imageName: "publish_float_icon"),
        IconTextButtonViewModel(text: "Services", imageName: "services_float_icon"),
        IconTextButtonViewModel(text: "SetIcon", imageName: "seticon_float_icon"),
        IconTextButtonViewModel(text: "Share", imageName: "share_float_icon"),
        IconTextButtonViewModel(text: "Subscribe", imageName: "subscribe_float_icon")
    ]
    var buttonsList: [IconTextButton] = []
    var buttonTopConstraints: [NSLayoutConstraint] = []
    var lastbuttonConstaint : NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(animView.frame,"frame")
        blur.alpha = 0
        animView.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        self.leadingAnimView.constant = 20
        button.adjustsImageWhenHighlighted = false
        }
    @objc func handleTap() {
        buttonsList.removeAll()
        for buttonTopConstraint in self.buttonTopConstraints {
            buttonTopConstraint.constant = 0
        }
        self.heightAnimView.constant = 20
        self.lastbuttonConstaint.constant = -10
        self.leadingAnimView.constant = 20
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6) {
            self.blur.alpha = 0
            self.button.alpha = 0.5
            for view in self.animView.subviews {
                if let button = view as? IconTextButton {
                    button.alpha = 0
                }
            }
            self.view.layoutIfNeeded()
            self.button.transform = CGAffineTransform.init(scaleX: 0.9, y:0.9).translatedBy(x: 0, y: 0)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.button.transform = .identity
                self.button.alpha = 1
                for view in self.animView.subviews {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    
    @IBAction func action(_ sender: UIButton) {
        self.blur.isHidden = false
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4) {
            self.button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }completion: { completed in
            self.blur.alpha = 0.5
            self.commonInitForButtons()
            self.view.layoutIfNeeded()
            self.animView.alpha = 0.5
            let height = CGFloat(self.list.count*60)
            self.heightAnimView.constant = height - 40
            self.leadingAnimView.constant = 35
            self.button.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3).translatedBy(x: 0, y: -12)
            self.button.alpha = 0.5
            for buttonTopConstraint in self.buttonTopConstraints {
                buttonTopConstraint.constant = 20
            }
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
                self.button.transform = CGAffineTransform.init(scaleX: 6, y: 6).translatedBy(x: 0, y: -29)
                self.button.alpha = 0.0
                self.view.layoutIfNeeded()
                self.animView.alpha = 1
                self.blur.alpha = 1
                for button in self.buttonsList {
                    button.label.alpha = 1
                }
            } completion: { completed in
                
            }
        }
    }
    func btnpressed() {
      handleTap()
    }
    private func commonInitForButtons() {
        for i in 0..<list.count {
            let model = list[i]
            let iconButton = IconTextButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            iconButton.delegate = self
            iconButton.configure(with: model)
            iconButton.label.alpha = 0.0
            buttonsList.append(iconButton)
            self.animView.addSubview(iconButton)
            iconButton.translatesAutoresizingMaskIntoConstraints = false
        }
        setupConstraints()
    }
        func setupConstraints() {
            
            guard let firstButton = buttonsList.first, let lastButton = buttonsList.last else {
                return
            }
            NSLayoutConstraint.activate([
                firstButton.topAnchor.constraint(equalTo: animView.topAnchor, constant: 0),
                firstButton.leadingAnchor.constraint(equalTo: animView.leadingAnchor, constant: 10),
                firstButton.trailingAnchor.constraint(equalTo: animView.trailingAnchor, constant: 0)
            ])
            for i in 1..<buttonsList.count {
                let button = buttonsList[i]
                let top = button.topAnchor.constraint(equalTo: buttonsList[i - 1].bottomAnchor, constant: 0)
                top.isActive = true
                self.buttonTopConstraints.append(top)
                NSLayoutConstraint.activate([
                    button.leadingAnchor.constraint(equalTo: animView.leadingAnchor, constant: 10),
                    button.trailingAnchor.constraint(equalTo: animView.trailingAnchor, constant: 0),
                ])
            }
            lastbuttonConstaint = lastButton.bottomAnchor.constraint(equalTo: animView.bottomAnchor, constant: -30)
            lastbuttonConstaint.isActive = true
            NSLayoutConstraint.activate([
                lastButton.leadingAnchor.constraint(equalTo: animView.leadingAnchor, constant: 10)
            ])
        }
}
