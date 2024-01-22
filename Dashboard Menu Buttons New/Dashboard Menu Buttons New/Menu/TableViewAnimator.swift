//
//  CustomTransitionForMenu.swift
//  Dashboard Menu Buttons New
//
//  Created by Hassan Azhar on 05/12/2023.
//

import UIKit

// defining a typealias for ease of use
typealias TableCellAnimation = (UITableViewCell, IndexPath, UITableView) -> Void

// class to animate the tableViews with the presented animation
final class TableViewAnimator {
    private let animation: TableCellAnimation
    
    init(animation: @escaping TableCellAnimation) {
        self.animation = animation
    }
    
    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        animation(cell, indexPath, tableView)
    }
}

///enums providing tableViewCell animations
enum TableAnimationFactory {
    static func makeMoveUpBounceAnimation(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.1,
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                })
        }
    }
}
enum TableAnimation {
    case moveUpBounce(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    
    // provides an animation with duration and delay associated with the case
    func getAnimation() -> TableCellAnimation {
        switch self
        {
        case .moveUpBounce(let rowHeight, let duration, let delay):
            return TableAnimationFactory.makeMoveUpBounceAnimation(rowHeight: rowHeight, duration: duration, delayFactor: delay)
        }
    }
}
