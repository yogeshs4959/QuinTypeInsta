//
//  ViewController.swift
//  QuinTypeInsta
//
//  Created by Yogesh S on 2017-10-12.
//  Copyright © 2017 Yogesh S. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    var usersArray: [User] = [User]()
    var picker:UIImagePickerController?=UIImagePickerController()
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "UserProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "userProfileCell")
        picker?.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        fetchDataFromLocalJson()
    }

    @IBAction func btnClickCamera(_ sender: Any) {
        openCamera()
    }
    
    
    func fetchDataFromLocalJson() {
       let dict = NetworkManager.getJsonDictionaryFromFile(fileName: "usersWithStories")
       usersArray =  DataManager.parseJsonDictionary(dict: dict)
       collectionView.reloadData()
    }
    
    func playMe() {
        guard let path = Bundle.main.path(forResource: "giphy", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        let url = URL.init(fileURLWithPath: path)
        
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func ShowAlert(title:String, messsage: String) {
        let alertView = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
        })
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }

}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersArray.count+1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath:  NSIndexPath) -> CGSize {
        return CGSize(width: 100, height:120)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userProfileCell", for: indexPath) as! UserProfileCollectionViewCell
        cell.imgProfilePic.layer.masksToBounds=true
        cell.imgProfilePic.layer.borderWidth = 3.0
        cell.imgProfilePic.alpha = 0.8
        cell.imgProfilePic.layer.borderColor = UIColor.orange.cgColor
        cell.imgProfilePic.layer.cornerRadius = 45
        if indexPath.row == 0 {
            cell.btnPlus.isHidden = false
            cell.lblName.text = "You"
            cell.imgProfilePic.image = UIImage(named:"myProfile")
        } else {
            cell.btnPlus.isHidden = true
            cell.lblName.text = usersArray[indexPath.row-1].userName
            cell.imgProfilePic.image = UIImage(named: usersArray[indexPath.row-1].profileImage)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            openGallary()
        }
    }
}

extension ViewController : UIPickerViewDelegate, UIPopoverControllerDelegate,UINavigationControllerDelegate {

    func openGallary() {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerControllerSourceType.camera
            picker!.cameraCaptureMode = .photo
            present(picker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        dismiss(animated: true, completion: nil)
    }
    
}

