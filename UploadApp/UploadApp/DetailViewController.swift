//
//  DetailViewController.swift
//  UploadApp
//
//  Created by Yocelin Garcia Romero on 04/04/21.
//

import UIKit
import Firebase
import CoreServices
import FirebaseUI

class DetailViewController: UIViewController {
    
    var imageRef: StorageReference
    let placeholerImage = UIImage(named: "placeholder")
    let storage = Storage.storage()
    
    required init?(coder aDecoder: NSCoder) {
        let storageRef = storage.reference()
        self.imageRef = storageRef.child("images/profile/userProfile.png")
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var imageDatetime: UILabel!
    @IBOutlet weak var imageSize: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageValues()
        // Do any additional setup after loading the view.
    }
    
    func setImageValues(){
        let forestRef = imageRef
        forestRef.getMetadata { metadata, error in
          if let error = error {
            print("An error had happended: \(error)")
          } else {
            print("wwwwwwwttttt: \(String(describing: metadata))")
            self.detailImage.sd_setImage(with: self.imageRef, placeholderImage: self.placeholerImage)
            self.imageName.text = "Nombre: \(metadata?.name ?? "")"
            self.imageDatetime.text = "Fecha: \(metadata?.timeCreated ?? Date())"
            self.imageSize.text = "Size: \(metadata?.size ?? 0)"
          }
        }
    }
    
    @IBAction func likeOrDislike(_ sender: Any) {
    }
    
    @IBAction func deleteImage(_ sender: Any) {
        imageRef.delete { error in
          if let error = error {
            print("An error had happended: \(error)")
          } else {
            print("Sucess")
          }
        }
    }
    
}

