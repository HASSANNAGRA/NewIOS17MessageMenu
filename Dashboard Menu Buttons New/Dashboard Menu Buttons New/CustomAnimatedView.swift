//
//  MainViewController.swift
//
//  Created by Hassan Azhar on 06/12/2023.
//
protocol CustomAnimatedViewDelegate {
    func btnpressed()
}
import UIKit
class CustomAnimatedView: UIView,IconTextButtonDelegate{
    var imageView:UIImageView!
    var initialFrame:CGRect!
    var buttonsList: [IconTextButton] = []
    var firstButtonTopConstraint: NSLayoutConstraint?
    var buttonTopConstraints: [NSLayoutConstraint] = []
    var prev: IconTextButton!
    let list: [IconTextButtonViewModel] = [
        IconTextButtonViewModel(text: "Camera", imageName: "Camera"),
        IconTextButtonViewModel(text: "Photos", imageName: "Photos"),
        IconTextButtonViewModel(text: "Stickers", imageName: "Stickers"),
        IconTextButtonViewModel(text: "ApplePay", imageName: "ApplePay"),
        IconTextButtonViewModel(text: "Audio", imageName: "Audio"),
        IconTextButtonViewModel(text: "More", imageName: "More")
    ]
    var delegate : CustomAnimatedViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        for i in 0..<list.count {
            self.backgroundColor = .blue
            let model = list[i]
            let iconButton = IconTextButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            iconButton.delegate = self
            iconButton.configure(with: model)
            buttonsList.append(iconButton)
            addSubview(iconButton)
            iconButton.translatesAutoresizingMaskIntoConstraints = false
            iconButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(35)).isActive = true
            iconButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
            if prev == nil {
                firstButtonTopConstraint = iconButton.topAnchor.constraint(equalTo: topAnchor, constant: 0)
                firstButtonTopConstraint?.isActive = true
            } else {
                let topCons = iconButton.topAnchor.constraint(equalTo: prev.safeAreaLayoutGuide.bottomAnchor, constant:CGFloat(-20.0))
                topCons.isActive = true
                buttonTopConstraints.append(topCons)
            }
            prev = iconButton
        }
    }
    func btnpressed(selectedButton: IconTextButton) {
        delegate?.btnpressed()
        dismis()
    }
    func animatePresentation(from rect: CGRect, in viewController: UIViewController, completion: (() -> Void)? = nil) {
        var newRect = rect
        newRect.origin.x -= 35
        newRect.origin.y -= 10
        frame = newRect
        self.initialFrame = newRect
        if let containerView = viewController.view {
            containerView.addSubview(self)
        }
        let hreight = (list.count * 60)

        let expectedHeight = CGFloat(CGFloat(hreight) + CGFloat(self.initialFrame.height))
        let finalFrame = CGRect(x: 0, y: viewController.view.frame.height - expectedHeight , width: viewController.view.frame.width, height: expectedHeight)
        UIView.animate(withDuration: 0.1, animations: {
            self.frame = finalFrame
            for constraint in self.buttonTopConstraints {
                constraint.constant = 20
            }
        }, completion: { _ in
            completion?()
        })
    }
    
    func dismis() {
        UIView.animate(withDuration: 0.1, animations: {
            self.frame = self.initialFrame
            for constraint in self.buttonTopConstraints {
                constraint.constant = -20
            }
        }, completion: { _ in
            // Remove the view from the superview
            self.removeFromSuperview()
        })
    }
}
