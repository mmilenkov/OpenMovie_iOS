//
//  ActorCell.swift
//  OpenMovie
//
//  Created by Miloslav Milenkov on 29/07/2019.
//  Copyright © 2019 Miloslav G. Milenkov. All rights reserved.
//

import UIKit

class ActorCell: UICollectionViewCell {
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var name: UILabel! {
        didSet {
            name.textColor = .textHeader
            name.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
        }
    }
    
    func configure(with representable: String) {
        name.text = representable
        image.image = UIImage(named: "rdj")
    }
}
