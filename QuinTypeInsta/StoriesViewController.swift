//
//  StoriesViewController.swift
//  QuinTypeInsta
//
//  Created by Yogesh S on 2017-10-14.
//  Copyright © 2017 Yogesh S. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class StoriesViewController: UIViewController {
    
    @IBOutlet var storiesCV: UICollectionView!
    @IBOutlet var statusView: UIView!
    @IBOutlet var userProfile: UIImageView!
    @IBOutlet var userName: UILabel!
    
    var usersArray: [User] = [User]()
    var selectedUser:Int?
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    let pageSpacing: CGFloat = 0
    var CurrentStoryIndexPath: (user:Int, story:Int) = (0,0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize                = CGSize(width: view.frame.width, height: view.frame.height)
        layout.scrollDirection         = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing      = 0
        storiesCV.collectionViewLayout = layout
        storiesCV.delegate = self
        storiesCV.dataSource = self
        storiesCV.dataSource = self
        storiesCV.register(UINib(nibName: "ImageStoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageStoryCell")
        storiesCV.register(UINib(nibName: "VideoStoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoStoryCell")
    }
    
    override func viewDidLayoutSubviews() {
        if let selectedIndex = selectedUser {
            CurrentStoryIndexPath = (selectedIndex,0)
            storiesCV.scrollToItem(at:IndexPath(item: 0, section: selectedIndex), at: .right, animated: false)
            self.userName.text = usersArray[selectedIndex].userName
            self.userProfile.layer.masksToBounds = true
            self.userProfile.alpha = 0.8
            self.userProfile.layer.cornerRadius = 25
            self.userProfile.image = UIImage(named: usersArray[selectedIndex].profileImage)
            let StoryDurations = getUserStoriesDuration(index:selectedIndex)
            let spb = SegmentedProgressBar(numberOfSegments: usersArray[selectedIndex].userStories.count, duration: StoryDurations)
            spb.frame = CGRect(x: 0, y:5 , width: view.frame.width, height: 5)
            spb.tag = 1
            spb.delegate = self
            spb.topColor = UIColor.white
            spb.bottomColor = UIColor.white.withAlphaComponent(0.25)
            spb.padding = 2
            self.view.addSubview(spb)
            spb.startAnimation()
            selectedUser = nil
        }
    }
    
    override func viewWillLayoutSubviews() {
        storiesCV.collectionViewLayout.invalidateLayout()
    }
    
    func getUserStoriesDuration(index:Int) -> [TimeInterval] {
        var durations:[TimeInterval] = [TimeInterval]()
        for story in usersArray[index].userStories {
            if story.storyType == "Image" {
                durations.append(5.0)
            } else {
                durations.append(15.0)
            }
        }
        return durations
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func btnClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension StoriesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return usersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersArray[section].userStories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath:  IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if usersArray[indexPath.section].userStories[indexPath.row].storyType == "Image" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageStoryCell", for: indexPath) as! ImageStoryCollectionViewCell
            cell.ImgStoryView.image = UIImage(named: usersArray[indexPath.section].userStories[indexPath.row].storyFileName)
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoStoryCell", for: indexPath) as! VideoStoryCollectionViewCell
            let videoFileName = usersArray[indexPath.section].userStories[indexPath.row].storyFileName
            playMe(videoView: cell.videoStoryView, fileName: videoFileName)
            return cell
        }
    }
    
    
    func playMe(videoView:UIView, fileName:String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        let url = URL.init(fileURLWithPath: path)
        DispatchQueue.main.async {
            let player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoView.layer.addSublayer(playerLayer)
            player.play()
        }
        
    }
}

extension StoriesViewController : SegmentedProgressBarDelegate {
    func segmentedProgressBarChangedIndex(index: Int) {
        if CurrentStoryIndexPath.story < usersArray[CurrentStoryIndexPath.user].userStories.count-1 {
            storiesCV.scrollToItem(at:IndexPath(item: index, section: CurrentStoryIndexPath.user), at: .right, animated: true)
            CurrentStoryIndexPath = (CurrentStoryIndexPath.user,CurrentStoryIndexPath.story+1)
        }
    }
    
    func segmentedProgressBarFinished() {
        if CurrentStoryIndexPath.user < usersArray.count-1 {
            storiesCV.scrollToItem(at:IndexPath(item: 0, section: CurrentStoryIndexPath.user+1), at: .right, animated: true)
            CurrentStoryIndexPath = (CurrentStoryIndexPath.user+1,0)
            if let viewWithTag = self.view.viewWithTag(1) {
                viewWithTag.removeFromSuperview()
            }
            self.userName.text = usersArray[CurrentStoryIndexPath.user].userName
            self.userProfile.layer.masksToBounds = true
            self.userProfile.alpha = 0.8
            self.userProfile.layer.cornerRadius = 25
            self.userProfile.image = UIImage(named: usersArray[CurrentStoryIndexPath.user].profileImage)
            let StoryDurations = getUserStoriesDuration(index:CurrentStoryIndexPath.user)
            let spb = SegmentedProgressBar(numberOfSegments:usersArray[CurrentStoryIndexPath.user].userStories.count, duration: StoryDurations)
            spb.frame = CGRect(x: 0, y:5 , width: view.frame.width, height: 5)
            spb.tag = 1
            spb.delegate = self
            spb.topColor = UIColor.white
            spb.bottomColor = UIColor.white.withAlphaComponent(0.25)
            spb.padding = 2
            self.view.addSubview(spb)
            spb.startAnimation()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
