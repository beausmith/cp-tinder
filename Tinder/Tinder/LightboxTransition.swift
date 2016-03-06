//
//  LightboxTransition.swift
//  Tinder
//
//  Created by Beau Smith on 3/2/16.
//  Copyright © 2016 Beau SMith. All rights reserved.
//

import UIKit

class LightboxTransition: BaseTransition {
    
    var profileImage: UIView!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let cardsViewController = fromViewController as! CardsViewController
        let profileViewController = toViewController as! ProfileViewController
        
        let movingImageView = UIImageView()
        movingImageView.frame = cardsViewController.photoImageView.frame
        movingImageView.image = cardsViewController.photoImageView.image
        movingImageView.clipsToBounds = cardsViewController.photoImageView.clipsToBounds
        movingImageView.contentMode = cardsViewController.photoImageView.contentMode
        
        containerView.addSubview(movingImageView)
        
        cardsViewController.photoImageView.alpha = 0
        profileViewController.profileImageView.alpha = 0
        toViewController.view.alpha = 0
        
        UIView.animateWithDuration(duration, animations: {
            movingImageView.frame = profileViewController.profileImageView.frame
            toViewController.view.alpha = 1
        }) { (finished: Bool) -> Void in
            profileViewController.profileImageView.alpha = 1
            movingImageView.removeFromSuperview()
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        let cardsViewController = toViewController as! CardsViewController
        let profileViewController = fromViewController as! ProfileViewController

        let movingImageView = UIImageView()
        movingImageView.frame = profileViewController.profileImageView.frame
        movingImageView.image = profileViewController.profileImageView.image
        movingImageView.clipsToBounds = profileViewController.profileImageView.clipsToBounds
        movingImageView.contentMode = profileViewController.profileImageView.contentMode
        
        containerView.addSubview(movingImageView)

        cardsViewController.photoImageView.alpha = 0
        profileViewController.profileImageView.alpha = 0
        toViewController.view.alpha = 0
        
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            movingImageView.frame = cardsViewController.photoImageView.frame
            toViewController.view.alpha = 1
            cardsViewController.photoImageView.alpha = 1
        }) { (finished: Bool) -> Void in
            cardsViewController.photoImageView.alpha = 1
            movingImageView.removeFromSuperview()

            self.finish()
        }
    }
}
