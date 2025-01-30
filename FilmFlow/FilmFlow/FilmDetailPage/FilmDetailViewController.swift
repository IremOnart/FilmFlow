//
//  FilmDetailViewController.swift
//  FilmFlow
//
//  Created by İrem Onart on 28.01.2025.
//

import UIKit
import Kingfisher
import FirebaseAnalytics
import Hero

class FilmDetailViewController: UIViewController {

    @IBOutlet private weak var filmImageView: UIImageView!
    @IBOutlet private weak var blurView: UIView!
    @IBOutlet private weak var filmNameLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var imdbRatingLabel: UILabel!
    @IBOutlet private weak var imdbVotesLabel: UILabel!
    @IBOutlet private weak var runtimeLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var plotLabel: UILabel!
    @IBOutlet private weak var directorNameLabel: UILabel!
    @IBOutlet private weak var castCrewLabel: UILabel!
    @IBOutlet private weak var awardsLabel: UILabel!
    @IBOutlet private weak var filmDetailContentView: UIView!
    
    var viewModel: FilmDetailViewModelProtocol = FilmDetailViewModel()
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        attachViewModel()
        viewModel.fetchFilmDetail()
        self.hero.isEnabled = true
    }
    
    private func attachViewModel() {
        viewModel.changeHandler = { [weak self] change in
            guard let self else { return }
            switch change {
            case .startLoading:
                Loader.show()
                DispatchQueue.main.async {
                    self.filmDetailContentView.isHidden = true
                }
            case .endLoading:
                Loader.dismiss()
                DispatchQueue.main.async {
                    self.filmDetailContentView.isHidden = false
                }
            case .didError(let message):
                DispatchQueue.main.async {
                    self.showAlert(message: message)
                }
            case .fetchSuccess:
                print("success")
                DispatchQueue.main.async {
                    self.filmNameLabel.text = self.viewModel.filmDetail?.title
                    self.yearLabel.text = self.viewModel.filmDetail?.year
                    self.imdbRatingLabel.text = self.viewModel.filmDetail?.imdbRating
                    self.imdbVotesLabel.text = "(\(self.viewModel.filmDetail?.imdbVotes ?? ""))"
                    self.runtimeLabel.text = self.viewModel.filmDetail?.runtime
                    self.genreLabel.text = self.viewModel.filmDetail?.genre
                    self.plotLabel.text = self.viewModel.filmDetail?.plot
                    self.directorNameLabel.text = self.viewModel.filmDetail?.director
                    self.castCrewLabel.text = self.viewModel.filmDetail?.actors
                    self.awardsLabel.text = self.viewModel.filmDetail?.awards
                    
                    Analytics.logEvent("film_detail_viewed", parameters: [
                        "title": self.viewModel.filmDetail?.title ?? "",
                        "year": self.viewModel.filmDetail?.year ?? "",
                        "imdb_rating": self.viewModel.filmDetail?.imdbRating ?? "",
                        "poster_url": self.viewModel.film?.poster ?? "",
                        "runtime": self.viewModel.filmDetail?.runtime ?? "",
                        "genre": self.viewModel.filmDetail?.genre ?? "",
                        "director": self.viewModel.filmDetail?.director ?? "",
                        "actors": self.viewModel.filmDetail?.actors ?? "",
                        "plot": self.viewModel.filmDetail?.plot ?? "",
                        "awards": self.viewModel.filmDetail?.awards ?? "",
                        "imdb_votes": self.viewModel.filmDetail?.imdbVotes ?? "",
                    ])
                }
            default:
                return
            }
        }
    }
    
    func setUpUI() {
        if let url = URL(string: viewModel.film?.poster ?? "") {
            filmImageView.kf.setImage(with: url)
        }
        
        filmImageView.contentMode = .scaleAspectFill
        filmImageView.clipsToBounds = true
        view.backgroundColor = .darkGray
        applyGradientToBlurView()
    }
    
    private func applyGradientToBlurView() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.darkGray.cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        blurView.layer.addSublayer(gradientLayer)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = blurView.bounds
    }
    
    func showAlert(message: String, title: String = "Error") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
