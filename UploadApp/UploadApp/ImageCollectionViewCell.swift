//
//  ImageCollectionViewCell.swift
//  UploadApp
//
//  Created by Yocelin Garcia Romero on 06/04/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
}
