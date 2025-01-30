//
//  HomePageCollectionViewCell.swift
//  FilmFlow
//
//  Created by İrem Onart on 27.01.2025.
//

import UIKit
import Kingfisher
import Hero

class HomePageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var filmContentView: UIView!
    @IBOutlet private weak var filmImageView: UIImageView!
    @IBOutlet private weak var filmNameLabel: UILabel!
    @IBOutlet private weak var filmImdbLabel: UILabel!
    @IBOutlet private weak var filmYearLabel: UILabel!
    @IBOutlet private weak var filmLabelsView: UIView!
    
    var setHeroID: String? {
        didSet {
            filmContentView.hero.id = setHeroID
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        filmImageView.contentMode = .scaleAspectFill
        filmImageView.clipsToBounds = true
        setupBlurEffect() 
        addCornerRadiusAndShadow()
        self.contentView.isUserInteractionEnabled = true
    }
    
    private func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = filmLabelsView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        filmLabelsView.insertSubview(blurEffectView, at: 0)
        filmLabelsView.backgroundColor = .clear
    }
    
    private func addCornerRadiusAndShadow() {
        filmContentView.layer.cornerRadius = 10
        filmContentView.layer.masksToBounds = true
        filmContentView.layer.shadowColor = UIColor.black.cgColor
        filmContentView.layer.shadowOpacity = 0.3
        filmContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        filmContentView.layer.shadowRadius = 4
        filmContentView.layer.shadowPath = UIBezierPath(roundedRect: filmContentView.bounds, cornerRadius: 10).cgPath
    }
    
    func arrangeCell(filmInfos: Film) {
        filmNameLabel.text = filmInfos.title
        filmImdbLabel.text = "IMDB: \(filmInfos.imdbID ?? "")"
        filmYearLabel.text = "Year: \(filmInfos.year ?? "")"
        if let url = URL(string: filmInfos.poster ?? "") {
            filmImageView.kf.setImage(with: url)
        }
        self.hero.id = "filmPoster"
    }
    
}
