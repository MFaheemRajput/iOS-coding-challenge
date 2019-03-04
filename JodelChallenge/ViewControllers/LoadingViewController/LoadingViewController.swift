//
//  LoadingViewController.swift
//  JodelChallenge
//
//  Created by Muhammad Faheem on 02/03/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class LoadingViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var indicatorView: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func startAnimation(){
        self.indicatorView.isHidden = false
        self.indicatorView.type = .pacman
        self.messageLabel.isHidden = false
        self.messageLabel.text = "Getting Data..."
        self.indicatorView.startAnimating()
    }
    func stopAnimation() {
        self.indicatorView.isHidden = true
        self.messageLabel.isHidden = true
        self.indicatorView.stopAnimating()
    }
    
    func dismissView() {
        self.dismiss(animated: false, completion: nil)
    }
    
}
