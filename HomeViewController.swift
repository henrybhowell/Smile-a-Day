//
//  HomeViewController.swift
//  ImageLab
//
//  Created by Eric Howell on 12/7/23.
//  Copyright © 2023 Eric Larson. All rights reserved.
//

import UIKit
import MetalKit
import CoreMotion

class HomeViewController: UIViewController   {
    
    let activityManager = CMMotionActivityManager()
    var timer: Timer?

    @IBOutlet weak var textBackground: UITableViewCell!
    @IBOutlet weak var smileImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    //MARK: ViewController Hierarchy
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blueColor = UIColor(red: 135 / 255.0, green: 211 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        
        view.backgroundColor = blueColor
        
        if let smileUIImage = UIImage(named: "SMILE.png") {
            smileImage.contentMode = .scaleAspectFit
            smileImage.image = smileUIImage
            smileImage.layer.borderColor = blueColor.cgColor

        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            
            if CMMotionActivityManager.isActivityAvailable(){
                // update from this queue (should we use the MAIN queue here??.... )
                self.activityManager.startActivityUpdates(to: OperationQueue.main)
                {(activity:CMMotionActivity?)->Void in
                    // unwrap the activity and display
                    // using the real time pedometer influences how often we get activity updates...
                    // so these updates can come through less often than we may want
                    if let unwrappedActivity = activity {
                        if unwrappedActivity.stationary == true {
                            
                            self.descriptionLabel.numberOfLines = 3
                            self.descriptionLabel.text = "A mental health app designed to hack the brain into a happier,\n healthier life."
                            self.descriptionLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                            
                            self.startButton.titleLabel?.text = "Get Started"
                            self.startButton.titleLabel?.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                            self.startButton.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                            
                        }
                        if unwrappedActivity.stationary == false {
                            self.descriptionLabel.numberOfLines = 6
                            self.descriptionLabel.text = "This app is meant for use when in a safe, stationary location. \nFocus on being still for a second, and make sure you're not walking, biking, or driving!"
                            self.descriptionLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                            self.startButton.titleLabel?.text = ""
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
         timer?.invalidate()
         timer = nil
        
        self.activityManager.stopActivityUpdates()
        
    }
    
    
    

   
}

