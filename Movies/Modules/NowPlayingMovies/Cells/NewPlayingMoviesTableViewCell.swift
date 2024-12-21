//
//  NewPlayingMoviesTableViewCell.swift
//  Movies
//
//  Created by Daniel Roszczyk on 20/12/2024.
//

import UIKit

protocol NewPlayingMoviesTableViewCellDelegate: AnyObject {
    func didTapFavoriteButton(_ cell: NewPlayingMoviesTableViewCell)
}

final class NewPlayingMoviesTableViewCell: UITableViewCell {
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favoriteImageView: UIImageView!
    
    @IBAction private func didTapFavoriteButton(_ sender: Any) {
        delegate?.didTapFavoriteButton(self)
    }
    
    weak var delegate: NewPlayingMoviesTableViewCellDelegate?
    var indexPath: IndexPath?
    
    func configure(_ model: NewPlayingMoviesCellModel, indexPath: IndexPath) {
        titleLabel.text = model.title
        favoriteImageView.image = model.favorite
        
        if let imageURL = model.movieImageURL {
            posterImageView.kf.setImage(with: imageURL)
        }
        self.indexPath = indexPath
    }
}
