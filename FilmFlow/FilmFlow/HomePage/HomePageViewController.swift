//
//  HomePageViewController.swift
//  FilmFlow
//
//  Created by İrem Onart on 26.01.2025.
//

import UIKit
import Hero

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var emptyPageImage: UIImageView!
    
    var viewModel: HomePageViewModelProtocol = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        attachViewModel()
        setUpNavigationBar()
        Loader.initializeLoader()
        self.hero.isEnabled = true
    }
    
    private func attachViewModel() {
        viewModel.changeHandler = { [weak self] change in
            guard let self else { return }
            switch change {
            case .startLoading:
                Loader.show()
            case .endLoading:
                Loader.dismiss()
            case .didError(let message, let title):
                DispatchQueue.main.async {
                    self.showAlert(message: message, title: title)
                }
            case .success:
                print("success")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .hideFilmFound:
                DispatchQueue.main.async {
                    self.emptyPageImage.isHidden = true
                }
            default:
                return
            }
        }
    }
    
    func setUpUI() {
        view.backgroundColor = .darkGray
        collectionView.backgroundColor = .darkGray
        nameTextField.layer.masksToBounds = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        nameTextField.delegate = self
        
        let nib = UINib(nibName: "HomePageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "HomePageCollectionViewCell")
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    func setUpNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Home Page"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textAlignment = .center
        
        navigationItem.titleView = titleLabel
        navigationItem.hidesBackButton = true
    }
    
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let filmName = nameTextField.text else {
            return
        }
        Loader.show()
        viewModel.fetchFilm(filmName: filmName)
        dismissKeyboard()
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(message: String, title: String = "Error") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UICollectionViewDataSource ve UICollectionViewDelegate
extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numofFilms
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionViewCell", for: indexPath) as! HomePageCollectionViewCell
        let film = viewModel.indexOfFilms(at: indexPath)
        cell.arrangeCell(filmInfos: film)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Hücreye tıklandı: \(indexPath)")
        let selectedFilm = viewModel.indexOfFilms(at: indexPath)
        let vm = FilmDetailViewModel()
        vm.film = selectedFilm
        let vc = FilmDetailViewController()
        vc.viewModel = vm
        if let cell = collectionView.cellForItem(at: indexPath) as? HomePageCollectionViewCell {
            let heroID = "filmPoster"
            vc.view.hero.id = heroID
            cell.setHeroID = heroID
        }
        vc.hero.isEnabled = true
        self.navigationController?.hero.navigationAnimationType = .push(direction: .down)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 30) / 2
        let cellHeight: CGFloat = 300
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension HomePageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}

