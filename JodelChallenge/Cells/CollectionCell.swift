//
//  CollectionCell.swift
//  JodelChallenge
//
//  Created by Muhammad Faheem on 18/02/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell, PhotoViewModelProtocol {
    
    @IBOutlet weak var titleLabel: UILabel! {
        willSet {
            //print("loading start")
            
        }
        didSet {
           // print("loading complete")
            
        }
    }
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView! {
        willSet {//print("loading start")
            
        }
        didSet {//print("loading complete")
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization code
        //self.titleLabel = UILabel()
        //self.imageView = UIImageView()
        
    }
    public func setupWithPhoto(with photo: PhotosViewModel?) {
        photo?.delegate = self
        
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
            //self.titleLabel.text = "No Pic Found"
            return
        }
        
        self.imageView!.image = img
        
//        indicator.startAnimating()
//        self.imageView!.setImageWith(URLRequest(url: url), placeholderImage: nil, success: { request, response, image in
//            self.imageView!.image = image
//            self.indicator.isHidden = true
//            self.indicator.stopAnimating()
//        }, failure: { request, response, error in
//            self.indicator.isHidden = true
//            self.indicator.stopAnimating()
//        })
        

    }
    
    // MARK:  PhotoModelView Protocol
    func modelValueChange(updated value: PhotosViewModel) {
        self.setupWithPhoto(with: value)
    }

}
