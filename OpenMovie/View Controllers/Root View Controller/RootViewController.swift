//
//  RootViewController.swift
//  OpenMovie
//
//  Created by Miloslav Milenkov on 29/07/2019.
//  Copyright © 2019 Miloslav G. Milenkov. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var viewModel: RootViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            setupViewModel(with: viewModel)
        }
    }
    
    private var movieViewController: MovieViewController = {
        guard let movieViewController = UIStoryboard.main.instantiateViewController(withIdentifier: MovieViewController.storyboardIdentifier) as? MovieViewController else {
            fatalError()
        }
        movieViewController.view.translatesAutoresizingMaskIntoConstraints = false
        return movieViewController
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //viewModel?.fetchMovieData(for: "guardians of the galaxy")
        setupChildControllers()
        setupView()
    }
    
    private func setupViewModel(with viewModel: RootViewModel) {
        viewModel.fetchMovieData(for: "avengers")
        viewModel.didFetchMovieData = {
            [weak self] (result) in
            switch result {
            case .success(let movieData):
                self?.movieViewController.viewModel = MovieViewModel(movieData: movieData)
            case .failure(let error):
                //Add error handling
                print(error.localizedDescription)
            }
        }
    }
    
    func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(presentSearchAlertController))
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        view.backgroundColor = .backgroundBase
    }
    
    @objc private func presentSearchAlertController() {
        let ac = UIAlertController(title: Constants.searchTitle, message: Constants.searchMessage, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Search", style: .default){
            [weak self] _ in
            self?.search(title: ac.textFields?[0].text ?? "")
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
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


}

