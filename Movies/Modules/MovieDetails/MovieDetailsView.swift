//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Daniel Roszczyk on 21/12/2024.
//

import UIKit
import Kingfisher

final class MovieDetailsView: UIView {
    private var scrollView = UIScrollView()
    private var contentView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        return stackView
    }()
    private var posterImageView = UIImageView()
    private var titleLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private var releaseDateLabel = UILabel()
    private var ratingLabel = UILabel()
    private var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private let margin: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: margin).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -margin).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -margin).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -margin * 2).isActive = true
    }
    
    func configure(_ model: MovieDetailsViewData) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        if let posterImageURL = model.posterImageURL {
            posterImageView.kf.setImage(with: posterImageURL)
        } else {
            let placeholderImage = UIImage(systemName: "photo")
            posterImageView.image = placeholderImage
        }
        if let title = model.title {
            titleLabel.text = "Title: \(title)"
            contentView.addArrangedSubview(titleLabel)
        }
        if let releaseDate = model.releaseDate {
            releaseDateLabel.text = "Release date: \(releaseDate)"
            contentView.addArrangedSubview(releaseDateLabel)
        }
        if let rating = model.rating {
            ratingLabel.text = "Rating: \(rating)"
            contentView.addArrangedSubview(ratingLabel)
        }
        if let overview = model.overview {
            overviewLabel.text = "Overview:\n\(overview)"
            contentView.addArrangedSubview(overviewLabel)
        }
    }
}
