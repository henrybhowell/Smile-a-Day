//
//  ActionViewController.swift
//  ImageLab
//
//  Created by Eric Howell on 12/6/23.
//  Copyright © 2023 Eric Larson. All rights reserved.
//

// YourSourceViewController.swift

import UIKit

class ActionViewController: UIViewController {
    var selectedButtonIdentifier: String?
    
    @IBOutlet weak var punchesButtonUI: UIButton!
    @IBOutlet weak var jacksButtonUI: UIButton!
    @IBOutlet weak var squatButtonUI: UIButton!
    
    @IBOutlet weak var actionDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let maxWidth: CGFloat = 300 // Set your desired maximum width
        actionDescription.preferredMaxLayoutWidth = maxWidth
        
        actionDescription.text = "Not only does smiling help your mental health, but so does exercising. This works best by getting outside and moving around, but it's possible to do right where you are now! \n\n Simply click on which action looks interesting and read the instructions."
        
        actionDescription.contentMode = .scaleToFill
        actionDescription.adjustsFontSizeToFitWidth = true
        actionDescription.minimumScaleFactor = 1.5
        actionDescription.numberOfLines = 0
        actionDescription.textAlignment = NSTextAlignment.center
        
        let blueColor = UIColor(red: 135 / 255.0, green: 211 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        
        view.backgroundColor = blueColor
        
        punchesButtonUI.backgroundColor = blueColor
        jacksButtonUI.backgroundColor = blueColor
        squatButtonUI.backgroundColor = blueColor
        
        
    }
    
    //  Naming Convention is weird because I could not get it to work for the other actions other than Jumpingjacks so copied it directly. Was werid and frustrating.
    
    @IBAction func jacksButton(_ sender: UIButton) {
        selectedButtonIdentifier = "jumpingJacks"
        performSegue(withIdentifier: "actionSegue", sender: self)
    }
    
    @IBAction func jackButton(_ sender: UIButton) {
        selectedButtonIdentifier = "airSquat"
        performSegue(withIdentifier: "actionSegue", sender: self)
    }
    
    @IBAction func jackyButton(_ sender: UIButton) {
        selectedButtonIdentifier = "airPunches"
        performSegue(withIdentifier: "actionSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "actionSegue" {
            if let destinationVC = segue.destination as? InstructionController {
                // Pass the selectedButtonIdentifier to the destination view controller
                destinationVC.selectedButtonIdentifier = selectedButtonIdentifier
            }
        }
    }
}
