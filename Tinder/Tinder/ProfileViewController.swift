//
//  ProfileViewController.swift
//  Tinder
//
//  Created by Beau Smith on 3/2/16.
//  Copyright © 2016 Beau SMith. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var lightboxTransition: LightboxTransition!

    @IBOutlet weak var profileImageView: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lightboxTransition = LightboxTransition()
        lightboxTransition.duration = 2.3

        profileImageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didTapProfileImageView(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
