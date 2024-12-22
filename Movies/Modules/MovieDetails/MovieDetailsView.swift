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
    private var contentView = UIView()
    private var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fill
        return stackView
    }()
    private var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
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
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        posterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 3/2).isActive = true
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: margin).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: margin).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -margin).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin).isActive = true
    }
    
    func configure(_ model: MovieDetailsViewData) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        if let posterImageURL = model.posterImageURL {
            posterImageView.kf.setImage(with: posterImageURL)
        } else {
            let placeholderImage = UIImage(systemName: "photo")
            posterImageView.image = placeholderImage
        }
        if let title = model.title {
            titleLabel.text = "Title: \(title)"
            stackView.addArrangedSubview(titleLabel)
        }
        if let releaseDate = model.releaseDate {
            releaseDateLabel.text = "Release date: \(releaseDate)"
            stackView.addArrangedSubview(releaseDateLabel)
        }
        if let rating = model.rating {
            ratingLabel.text = "Rating: \(rating)"
            stackView.addArrangedSubview(ratingLabel)
        }
        if let overview = model.overview {
            overviewLabel.text = "Overview:\n\(overview)"
            stackView.addArrangedSubview(overviewLabel)
        }
    }
}
