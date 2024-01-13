//
//  MotionViewController.swift
//  ImageLab
//
//  Created by Eric Howell on 12/6/23.
//  Copyright © 2023 Eric Larson. All rights reserved.
//
//  Used: https://stackoverflow.com/questions/55212440/coremotion-recognizing-a-jump-swift
//  for jumping motion
//

import Foundation
import CoreMotion
import UIKit
import AudioToolbox


class MotionViewController: UIViewController   {
    
    //MARK: class variables
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    let motion = CMMotionManager()
    let altimeter = CMAltimeter()
    var upMotion = 0
    var downMotion = 0
    var reps = 0
    var breakBool = true
    var squatBool = true
    var totalPunches = 0
    @IBOutlet weak var actionLabel: UILabel!
    var selectedButtonIdentifier: String?
    @IBOutlet weak var repLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionLabel.numberOfLines = 3
        
        if let selectedButtonIdentifier = selectedButtonIdentifier {
            if selectedButtonIdentifier == "jumpingJacks"{
                startJump()
            }
            else if selectedButtonIdentifier == "airSquat"{
                startSquat()
            }
            else if selectedButtonIdentifier == "airPunches"{
                startPunch()
            }
            print("Pressed button with identifier: \(selectedButtonIdentifier)")
            
        }
        
    }
    

    
    func startSquat(){
        actionLabel.text = "Get those Squats in! 10 REPS!"
        if self.motion.isDeviceMotionAvailable{
            self.motion.deviceMotionUpdateInterval = 0.01
            self.motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
                
                guard let myData = data else {
                    return
                }
                
                let userX = (myData.userAcceleration.x)
                let userY = (myData.userAcceleration.y)
                let userZ = (myData.userAcceleration.z)

                if (userY < -0.75 || userX < -0.75 || userZ < -0.75) && self.squatBool == true{
                    self.reps += 1
                    print("That's \(self.reps) reps!")
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    self.repLabel.text = "\(self.reps)"
                    self.squatBool = false
                }
                else if (userY > 0.5 || userX > 0.5 || userZ > 0.5){
                    self.squatBool = true
                }
                
                if self.reps == 10 {
                    AudioServicesPlayAlertSound(1005)
                    self.motion.stopDeviceMotionUpdates()
                    let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "CongratsViewController") as! CongratsViewController
                    self.present(destinationVC, animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
    func startPunch() {
        actionLabel.text = "Get those Punches in! 10 REPS!"
        
        if self.motion.isDeviceMotionAvailable{
            self.motion.deviceMotionUpdateInterval = 0.01
            self.motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
                
                guard let myData = data else {
                    return
                }

                
                if myData.userAcceleration.x > 1.25 && self.breakBool == true {
                    self.totalPunches+=1
                    self.breakBool = false
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    self.repLabel.text = "\(self.totalPunches)"
                }
                else if myData.userAcceleration.x < -0.85{
                    self.breakBool = true
                }
                
                if self.totalPunches == 10 {
                    AudioServicesPlayAlertSound(1005)
                    self.motion.stopDeviceMotionUpdates()
                    let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "CongratsViewController") as! CongratsViewController
                    self.present(destinationVC, animated: true, completion: nil)
                }
               
            }
        }
        
    }
    
    func startJump() {
        
        actionLabel.text = "Get those Jumping Jacks in! \n10 REPS!"
        
        if self.motion.isDeviceMotionAvailable{
            self.motion.deviceMotionUpdateInterval = 0.01
            self.motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
                
                guard let myData = data else {
                    return
                }
                
                let gravX = (myData.gravity.x)
                let gravY = (myData.gravity.y)
                let gravZ = (myData.gravity.z)
                
                let userX = (myData.userAcceleration.x)
                let userY = (myData.userAcceleration.y)
                let userZ = (myData.userAcceleration.z)
                
                
                if gravZ < -0.9 && (userZ) > 0.8 {
                    if userZ > 0{
                        self.upMotion += 1
                    }
                }
                if gravX < -0.9 && (userX) > 0.8 {
                    if userX > 0{
                        print(userX)
                        self.upMotion += 1
                    }
                }
                if gravY < -0.9 && (userY) > 0.8 {
                    if userY > 0{
                        self.upMotion += 1
                    }
                }
                
                print(self.upMotion)
                if self.upMotion > 25 {
                    self.reps += 1
                    print("That's \(self.reps) reps!")
                    self.upMotion = 0
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    self.repLabel.text = "\(self.reps)"
                }
                if self.reps == 10 {
                    AudioServicesPlayAlertSound(1005)
                    self.motion.stopDeviceMotionUpdates()
                    let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "CongratsViewController") as! CongratsViewController
                    self.present(destinationVC, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.motion.stopDeviceMotionUpdates()
    }
}
