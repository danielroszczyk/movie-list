//
//  NowPlayingMoviesViewController.swift
//  Movies
//
//  Created by Daniel Roszczyk on 20/12/2024.
//

import UIKit

final class NowPlayingMoviesViewController: UIViewController {
    private let tableView = UITableView()
    private let cellIdentifier = "NewPlayingMoviesTableViewCell"
    private let viewModel: NowPlayingMoviesProtocol
    private var safeArea: UILayoutGuide?
    
    init(viewModel: NowPlayingMoviesProtocol = NowPlayingMoviesViewModel()) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        safeArea = view.layoutMarginsGuide
        navigationItem.title = "Now playing movie list"
        viewModel.delegate = self
        setupTableView()
        loadData()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        if let safeArea {
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        } else {
            tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)

        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadData() {
        Task { [weak self] in
            await self?.viewModel.fetchNowPlayingMovies()
        }
    }
    
    private func navigateToMovieDetails(index: Int) {
        guard let movieDetailsViewData = viewModel.getMovieDetailsData(index: index) else {
            return
        }
        let viewModel = MovieDetailsViewModel(movieDetails: movieDetailsViewData)
        viewModel.movieDetailsDelegate = self
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension NowPlayingMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewPlayingMoviesTableViewCell else {
            fatalError()
        }
        guard let movie = viewModel.getMovieCellModel(index: indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(movie, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

extension NowPlayingMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToMovieDetails(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfMovies() - 2 {
            loadData()
        }
    }
}

extension NowPlayingMoviesViewController: NewPlayingMoviesCellModelDelegate {
    func reloadCell(index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
    
    func fetchedData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension NowPlayingMoviesViewController: NewPlayingMoviesTableViewCellDelegate {
    func didTapFavoriteButton(_ cell: NewPlayingMoviesTableViewCell) {
        guard let index = cell.indexPath?.row else { return }
        viewModel.didTapFavorite(index: index)
    }
}

extension NowPlayingMoviesViewController: MovieDetailsDelegate {
    func didTapFavorite(movieId: Int, isFavorite: Bool) {
        viewModel.didTapFavorite(movieId: movieId, isFavorite: isFavorite)
    }
}
