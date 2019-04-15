//
//  ViewController.swift
//  RecognizerDemo
//
//  Created by Can Khac Nguyen on 4/15/19.
//  Copyright © 2019 Can Khac Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    var initialCenter: CGPoint = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotationGesture(_:)))
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        let screenEdgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgePanGesture(_:)))
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        
        for gesture in [tapGesture, pinchGesture, rotationGesture, swipeGesture, panGesture, screenEdgePanGesture, longPressGesture] {
            contentView.addGestureRecognizer(gesture)
        }
    }
    
    @objc func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 5.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                self?.contentView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        }) { [weak self] _ in
                self?.contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }

    @objc func handlePinchGesture(_ recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .began || recognizer.state == .changed {
            contentView.transform = contentView.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1.0
        }
    }
    
    @objc func handleRotationGesture(_ recognizer: UIRotationGestureRecognizer) {
        if recognizer.state == .began || recognizer.state == .changed {
            contentView.transform = contentView.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0.0
        }
    }
    
    @objc func handleSwipeGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            contentView.backgroundColor = contentView.backgroundColor == .red ? .blue : .red
        }
    }
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = recognizer.translation(in: contentView.superview)
        if recognizer.state == .began {
            // Save the view's original position.
            initialCenter = contentView.center
        }
        // Update the position for the .began, .changed, and .ended states
        if recognizer.state != .cancelled {
            // Add the X and Y translation to the view's original position.
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            contentView.center = newCenter
        }
        else {
            // On cancellation, return the piece to its original location.
            contentView.center = initialCenter
        }
    }
    
    @objc func handleScreenEdgePanGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        print(recognizer.edges)
    }
    
    @objc func handleLongPressGesture(_ recognizer: UILongPressGestureRecognizer) {
        print("AAAAAAAAAA")
    }

}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print(gestureRecognizer)
        return true
    }
}
