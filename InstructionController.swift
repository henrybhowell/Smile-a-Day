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

class InstructionController: UIViewController   {
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var imageFour: UIImageView!
    var selectedButtonIdentifier: String?
    
    //MARK: ViewController Hierarchy
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let blueColor = UIColor(red: 135 / 255.0, green: 211 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        
        view.backgroundColor = blueColor
        
        print(selectedButtonIdentifier)
        
        if let selectedButtonIdentifier = selectedButtonIdentifier {
            if selectedButtonIdentifier == "airSquat"{
                if let handUIImage = UIImage(named: "Phone.png") {
                    imageOne.contentMode = .scaleAspectFit
                    imageOne.image = handUIImage
                }
                if let squatOneUIImage = UIImage(named: "Squat_1.png") {
                    imageTwo.contentMode = .scaleAspectFit
                    imageTwo.image = squatOneUIImage
                }
                if let squatTwoUIImage = UIImage(named: "Squat_2.png") {
                    imageThree.contentMode = .scaleAspectFit
                    imageThree.image = squatTwoUIImage
                }
                if let squatThreeUIImage = UIImage(named: "Squat_3.png") {
                    imageFour.contentMode = .scaleAspectFit
                    imageFour.image = squatThreeUIImage
                }
            }
            
            if selectedButtonIdentifier == "jumpingJacks"{
                if let handUIImage = UIImage(named: "Phone.png") {
                    imageOne.contentMode = .scaleAspectFit
                    imageOne.image = handUIImage
                }
                if let jackOneUIImage = UIImage(named: "Jack_1.png") {
                    imageTwo.contentMode = .scaleAspectFit
                    imageTwo.image = jackOneUIImage
                }
                if let jackTwoUIImage = UIImage(named: "Jack_2.png") {
                    imageThree.contentMode = .scaleAspectFit
                    imageThree.image = jackTwoUIImage
                }
                if let jackThreeUIImage = UIImage(named: "Jack_3.png") {
                    imageFour.contentMode = .scaleAspectFit
                    imageFour.image = jackThreeUIImage
                }
            }

            if selectedButtonIdentifier == "airPunches"{
                if let handUIImage = UIImage(named: "Phone.png") {
                    imageOne.contentMode = .scaleAspectFit
                    imageOne.image = handUIImage
                }
                if let punchOneUIImage = UIImage(named: "Punch_1.png") {
                    imageTwo.contentMode = .scaleAspectFit
                    imageTwo.image = punchOneUIImage
                }
                if let punchTwoUIImage = UIImage(named: "Punch_2.png") {
                    imageThree.contentMode = .scaleAspectFit
                    imageThree.image = punchTwoUIImage
                }
                if let punchThreeUIImage = UIImage(named: "Punch_3.png") {
                    imageFour.contentMode = .scaleAspectFit
                    imageFour.image = punchThreeUIImage
                }
            }
            print("Pressed button with identifier: \(selectedButtonIdentifier)")
            
        }
        
        
    }
    
    @IBAction func performAction(_ sender: Any) {
        performSegue(withIdentifier: "activitySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "activitySegue" {
            if let destinationVC = segue.destination as? MotionViewController {
                // Pass the selectedButtonIdentifier to the destination view controller
                destinationVC.selectedButtonIdentifier = selectedButtonIdentifier
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
    
    
    

   
}

