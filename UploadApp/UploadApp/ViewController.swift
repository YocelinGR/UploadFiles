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

class ViewController: UIViewController {
    // Outlets
    @IBOutlet weak var ImageCarousel: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var LeftOut: UIButton!
    
    //@IBOutlet weak var imageCollection: UICollectionView!
    
    // Variables
    var currentImage: Int = 0
    var maxImageListSize: Int = 0
    let photoList: Array = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5")]
    let placeholerImage = UIImage(named: "placeholder")
    
    var images: [StorageReference] = []
    let storage = Storage.storage()
   
    
    

    override func viewDidLoad() {
        /*let nib = UINib.init(nibName: "ImageCollectionViewCell", bundle: nil)
        imageCollection.register(nib, forCellWithReuseIdentifier: "imageCellXIB")*/
        super.viewDidLoad()
        LeftOut.isEnabled = false
        
        donwloadAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }

    @IBAction func RightAction(_ sender: Any) {
        LeftOut.isEnabled = true
        currentImage = currentImage + 1
        if currentImage < images.count{
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
            }
        }
        downloadImage(imageDownloadUrlRef: imageRef)
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
            print("ITEMS: \(item)")
          }
            
            print(">>>>>>>>><images: \(self.images)")
            if self.images.count > 0{
                self.ImageCarousel.sd_setImage(with: self.images[self.currentImage], placeholderImage: self.placeholerImage)
            } else {
                self.ImageCarousel.image = self.photoList[self.currentImage]
            }
            self.maxImageListSize = self.images.count
        }
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

/*extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCellXIB", for: indexPath) as! ImageCollectionViewCell
        
        
        let ref = images[indexPath.item]
        
        cell.imageViewCell.sd_setImage(with: ref, placeholderImage: placeholerImage)
        
        /*ref.downloadURL { (url, error) in
            if let error = error{
                print(error.localizedDescription)
            } else {
                print("URL: \(String(describing: url!))")
            }
            
        }*/
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate{
    
}
// maneja lo referente a
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}*/
