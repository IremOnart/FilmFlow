//
//  LoadingAnimation.swift
//  FilmFlow
//
//  Created by İrem Onart on 29.01.2025.
//

import Foundation
import UIKit

class Loader {
    static var backgroundView: UIView!
    static var loaderImage: UIImageView!
    static var loaderImageBackgroundView: UIView!
    
    static var isShowing: Bool {
        guard let window = UIApplication.shared.keyWindow else {
            return false
        }
        if self.backgroundView.isDescendant(of: window) {
            return true
        }
        return false
    }
    
    class func initializeLoader() {
        backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .clear
        backgroundView.isUserInteractionEnabled = true
        
        loaderImage = UIImageView(image: UIImage(named: "loading"))
        loaderImage.contentMode = .scaleAspectFit
        
        loaderImageBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 65))
        loaderImageBackgroundView.layer.cornerRadius = 65 / 2
        loaderImageBackgroundView.backgroundColor = .clear
        loaderImageBackgroundView.addSubview(loaderImage)
        loaderImage.center = CGPoint(x: 32, y: 32)
    }
    
    class func show() {
        self.dismiss()
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow {
                if !self.backgroundView.isDescendant(of: window) {
                    window.addSubview(self.backgroundView)
                    NSLayoutConstraint.activate([
                        self.backgroundView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                        self.backgroundView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                        self.backgroundView.topAnchor.constraint(equalTo: window.topAnchor),
                        self.backgroundView.bottomAnchor.constraint(equalTo: window.bottomAnchor)
                    ])
                }
                if !self.loaderImageBackgroundView.isDescendant(of: window) {
                    window.addSubview(self.loaderImageBackgroundView)
                    self.loaderImageBackgroundView.center = window.center
                    self.startRotating()
                }
            }
        }
    }
    
    class func dismiss() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow {
                if self.backgroundView.isDescendant(of: window) {
                    self.backgroundView.removeFromSuperview()
                }
                if self.loaderImageBackgroundView.isDescendant(of: window) {
                    self.stopRotating()
                    self.loaderImageBackgroundView.removeFromSuperview()
                }
            }
        }
    }
    
    class func startRotating(duration: CFTimeInterval = 1, repeatCount: Float = Float.infinity, clockwise: Bool = true) {
        if self.loaderImageBackgroundView.layer.animation(forKey: "transform.rotation.z") != nil {
            return
        }
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let direction = clockwise ? 1.0 : -1.0
        animation.toValue = NSNumber(value: .pi * 2 * direction)
        animation.duration = duration
        animation.isCumulative = true
        animation.repeatCount = repeatCount
        self.loaderImageBackgroundView.layer.add(animation, forKey: "transform.rotation.z")
    }
    
    class func stopRotating() {
        self.loaderImageBackgroundView.layer.removeAnimation(forKey: "transform.rotation.z")
    }
}
