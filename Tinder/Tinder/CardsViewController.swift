//
//  CardsViewController.swift
//  Tinder
//
//  Created by Beau Smith on 3/2/16.
//  Copyright © 2016 Beau SMith. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    var lightboxTransition: LightboxTransition!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photoOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lightboxTransition = LightboxTransition()
        lightboxTransition.duration = 0.3
        
        photoOriginalCenter = photoImageView.center
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapPhoto(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier("sexySegue", sender: self)
    }
    @IBAction func didPanPhoto(sender: UIPanGestureRecognizer) {

        let point = sender.locationInView(view)
        //let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
        } else if sender.state == UIGestureRecognizerState.Changed {
            var rotation = Double(translation.x/6)
            photoImageView.center = CGPoint(
                x: photoOriginalCenter.x + translation.x,
                y: photoOriginalCenter.y + translation.y
            )
            if (point.y > 230) {
                rotation = rotation * -1
            }
            photoImageView.transform = CGAffineTransformMakeRotation(CGFloat(rotation * M_PI / 180))
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                if translation.x > 50 {
                    self.photoImageView.center.x = self.photoImageView.frame.width * 1.5
                } else if translation.x < -50 {
                    self.photoImageView.center.x = self.photoImageView.frame.width * -1
                } else {
                    self.photoImageView.center = self.photoOriginalCenter
                    self.photoImageView.transform = CGAffineTransformIdentity
                }
            }, completion: { (Bool) -> Void in
                UIView.animateWithDuration(0.3, delay: 0.8, options: [], animations: { () -> Void in
                    self.photoImageView.transform = CGAffineTransformIdentity
                    self.photoImageView.center = self.photoOriginalCenter
                }, completion: nil)
            })
            
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let profileViewController = segue.destinationViewController as! ProfileViewController
        profileViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        profileViewController.transitioningDelegate = lightboxTransition
        
        profileViewController.image = self.photoImageView.image

    }

}
