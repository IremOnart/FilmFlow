//
//  SplashViewController.swift
//  FilmFlow
//
//  Created by İrem Onart on 26.01.2025.
//

import UIKit
import Hero
import SwiftyGif

class SplashViewController: UIViewController, SwiftyGifDelegate {
    
    @IBOutlet weak var splashLabel: UILabel!
    @IBOutlet weak var splashImageView: UIImageView!
    
    var viewModel: SplashViewModelProtocol = SplashViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachViewModel()
        setUpUI()
        viewModel.checkInternetConnection()
        viewModel.fetchRemoteConfig()
    }
    
    private func attachViewModel() {
        viewModel.changeHandler = { [weak self] change in
            guard let self else { return }
            switch change  {
            case .didError(let message):
                showAlert(message: message)
            case .connectionSuccess:
                print("success")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    print("Navigation controller bulundu")
                    let vc = HomePageViewController()
                    vc.hero.isEnabled = true
                    vc.view.hero.id = "splashText"
                    self.navigationController?.hero.isEnabled = true
                    self.navigationController?.hero.navigationAnimationType = .push(direction: .left)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .remoteConfigSuccess(let splashText):
                DispatchQueue.main.async {
                    self.splashLabel.text = splashText
                }
            default:
                return
            }
        }
    }
    
    func setUpUI() {
        splashImageView.delegate = self
        splashLabel.hero.id = "splashText"
        view.backgroundColor = .lightGray
        
        do {
            let gif = try UIImage(gifName: "output-onlinegiftools.gif")
            setLabelsHiddenAnimation()
            self.splashImageView.setGifImage(gif, loopCount: 1)
        } catch {
            print(error)
        }
    }
    
    func setLabelsHiddenAnimation() {
        UIView.animate(withDuration: 1.0) {
            self.splashLabel.alpha = 0
        } completion: { (_) in
            self.setLabelsShowAnimation()
        }
    }
    
    func setLabelsShowAnimation() {
        UIView.animate(withDuration: 1.5) {
            self.splashLabel.alpha = 1
        } completion: { (_) in
            self.setLabelsHiddenAnimation()
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
