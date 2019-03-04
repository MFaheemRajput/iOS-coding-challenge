//
//  PhotoViewController.swift
//  JodelChallenge
//
//  Created by Muhammad Faheem on 28/02/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit
import ImageSlideshow

class PhotoViewController: UIViewController ,InputSource{
    func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        
    }
    var photos: [PhotosViewModel]?
    var selectedIndex: Int = 0
    
    @IBOutlet weak var pagerView: ImageSlideshow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var inputSources = [InputSource]()
        for photo in self.photos!{
            if let img = photo.image{
                inputSources.append( ImageSource(image: img))
            }
        }
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        self.pagerView.addGestureRecognizer(gestureRecognizer)
        self.pagerView.setImageInputs(inputSources)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func didTap() {
        self.pagerView.presentFullScreenController(from: self)
    }
    
}
