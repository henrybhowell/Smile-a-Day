//
//  SmileViewController.swift
//  ImageLab
//
//  Created by Eric Howell on 12/6/23.
//  Copyright © 2023 Eric Larson. All rights reserved.
//

import UIKit

class SmileViewController: UIViewController {
    
    @IBOutlet weak var activateSmile: UIButton!
    @IBOutlet weak var SmileDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blueColor = UIColor(red: 135 / 255.0, green: 211 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        
        view.backgroundColor = blueColor
        
        let maxWidth: CGFloat = 300 // Set your desired maximum width
        SmileDescription.preferredMaxLayoutWidth = maxWidth
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 15 // Set your desired line spacing

        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle
        ]

        let attributedString = NSAttributedString(string: "Research suggests that forcing yourself to smile throughout the day helps to reduce stress and increase mental health. \n\n To test this, Smile A Day requires the user to smile at the camera for 10 seconds. \n\n This may feel strange doing with not much feedback, but focus on the act of smiling and let the happiness wash over you.", attributes: attributes)
        SmileDescription.attributedText = attributedString
        SmileDescription.contentMode = .scaleToFill
        SmileDescription.adjustsFontSizeToFitWidth = true
        SmileDescription.minimumScaleFactor = 1.5
        SmileDescription.numberOfLines = 0
        SmileDescription.textAlignment = NSTextAlignment.center

        activateSmile.titleLabel!.text = "Put on a Smile"

    }
}
