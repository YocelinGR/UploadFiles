//
//  CustomImageFlowLayout.swift
//  UploadApp
//
//  Created by Yocelin Garcia Romero on 06/04/21.
//

import UIKit

class CustomImageFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super .init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        setupLayout()
    }
    
    override var itemSize: CGSize{
        set {}
        get{
            let numberOfColumns: CGFloat = 3
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1)) / numberOfColumns
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    func setupLayout(){
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        scrollDirection = .vertical
    }
}
