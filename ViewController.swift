//
//  ViewController.swift
//  ImageLab
//
//  Created by Eric Larson
//  Copyright © 2016 Eric Larson. All rights reserved.
//

import UIKit
import MetalKit

class ViewController: UIViewController   {

    var videoModel:VideoModel? = nil
    
    @IBOutlet weak var cameraView: MTKView!
    //MARK: ViewController Hierarchy
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoModel = VideoModel(view: self.cameraView)
        
        
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if self.videoModel?.countdownSeconds == 0{
                self.performSegue(withIdentifier: "activitySegue", sender: nil)
                self.videoModel?.stopCamera()
                self.videoModel?.countdownSeconds -= 1
            }
        }
        
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        
        videoModel?.stopCamera()
        
        
        super.viewDidDisappear(animated)
        
    }
    
    
    

   
}
