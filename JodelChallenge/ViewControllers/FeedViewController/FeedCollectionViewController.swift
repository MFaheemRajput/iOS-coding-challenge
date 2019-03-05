//
//  FeedCollectionViewController.swift
//  JodelChallenge
//
//  Created by Muhammad Faheem on 17/02/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift
import NotificationBar

private let reuseIdentifier = "CollectionCell"

class FeedCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,EmptyDataSetSource  ,EmptyDataSetDelegate {
    
    var photos: [PhotosViewModel]?
    var loadingVC: LoadingViewController? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        self.collectionView?.emptyDataSetSource = self
        self.collectionView?.emptyDataSetDelegate = self
        self.collectionView?.addSubview(self.refreshControl)
        self.collectionView?.emptyDataSetView { view in
            view.didTapDataButton {

                    print("tap is working ")
                    // If data is empty so user can send request again.
                    self.checkInternetAndCallRequest()
                }
        }
        
        
        self.loadingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController
        present(self.loadingVC!, animated: false) {
            self.loadingVC?.startAnimation()
            // This is first time we are sending the request to flickr
            // To get images from it.
            self.checkInternetAndCallRequest()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.checkInternetAndCallRequest()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Custom Methods
    func checkInternetAndCallRequest(){
        NetworkManager.isReachable { networkManagerInstance in
            self.fetchPhotosfromFlickr()
        }
        NetworkManager.isUnreachable { networkManagerInstance in
            
            DispatchQueue.main.async {
                NotificationBar(over: self, text: "No Internet connectivity", style: .error).show()
                self.loadingVC?.stopAnimation()
                self.loadingVC?.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    fileprivate func fetchPhotosfromFlickr(){
        FlickrApi.fetchPhotos { (photos, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.loadingVC?.stopAnimation()
                    self.loadingVC?.dismiss(animated: false, completion: nil)
                }
                return
            }
            self.photos = nil
            self.photos = self.parsePhotos(photos! as NSArray)
            DispatchQueue.main.async {
                // here i am adding View model layer
                // now this controller comunicating with view model
                self.loadingVC?.stopAnimation()
                self.loadingVC?.dismiss(animated: false, completion: nil)
                self.collectionView?.reloadData()
            }
        }
    }

    
    // TODO: i want to shit this fucntion to Flickr API Class 
    func parsePhotos(_ photosParam: NSArray) -> [PhotosViewModel]? {
        var photoArray = [PhotosViewModel]()
        for photo in photosParam {
            photoArray.append(PhotosViewModel((photo as? NSMutableDictionary)!))
        }
        return photoArray
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "PhotoVC" {
            if let controller = segue.destination as? PhotoViewController {
                if let cell = sender as? CollectionCell{
                    let indexPath = self.collectionView!.indexPath(for: cell)
                    controller.selectedIndex = (indexPath?.row)!
                }
                controller.photos = self.photos
            }
        }
    }
 

    // MARK: UICollectionView DataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        guard photos != nil else {
            //print("result is false")
            return 0
        }
            return photos!.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionCell
        
        // Configure the cell
        guard self.photos != nil else {
            return cell!
        }
        cell?.setupWithPhoto(with: self.photos?[indexPath.row])
        return cell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let kWhateverHeightYouWant = 120
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(kWhateverHeightYouWant))
    }

    // MARK: - Empty Dataset
    // Asks the data source for the title of the dataset.
    // The dataset uses a fixed font style by default, if no attributes are set.
    // If you want a different font style, return a attributed string.
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let titleString = "Ops no data"
        return stringToAttributedString(titleString)
    }
    
    // Asks the data source for the description of the dataset.
    // The dataset uses a fixed font style by default, if no attributes are set.
    // If you want a different font style, return a attributed string.
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let descriptionString = "It seens there is no data found this time, Please try again later."
        return stringToAttributedString(descriptionString)
    }
    
    /// Asks the data source for the title to be used for the specified button state.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString?{
        let buttonTitleString = "Tap to reload."
        return stringToAttributedString(buttonTitleString)
        
    }
    
    /// Asks the delegate for touch permission. Default is true.
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool{
        return true
    }
    
    func stringToAttributedString(_ text: String?) -> NSAttributedString? {
        let attribute = [ kCTForegroundColorAttributeName: UIColor.lightGray]
        guard let textString = text else {
            return NSAttributedString(string: "", attributes: attribute as [NSAttributedStringKey : Any])
        }
        let attributedString = NSAttributedString(string: textString, attributes: attribute as [NSAttributedStringKey : Any])
        return attributedString
    }

    
}
