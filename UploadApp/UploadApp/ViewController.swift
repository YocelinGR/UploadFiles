//
//  ViewController.swift
//  UploadApp
//
//  Created by Yocelin Garcia Romero on 03/04/21.
//

import UIKit

class ViewController: UIViewController {
    var currentImage = 0
    let photoList = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5")]
    @IBOutlet weak var ImageCarousel: UIImageView!
    @IBOutlet weak var LeftOut: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ImageCarousel.image = photoList[currentImage]
        LeftOut.isEnabled = false
    }

    @IBAction func RightAction(_ sender: Any) {
        LeftOut.isEnabled = true
        currentImage = currentImage + 1
        if currentImage < photoList.count{
            ImageCarousel.image = photoList[currentImage]
        } else {
            currentImage = 0
            ImageCarousel.image = photoList[currentImage]
        }
    }
    
    @IBAction func LeftAction(_ sender: Any) {
        currentImage = currentImage - 1
        if currentImage >= 0{
            ImageCarousel.image = photoList[currentImage]
        } else {
            LeftOut.isEnabled = false
        }
    }
}

