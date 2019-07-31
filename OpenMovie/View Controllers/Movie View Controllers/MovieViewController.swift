//
//  MovieViewController.swift
//  OpenMovie
//
//  Created by Miloslav Milenkov on 29/07/2019.
//  Copyright © 2019 Miloslav G. Milenkov. All rights reserved.
//

import UIKit
import Cosmos

class MovieViewController: UIViewController {
    
    var viewModel: MovieViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            setupViewModel(with: viewModel)
        }
    }
    private var searchController: UISearchController!
    
    
    @IBOutlet var rating: CosmosView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var plot: UILabel!
    @IBOutlet var details: UILabel!
    @IBOutlet var poster: UIImageView!
    @IBOutlet var baseTextLabels: [UILabel]! {
        didSet {
            for label in baseTextLabels {
                label.textColor = .textBase
            }
        }
    }
    @IBOutlet var headerTextLabels: [UILabel]! {
        didSet {
            for label in headerTextLabels {
                label.textColor = .textHeader
            }
        }
    }
    @IBOutlet var actorCollection:UICollectionView! {
        didSet {
            actorCollection.dataSource = self
            actorCollection.showsVerticalScrollIndicator = false
        }
    }
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    @IBOutlet var dataViews: [UIView]! {
        didSet {
            for view in dataViews {
                view.isHidden = true
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .backgroundBase
        actorCollection.backgroundColor = .backgroundBase
    }
    
    private func setupViewModel(with viewModel: MovieViewModel) {
        activityIndicatorView.stopAnimating()
        
        movieTitle.text = viewModel.title
        plot.text = viewModel.plot
        details.text = viewModel.details
        poster.image = viewModel.image
        rating.rating = Double(viewModel.score) ?? 0
        rating.text = viewModel.score
        rating.settings.fillMode = .half
        actorCollection.reloadData()
        
        for view in dataViews {
            view.isHidden = false
        }
    }
}

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.actors.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCell", for:indexPath) as? ActorCell else {
            fatalError()
        }
        
        guard let viewModel = viewModel else { fatalError() }
        cell.configure(with: viewModel.actors[indexPath.item])
        return cell
    }
    
}
