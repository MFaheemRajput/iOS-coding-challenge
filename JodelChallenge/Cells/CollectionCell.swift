//
//  CollectionCell.swift
//  JodelChallenge
//
//  Created by Muhammad Faheem on 18/02/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CollectionCell: UICollectionViewCell, PhotoViewModelProtocol {
    
    @IBOutlet weak var titleLabel: UILabel! {
        willSet {
            //print("loading start")
            
        }
        didSet {
           // print("loading complete")
            
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        willSet {//print("loading start")
            
        }
        didSet {//print("loading complete")
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization code
    }
    
    public func setupWithPhoto(with photo: PhotosViewModel?) {
        DispatchQueue.main.async {
            
        photo?.delegate = self
        
        guard let indicator = photo?.indicatorView else {
            return
        }
        
        self.addSubview(indicator)
        
        guard let name = photo?.title else {
            self.titleLabel.text = ""
            return
        }
        self.titleLabel!.text = name
        
        guard (photo?.picUrl) != nil else {
            self.titleLabel.text = "No Pic Found"
            return
        }
        guard let img = photo?.image else {
            return
        }
        
        self.imageView!.image = img
            
        }
    }
    
    // MARK:  PhotoModelView Protocol
    func modelValueChange(updated value: PhotosViewModel) {
        self.setupWithPhoto(with: value)
    }

}
