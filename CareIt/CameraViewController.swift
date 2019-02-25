//
//  CameraViewController.swift
//  CareIt
//
//  Created by William Londergan (student LM) on 2/11/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let barcodeFrameView = UIView()
    let captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    let databaseRequest = DatabaseRequests(barcodeString: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInTelephotoCamera, .builtInTrueDepthCamera, .builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        

        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.ean13]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession.startRunning()
        
        barcodeFrameView.layer.borderColor = UIColor.green.cgColor
        barcodeFrameView.layer.borderWidth = 2
        view.addSubview(barcodeFrameView)
        view.bringSubview(toFront: barcodeFrameView)
    }
    
    func showAllergyAlertView(_ food: Food?) {
        let transparentView = UIView()
        transparentView.bounds = view.bounds
        transparentView.backgroundColor = .black
        transparentView.alpha = 0.5
        view.addSubview(transparentView)
        
        let popupView = UIView()
        
        popupView.bounds = CGRect(x: view.bounds.minX + view.bounds.width/6, y: view.bounds.minY + view.bounds.height/6, width: view.bounds.width * 2/3, height: view.bounds.height * 2/3)
        
        if let food = food {
            
            
        } else {
            
        }
        view.addSubview(popupView)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if databaseRequest.currentlyProcessing {
            return
        }
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            barcodeFrameView.frame = CGRect.zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.ean13 {
            
            self.performSegue(withIdentifier: "barcode found", sender: self)
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            barcodeFrameView.frame = barcodeObject!.bounds
            
            let loadingView = UIView()
            let loadingText = UILabel()
            loadingText.text = "loading..."
            
            if let barcodeString = metadataObj.stringValue  {
                databaseRequest.barcodeString = String(barcodeString[barcodeString.index(after: barcodeString.startIndex)..<barcodeString.endIndex])
                databaseRequest.request(beforeLoading: {
                    
                    self.view.addSubview(loadingView)
                    loadingView.frame = CGRect(x: self.view.frame.minX + self.view.frame.width/3, y: self.view.frame.minY + self.view.frame.height*3/5, width: self.view.frame.width/3, height: self.view.frame.height/5 )
                    loadingView.addSubview(loadingText)
                    loadingText.frame = loadingView.frame
                    
                    },
                                        afterLoading: {
                                            if let result = self.databaseRequest.result {
                                                print(result)
                                                
                                            } else {
                                            }
                        loadingView.removeFromSuperview()
                    })
            }
        }
    }
    
    func errorFoodRequest(_ view: UIView, error: String?) {
        view.backgroundColor = .red
        
        let errorBanner = UILabel()
        errorBanner.bounds = CGRect(x: view.bounds.minX, y: view.bounds.minY, width: view.bounds.width, height: view.bounds.height * 3/4)
        errorBanner.font = UIFont(name: "Helvetica Neue", size: 30)
        errorBanner.textAlignment = .center
        errorBanner.numberOfLines = 0
        errorBanner.lineBreakMode = .byWordWrapping
        
        if let error = error {
            errorBanner.text = error
        } else {
            errorBanner.text = "An error occurred."
        }
        
        let dismissButton = UIButton(type: .custom)
        dismissButton.backgroundColor = .red
        
        dismissButton.bounds = CGRect(x: view.bounds.minX + view.bounds.width/3, y: view.bounds.minY + view.bounds.height * 3/4, width: view.bounds.width/3, height: view.bounds.height/4)
        
        //kill me
    }
    
    func foodRequest(_ view: UIView) {
        
    }
    
    @objc func doneButton(_ view: UIView) {
        view.removeFromSuperview()
    }
    
}
