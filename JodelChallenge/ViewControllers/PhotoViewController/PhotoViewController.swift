//
//  PhotoViewController.swift
//  JodelChallenge
//
//  Created by Muhammad Faheem on 28/02/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit
import FSPagerView

class PhotoViewController: UIViewController , FSPagerViewDataSource, FSPagerViewDelegate {
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    var photos: [PhotosViewModel]?
    var selectedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Create a pager view
        //let pagerView = FSPagerView(frame: fram)
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        //self.pagerView.scrollToItem
        
        
        //pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        //self.view.addSubview(pagerView)
        // Create a page control
        //let pageControl = FSPageControl(frame: frame2)
        //self.view.addSubview(pageControl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.pagerView.scrollToItem(at: self.selectedIndex,animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        guard self.photos != nil else {
            //print("result is false")
            return 0
        }
        return (self.photos?.count)!
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
            //cell.imageView?.image = ...
            //cell.textLabel?.text = ...
            //indicator.startAnimating()
        
        if let img = self.photos![index].image{
            cell.imageView?.contentMode = .scaleAspectFit
            cell.imageView!.image = img
        }
        
        
//        cell.imageView!.setImageWith(URLRequest(url: (self.photos?[index].picUrl)!), placeholderImage: nil, success: { request, response, image in
//            cell.imageView?.image = image
//            cell.imageView?.contentMode = .scaleAspectFit
//            //cell.indicator.isHidden = true
//            //cell.indicator.stopAnimating()
//        }, failure: { request, response, error in
//            //cell.indicator.isHidden = true
//            //cell.indicator.stopAnimating()
//        })
        
        return cell
    }


}
