//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Daniel Roszczyk on 21/12/2024.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    private let viewModel: MovieDetailsViewModelProtocol
    private let detailView = MovieDetailsView()
    private var safeArea: UILayoutGuide?
    private var rightBarButtonItem: UIBarButtonItem?
    
    init(viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = detailView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        setupNavigationBar()
        detailView.configure(viewModel.movieDetails)
        viewModel.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Details"
        let image = viewModel.getFavoriteMovieImage()
        let rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTapFavoriteButton))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        self.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func didTapFavoriteButton() {
        viewModel.didTapFavorite()
    }
}

extension MovieDetailsViewController: MovieDetailsViewModelDelegate {
    func favoriteMovieImage(_ image: UIImage?) {
        rightBarButtonItem?.image = image
    }
}
