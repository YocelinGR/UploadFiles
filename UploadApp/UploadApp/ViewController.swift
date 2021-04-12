//
//  ViewController.swift
//  UploadApp
//
//  Created by Yocelin Garcia Romero on 03/04/21.
//

import UIKit
import Firebase
import CoreServices
import FirebaseUI

class ViewController: UIViewController, CanReceive {
    func passDataBack(imageRef: StorageReference, currentImage: Int) {
        self.images.remove(at: self.currentImage)
        self.currentImage = 0
        if images.count > 0 {
            ImageCarousel.sd_setImage(with: images[self.currentImage], placeholderImage: self.placeholerImage)
        } else {
            ImageCarousel.image = self.placeholerImage
        }
    }
    
    // Outlets
    @IBOutlet weak var ImageCarousel: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var LeftOut: UIButton!
    @IBOutlet weak var RightButton: UIButton!
    
    // Variables
    var currentImage: Int = 0
    var maxImageListSize: Int = 0
    let placeholerImage = UIImage(named: "placeholder")
    
    var images: [StorageReference] = []
    let storage = Storage.storage()
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        LeftOut.isEnabled = true
        RightButton.isEnabled = true
        donwloadAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func RightAction(_ sender: Any) {
        LeftOut.isEnabled = true
                currentImage = currentImage + 1
        if currentImage < images.count && images.count > 0{
                    ImageCarousel.sd_setImage(with: images[currentImage], placeholderImage: self.placeholerImage)
                } else {
                    currentImage = 0
                    ImageCarousel.sd_setImage(with: images[currentImage], placeholderImage: self.placeholerImage)
                }
    }
    
    @IBAction func LeftAction(_ sender: Any) {
        currentImage = currentImage - 1
        if currentImage >= 0{
                    ImageCarousel.sd_setImage(with: images[currentImage], placeholderImage: self.placeholerImage)
                } else {
                    LeftOut.isEnabled = false
                }
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        let userImagePicker = UIImagePickerController()
        userImagePicker.delegate = self
        userImagePicker.sourceType = .photoLibrary
        present(userImagePicker, animated: true, completion: nil)
    }
    
    func uploadImage(imageData: Data){
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        let imagesCount = maxImageListSize
        let storageRef = storage.reference()
        let imageRef = storageRef.child("uploadapp").child("E0JQZWeWPrYvDUAF98QLanwUurk1").child("\(imagesCount + 1).jpg")
        maxImageListSize += 1
        // metadata
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        // data de la foto (buffer de foto) y tipo de datos de la imagen
        imageRef.putData(imageData, metadata: uploadMetaData) { (metadata, error) in
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            if let error = error{
                print(error.localizedDescription)
            } else{
                print("Image metadata: \(String(describing: metadata))")
                self.downloadImage(imageDownloadUrlRef: imageRef)
                self.ImageCarousel.sd_setImage(with: self.images[self.images.count - 1], placeholderImage: self.placeholerImage)
                self.currentImage = self.images.count - 1
            }
        }
    }
    
    func downloadImage(imageDownloadUrlRef: StorageReference){
        images.append(imageDownloadUrlRef)
        
        
        imageDownloadUrlRef.downloadURL { (url, error) in
            if let error = error{
                print(error.localizedDescription)
            } else {
                print("URL: \(String(describing: url!))")
            }
            
        }
    }
    func donwloadAll(){
        let storageReference = storage.reference().child("uploadapp/E0JQZWeWPrYvDUAF98QLanwUurk1")
        storageReference.listAll { (result, error) in
          if let error = error {
            print(error.localizedDescription)
          }
          for item in result.items {
            self.downloadImage(imageDownloadUrlRef: item)
          }
            if self.images.count > 0{
                self.ImageCarousel.sd_setImage(with: self.images[self.currentImage], placeholderImage: self.placeholerImage)
            } else {
                self.ImageCarousel.image = self.placeholerImage
                self.LeftOut.isEnabled = false
                self.RightButton.isEnabled = false
            }
            self.maxImageListSize = self.images.count
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? DetailViewController
        vc?.imageRef = self.images[self.currentImage]
        vc?.currentImage = self.currentImage
        vc?.delegate = self
    }
}

extension ViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let optimizeImageData = userImage.jpegData(compressionQuality: 0.6){
            uploadImage(imageData: optimizeImageData)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UINavigationControllerDelegate{
    
}
