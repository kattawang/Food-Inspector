<<<<<<< Updated upstream
=======
//
//  CameraTestViewController.swift
//  CareIt
//
//  Created by Hughes on 1/3/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//
import UIKit
import AVFoundation /* We'll be using the Vision framework to make the barcode scanning a lot easier. */

/*
 Ideally, this screen should allow you to pick either an image or take a photo. Then it should
 analyze whatever image is given to look for a barcode.
 */
class CameraTestViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession?
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var qrCodeFrameView: UIView?
    
    var contractionAnimation: CABasicAnimation?
    
    var databaseReq: DatabaseRequests?
    
    @IBOutlet var loadingPopover: UIView!

    
//    @IBAction func analyzePictureTouchedUpInside(_ sender: Any) {
//        /*
//         We start by converting the image from a UIImage? to a CIImage.
//         TODO: we should probably add some code here that throws up a little alert asking for the user
//         to try again, since it's obviously their fault and my code is perfect.
//        */
//        guard let image = currentImage else {return}
//        guard let convertedImage = CIImage(image: image) else {return}
//
//        /*
//         Then, we'll initialize a VNImageRequestHandler
//         (I don't know how the options work, and it seems to work fine without them)
//         that we'll pass the newly converted image. The image will be in the .up orientation
//         (the user should take the photo vertically, maybe we should add a check for this? idk.)
//        */
//        let imageAnalyzer = VNImageRequestHandler(ciImage: convertedImage, orientation: .up, options: [:])
//        let barcodeRequest = VNDetectBarcodesRequest()
//
//        do {
//            try imageAnalyzer.perform([barcodeRequest]) //we're passing a single barcode request, since that's all we care about.
//        } catch {
//            //empty catch statement, we should add a little alert here too if the analysis fails
//        }
//
//        if let results = barcodeRequest.results { //if the code works, then slap the last element of the results up on the label on the screen
//            if results.count > 0, let barcode = results[0] as? VNBarcodeObservation {
//                let databaseReq = DatabaseRequests(barcodeString: barcode.payloadStringValue!, beforeLoading: {self.startLoad()}, afterLoading: {self.endLoad()})
//                self.barcodeText.text = databaseReq.result
//            }
//        }
//    }
    
    /*
     This action should allow the user to open up a camera view so that they can take a picture for image
     analysis. This may actually have to segue to another screen where there's a camera view, but I'm not so
     sure. For now, it totally works.
     */
    
    /*
     All this function does is close the imagePicker view when the cancel button is hit.
    */
    
    /*
     This function takes the picked image from the UIImagePickerController (thanks for the code, Swope)
     and sets currentImage equal to this selected image.
    */

    
    func startLoad() {
        self.view.addSubview(loadingPopover)
        loadingPopover.center = self.view.center
        
        let shape1 = smallOpening()
        let shape2 = largeOpening()
        let shapeLayer = CAShapeLayer()
        loadingPopover.layer.addSublayer(shapeLayer)
        self.contractionAnimation = CABasicAnimation(keyPath: "path" )
        guard let contractionAnimation = self.contractionAnimation else {return}
        contractionAnimation.fromValue = shape1.cgPath
        contractionAnimation.toValue = shape2.cgPath
        contractionAnimation.duration = 1.0
        contractionAnimation.fillMode = kCAFillModeForwards
        contractionAnimation.isRemovedOnCompletion = false
        contractionAnimation.autoreverses = true
        contractionAnimation.repeatCount = 100 //unsure how to make this loop indefinitely
        shapeLayer.path = shape1.cgPath
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.add(contractionAnimation, forKey: "path")
    }
    
    func endLoad() {
        self.loadingPopover.removeFromSuperview()
        self.contractionAnimation?.isRemovedOnCompletion = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let deviceDiscoverySession = 
    }
    
    func analysisFinished() {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func smallOpening() -> UIBezierPath {
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: self.loadingPopover.bounds.width/12 * 9, y: self.loadingPopover.bounds.height/2), radius: self.loadingPopover.bounds.height/10, startAngle: 0, endAngle: 2*3.141, clockwise: true)
//        bezierPath.move(to: self.loadingPopover.center)
//        bezierPath.addLine(to: CGPoint(x: 41.5, y: 42.5))
//        bezierPath.addLine(to: CGPoint(x: 47.5, y: 42.5))
//        bezierPath.addLine(to: CGPoint(x: 47.5, y: 42.5))
//        bezierPath.addLine(to: CGPoint(x: 59.5, y: 49.5))
//        bezierPath.addLine(to: CGPoint(x: 66.5, y: 57.5))
//        bezierPath.addLine(to: CGPoint(x: 59.5, y: 57.5))
//        bezierPath.addLine(to: CGPoint(x: 47.5, y: 63.5))
//        bezierPath.addLine(to: CGPoint(x: 35.5, y: 57.5))
//        bezierPath.addLine(to: CGPoint(x: 35.5, y: 49.5))
//        bezierPath.addLine(to: CGPoint(x: 35.5, y: 49.5))
//        bezierPath.close()
        //UIColor.red.setFill()
        bezierPath.fill()
        //UIColor.red.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        return bezierPath
    }
    
    func largeOpening() -> UIBezierPath {
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: self.loadingPopover.bounds.width/12 * 9, y: self.loadingPopover.bounds.height/2), radius: self.loadingPopover.bounds.height/7, startAngle: 0, endAngle: 2*3.141, clockwise: true)
//        bezierPath.move(to: CGPoint(x: 8.5, y: 82.5))
//        bezierPath.addLine(to: CGPoint(x: 15.5, y: 51.5))
//        bezierPath.addLine(to: CGPoint(x: 32.5, y: 21.5))
//        bezierPath.addLine(to: CGPoint(x: 51.5, y: 11.5))
//        bezierPath.addLine(to: CGPoint(x: 69.5, y: 21.5))
//        bezierPath.addLine(to: CGPoint(x: 82.5, y: 41.5))
//        bezierPath.addLine(to: CGPoint(x: 82.5, y: 64.5))
//        bezierPath.addLine(to: CGPoint(x: 87.5, y: 82.5))
//        bezierPath.addLine(to: CGPoint(x: 51.5, y: 91.5))
//        bezierPath.addLine(to: CGPoint(x: 8.5, y: 82.5))
//        bezierPath.addLine(to: CGPoint(x: 8.5, y: 82.5))
//        bezierPath.addLine(to: CGPoint(x: 8.5, y: 82.5))
//        bezierPath.close()
        //UIColor.red.setFill()
        bezierPath.fill()
        //UIColor.red.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        return bezierPath
    }

}
>>>>>>> Stashed changes

