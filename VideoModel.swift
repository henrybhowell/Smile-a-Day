//
//  VideoModel.swift
//  ImageLab
//
//  Created by Eric Cooper Larson on 10/12/23.
//  Copyright © 2023 Eric Larson. All rights reserved.
//

import UIKit
import MetalKit

class VideoModel: NSObject {
    
    weak var cameraView:MTKView?
    
    //MARK: Class Properties
    private var angle = false
    private var filters : [CIFilter]! = nil
    private lazy var videoManager:VisionAnalgesic! = {
        let tmpManager = VisionAnalgesic(view: cameraView!)
        tmpManager.setCameraPosition(position: .front)
        return tmpManager
    }()
    
    private var countdownLabel: UILabel?
    private var countdownTimer: Timer?
    var countdownSeconds: Int = 2
    var last = false
    let blueColor = UIColor(red: 135 / 255.0, green: 211 / 255.0, blue: 255 / 255.0, alpha: 1.0)
    
    private lazy var detector:CIDetector! = {
        // create dictionary for face detection
        let optsDetector = [CIDetectorAccuracy:CIDetectorAccuracyHigh,
                            CIDetectorTracking:false,
                      CIDetectorMinFeatureSize:0.1,
                     CIDetectorMaxFeatureCount:4,
                      CIDetectorNumberOfAngles:11] as [String : Any]
        
        // setup a face detector in swift
        let detector = CIDetector(ofType: CIDetectorTypeFace,
                                  context: self.videoManager.getCIContext(), // perform on the GPU is possible
            options: (optsDetector as [String : AnyObject]))
        
        return detector
    }()
    
    init(view:MTKView){
        super.init()
        
        cameraView = view
        
        self.videoManager.setCameraPosition(position: .front)
        self.videoManager.setProcessingBlock(newProcessBlock: self.processImage)
        
        if !videoManager.isRunning{
            videoManager.start()
        }
        
    }
    
    //MARK: Apply filters and apply feature detectors
    private func applyFiltersToFaces(inputImage:CIImage,features:[CIFaceFeature])->CIImage{
        var retImage = inputImage
        var faceCenter = CGPoint()
        var filterCenter = CGPoint() // for saving the center of face
        var leftEye = CGPoint()
        var rightEye = CGPoint()
        var radius = 75
        
        for face in features { // for each face
            print(features)
            //find center of face
            faceCenter.x = face.bounds.midX
            faceCenter.y = face.bounds.midY
            
            //set where to apply filter
            filterCenter.x = face.mouthPosition.x
            filterCenter.y = face.mouthPosition.y
            
            leftEye.x = face.leftEyePosition.x
            leftEye.y = face.leftEyePosition.y
            rightEye.x = face.rightEyePosition.x
            rightEye.y = face.rightEyePosition.y
           
            let width = face.bounds.width/2
            let height = face.bounds.height/5
            let xVal = filterCenter.x-(width/2)
            let yVal = filterCenter.y-(height/2)
            
            let filterOver = CIFilter(name:"CISourceOverCompositing")!
            let smileLabel = CIFilter(name: "CITextImageGenerator")!
            let smileTranslation = CIFilter(name: "CIAffineTransform")!
            let timerLabel = CIFilter(name: "CITextImageGenerator")!
            let timerTranslation = CIFilter(name: "CIAffineTransform")!
            
            
            
            if features.count <= 1{
                if face.hasSmile == true{
//                    startCountdownTimer(at: CGPoint(x: filterCenter.x, y: face.bounds.minY))
                    print(last)
                    if !(last){
                        countdownSeconds = 10
                        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
                    }
                    
                    timerLabel.setValue(15.0, forKey: "inputFontSize")
                    timerLabel.setValue(10.0, forKey: "inputScaleFactor")
                    timerLabel.setValue("\(countdownSeconds)", forKey: "inputText")
                    let timerImage = timerLabel.outputImage!
                    
                    timerTranslation.setValue(CGAffineTransform(translationX: faceCenter.x, y: face.bounds.maxY), forKey: "inputTransform")
                    timerTranslation.setValue(timerImage, forKey: "inputImage")
                    let timerImage2 = timerTranslation.outputImage!
                    
                    smileLabel.setValue(15.0, forKey: "inputFontSize")
                    smileLabel.setValue(3.0, forKey: "inputScaleFactor")
                    smileLabel.setValue("KEEP SMILING", forKey: "inputText")
                    var smileImage = smileLabel.outputImage!
                    
                    if countdownSeconds >= 7{
                        smileLabel.setValue(15.0, forKey: "inputFontSize")
                        smileLabel.setValue(3.0, forKey: "inputScaleFactor")
                        smileLabel.setValue("KEEP SMILING", forKey: "inputText")
                        smileImage = smileLabel.outputImage!
                    }
                    
                    else if countdownSeconds < 7 && countdownSeconds >= 4{
                        smileLabel.setValue(15.0, forKey: "inputFontSize")
                        smileLabel.setValue(3.0, forKey: "inputScaleFactor")
                        smileLabel.setValue("You're AMAZING", forKey: "inputText")
                        smileImage = smileLabel.outputImage!
                    }
                    
                    
                    else if countdownSeconds < 4{
                        smileLabel.setValue(15.0, forKey: "inputFontSize")
                        smileLabel.setValue(3.0, forKey: "inputScaleFactor")
                        smileLabel.setValue("LOVELY SMILE", forKey: "inputText")
                        smileImage = smileLabel.outputImage!
                    }
                    
                    
                    smileTranslation.setValue(CGAffineTransform(translationX: xVal, y: yVal-60), forKey: "inputTransform")
                    smileTranslation.setValue(smileImage, forKey: "inputImage")
                    
                    let smileImage2 = smileTranslation.outputImage!
                    
                    filterOver.setValue(smileImage2, forKey: kCIInputImageKey)
                    filterOver.setValue(retImage, forKey: kCIInputBackgroundImageKey)
                    retImage = filterOver.outputImage ?? retImage
                    filterOver.setValue(timerImage2, forKey: kCIInputImageKey)
                    filterOver.setValue(retImage, forKey: kCIInputBackgroundImageKey)
                    retImage = filterOver.outputImage ?? retImage
                    last = true
                }
                else{
                    last = false
                    stopCountdownTimer()
                    
                }
                
            }
        }
        return retImage
    }
    

        @objc private func updateCountdown() {
            if countdownSeconds > 0 {
                countdownSeconds -= 1
            }
//            else{
//                stopCamera()
//            }
        }

        private func stopCountdownTimer() {
            countdownTimer?.invalidate()
            countdownTimer = nil

            // Remove the label
            countdownLabel?.removeFromSuperview()
            countdownLabel = nil
        }
    
    private func getFaces(img:CIImage) -> [CIFaceFeature]{
        // makes sure the image is the correct orientation
//        let optsFace = [CIDetectorImageOrientation:self.videoManager.ciOrientation]
        let optsFace = [CIDetectorEyeBlink:self.videoManager.ciOrientation]
        // get Face Features
        return self.detector.features(in: img, options: optsFace) as! [CIFaceFeature]
    }
    
    //MARK: Process image output
    private func processImage(inputImage:CIImage) -> CIImage{
        
        // detect faces
        let faces = getFaces(img: inputImage)
        
        // if no faces, just return original image
        if faces.count == 0 { return inputImage }
        
        //otherwise apply the filters to the faces
        return applyFiltersToFaces(inputImage: inputImage, features: faces)
    }
    
    func stopCamera() {
        if videoManager.isRunning {
            videoManager.stop()
        }
    }

}
