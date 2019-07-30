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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .backgroundBase
        actorCollection.backgroundColor = .backgroundBase
    }
    
    private func setupViewModel(with viewModel: MovieViewModel) {
        movieTitle.text = viewModel.title
        plot.text = viewModel.plot
        details.text = viewModel.details
        poster.image = viewModel.image
        rating.rating = Double(viewModel.score) ?? 0
        rating.text = viewModel.score
        rating.settings.fillMode = .half
        actorCollection.reloadData()
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
