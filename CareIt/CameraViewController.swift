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
    var popupView: UIView?
    
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
    
    func showAllergyAlertView(_ request: DatabaseRequests) {
        let transparentView = UIView()
        view.addSubview(transparentView)
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        transparentView.heightAnchor.constraint(equalToConstant: view.bounds.height/2).isActive = true
        transparentView.widthAnchor.constraint(equalToConstant: view.bounds.width/2).isActive = true
        transparentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        transparentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if let food = request.result {
            foodRequest(transparentView, food: food)
        } else {
            errorFoodRequest(transparentView, error: request.error!)
        }
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
            
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            barcodeFrameView.frame = barcodeObject!.bounds
            
            let loadingView = UIView()
            loadingView.backgroundColor = .black
            loadingView.alpha = 0.5
            let loadingText = UILabel()
            loadingText.text = "loading..."
            loadingText.font = UIFont(name: "helvetica neue", size: 50)
            loadingText.textColor = .white
            
            if let barcodeString = metadataObj.stringValue  {
                databaseRequest.barcodeString = String(barcodeString[barcodeString.index(after: barcodeString.startIndex)..<barcodeString.endIndex])
                databaseRequest.request(beforeLoading: {
                    self.barcodeFrameView.frame = .zero
                    self.view.addSubview(loadingView)
                    loadingView.translatesAutoresizingMaskIntoConstraints = false
                    loadingView.heightAnchor.constraint(equalToConstant: view.bounds.height/5).isActive = true
                    loadingView.widthAnchor.constraint(equalToConstant: view.bounds.width/2).isActive = true
                    loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                    loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                    loadingView.addSubview(loadingText)
                    loadingText.translatesAutoresizingMaskIntoConstraints = false
                    loadingText.textAlignment = .center
                    loadingText.heightAnchor.constraint(equalTo: loadingView.heightAnchor).isActive = true
                    loadingText.widthAnchor.constraint(equalTo: loadingView.widthAnchor).isActive = true
                    loadingText.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
                    loadingText.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
                    
                    },
                                        afterLoading: {
                                            loadingView.removeFromSuperview()
                                            self.showAllergyAlertView(self.databaseRequest)
                                            
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
        
        self.popupView = view
        dismissButton.addTarget(self, action: #selector(doneButton(_:)), for: .touchUpInside)
    }
    
    func foodRequest(_ displayView: UIView, food: Food) {
        self.performSegue(withIdentifier: "Food Scanned", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segue = segue.destination as! FoodScanViewController
        segue.setupView(self.databaseRequest.result)
    }
    
    @objc func doneButton(_ sender: Any) {
        self.popupView?.removeFromSuperview()
        self.popupView = nil
        databaseRequest.currentlyProcessing = false
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
