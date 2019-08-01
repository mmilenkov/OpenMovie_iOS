//
//  RootViewController.swift
//  OpenMovie
//
//  Created by Miloslav Milenkov on 29/07/2019.
//  Copyright © 2019 Miloslav G. Milenkov. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    private enum ErrorAlertType {
        case noSuchMovieFound
        case noTitleEntered
    }
    
    var viewModel: RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            setupViewModel(with: viewModel)
        }
    }
    var searches = [String]()
    var searchBar: UISearchBar!
    private var movieViewController: MovieViewController = {
        guard let movieViewController = UIStoryboard.main.instantiateViewController(withIdentifier: MovieViewController.storyboardIdentifier) as? MovieViewController else {
            fatalError()
        }
        movieViewController.view.translatesAutoresizingMaskIntoConstraints = false
        return movieViewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        setupView()
    }
    
    private func setupViewModel(with viewModel: RootViewModel) {
        //TODO replace with main screen
        viewModel.fetchMovieData(for: Constants.movies[Int.random(in: 0..<Constants.movies.count)])
        
        viewModel.didFetchMovieData = {
            [weak self] (result) in
            switch result {
            case .success(let movieData):
                self?.movieViewController.viewModel = MovieViewModel(movieData: movieData)
                self?.storeSearch(movieData.Title)
            case .failure(let error):
                self?.presentErrorAlert(of: .noSuchMovieFound)
                print(error.localizedDescription)
            }
        }
    }
    
    func setupView() {
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        view.backgroundColor = .backgroundBase
        setupSearchBar()
        navigationController?.navigationBar.topItem?.titleView = searchBar
        definesPresentationContext = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchForMovie))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "undo"), style: .plain, target: self, action: #selector(backButtonPressed))
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x:0,y:0,width: 200,height:  20))
        searchBar.barStyle = .default
        searchBar.placeholder = Constants.searchBarPrompt
        searchBar.searchBarStyle = .minimal
        searchBar.target
        searchBar.keyboardType = .default
    }
    
    @objc private func searchForMovie() {
        guard let value = searchBar.text else { return }
        if value == "" {
            presentErrorAlert(of: .noTitleEntered)
            return
        }
        search(title: value)
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    private func setupChildControllers() {
        addChild(movieViewController)
        view.addSubview(movieViewController.view)
        
        movieViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        movieViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        movieViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        movieViewController.didMove(toParent: self)
    }
    
    func search(title: String) {
        viewModel?.fetchMovieData(for: title)
    }
    
    private func presentErrorAlert(of alertType: ErrorAlertType) {
        let title: String
        let message: String
        switch alertType {
        case .noSuchMovieFound:
            title = "Unable to find movie"
            message = "The application was unable to find the movie you were looking for. Please check your spelling or try a different one"
        case .noTitleEntered:
            title = ""
            message = "Please enter a movie name prior to clicking the search button"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func backButtonPressed() {
        if searches.count > 1 {
            search(title: searches[searches.count - 2])
            if searches.count > 2 {
                searches.removeFirst(searches.count - 2)
            } else {
                searches.removeFirst()
            }
            print(searches)
        } else {
            search(title: searches[0])
        }
    }
    
    private func storeSearch(_ title: String) {
        if(searches.contains(title)) {
            if let index = searches.firstIndex(of: title) {
                searches.remove(at: index)
            }
        }
        searches.append(title)
    }
}

