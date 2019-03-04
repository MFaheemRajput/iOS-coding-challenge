 //
//  Photos.swift
//  JodelChallenge
//
//  Created by Muhammad Faheem on 17/02/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import NVActivityIndicatorView

 protocol PhotoViewModelProtocol {
    // protocol definition goes here
    func modelValueChange(updated value: PhotosViewModel)
 }
 
class PhotosViewModel: NSObject {
    var delegate: PhotoViewModelProtocol?
    var title: String?
    var indicatorView: NVActivityIndicatorView?
    var image: UIImage?{
        didSet {
            print("picture lodaing complete")
            
            self.delegate?.modelValueChange(updated: self)
        }
    }
    var picUrl: URL?{
        didSet {
            print("picture loading")
            self.loadPicture(self.picUrl!)
        }
    }
    
    override init() {
     
    }
    
    init(_ obj: NSMutableDictionary){
        super.init()
        self.title  = obj.value(forKey: "title") as? String
        self.picUrl = obj.value(forKey: "picUrl") as? URL
        DispatchQueue.main.async {
            self.indicatorView = NVActivityIndicatorView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        }
        
        defer {
            self.picUrl = obj.value(forKey: "picUrl") as? URL
        }
    }
    
    
    
    func loadPicture(_ url: URL!)  {
        self.startAnimation()
        Alamofire.request( url!).responseImage {
            response in
            if let image = response.result.value {
                self.image = image
            }
                self.stopAnimation()
        }
    }
    
    func startAnimation(){
        DispatchQueue.main.async {
        self.indicatorView?.isHidden = false
        self.indicatorView?.type = .pacman
        self.indicatorView?.startAnimating()
        }
    }
    func stopAnimation() {
        DispatchQueue.main.async {
        self.indicatorView?.isHidden = true
        self.indicatorView?.stopAnimating()
        }
    }
}
