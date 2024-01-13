//
//  ActionViewController.swift
//  ImageLab
//
//  Created by Eric Howell on 12/6/23.
//  Copyright © 2023 Eric Larson. All rights reserved.
//

// YourSourceViewController.swift

import UIKit

class CongratsViewController: UIViewController {
    
    @IBOutlet weak var congratsLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let maxWidth: CGFloat = 300 // Set your desired maximum width
        congratsLabel.preferredMaxLayoutWidth = maxWidth
        
        congratsLabel.text = "Congrats! Hopefully this brought not only a smile to your face but got some blood flow to the rest of your body. \n\nRemember, sometimes all we need is a moment to smile and remember there's good in world! \n\nCheck back again soon for another smile and movement excercise."
        
        congratsLabel.contentMode = .scaleToFill
        congratsLabel.adjustsFontSizeToFitWidth = true
        congratsLabel.minimumScaleFactor = 1.5
        congratsLabel.numberOfLines = 0
        congratsLabel.textAlignment = NSTextAlignment.center
        
        let blueColor = UIColor(red: 135 / 255.0, green: 211 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        
        view.backgroundColor = blueColor
    }
    
}
