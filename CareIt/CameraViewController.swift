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
    @IBOutlet weak var barcodeBrackets: UIImageView!
    
    let barcodeFrameView = UIView()
    let captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var databaseRequest = DatabaseRequests(barcodeString: "")
    var popupView: UIView?
    public var alreadyProcessed: Bool = false
    
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
        view.bringSubview(toFront: barcodeBrackets)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //in here should start a new request
        navigationController?.navigationBar.isHidden = true
        alreadyProcessed = false
        
    }
    
    func showAllergyAlertView(_ request: DatabaseRequests) {
        if let food = request.result {
//            self.databaseRequest.currentlyProcessing = false
            foodRequest(food: food)
        } else {
            errorFoodRequest(error: request.error!)
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if databaseRequest.currentlyProcessing {
            return
        }
        if alreadyProcessed{
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
            
            barcodeBrackets.alpha = 0
            
            let loadingView = UIView()
            loadingView.backgroundColor = .black
            loadingView.alpha = 0.5
            let loadingText = UILabel()
            loadingText.text = "loading..."
            loadingText.font = UIFont(name: "helvetica neue", size: 50)
            loadingText.textColor = .white
            
            if let barcodeString = metadataObj.stringValue  {
                databaseRequest = DatabaseRequests(barcodeString: String(barcodeString[barcodeString.index(after: barcodeString.startIndex)..<barcodeString.endIndex]))
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
                                            self.barcodeBrackets.alpha = 1
                                            loadingView.removeFromSuperview()
                                            self.showAllergyAlertView(self.databaseRequest)
                                            self.alreadyProcessed = true
                                            
                    })
            }
        }
    }
    
    func errorFoodRequest(error: String?) {
    
        let popupView = UIView()
        self.popupView = popupView
        self.view.addSubview(popupView)
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.heightAnchor.constraint(equalToConstant: self.view.bounds.height/2).isActive = true
        popupView.widthAnchor.constraint(equalToConstant: self.view.bounds.width/2).isActive = true
        popupView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        popupView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        popupView.backgroundColor = .red
        
        let dismissButton = UIButton(type: .custom)
        dismissButton.backgroundColor = .black
        
        dismissButton.setTitle("Done", for: .normal)
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        dismissButton.layer.cornerRadius = 8
        dismissButton.layer.masksToBounds = true
        
        popupView.addSubview(dismissButton)
        dismissButton.widthAnchor.constraint(equalTo: popupView.widthAnchor, multiplier: 0.3).isActive = true
        dismissButton.centerXAnchor.constraint(equalTo: popupView.centerXAnchor).isActive = true
        dismissButton.heightAnchor.constraint(equalTo: popupView.heightAnchor, multiplier: 0.1).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -10).isActive = true
        
        let errorBanner = UILabel()
        popupView.addSubview(errorBanner)
        errorBanner.translatesAutoresizingMaskIntoConstraints = false
        errorBanner.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 10).isActive = true
        errorBanner.widthAnchor.constraint(equalTo: popupView.widthAnchor, multiplier: 0.8).isActive = true
        errorBanner.centerXAnchor.constraint(equalTo: popupView.centerXAnchor).isActive = true
        errorBanner.bottomAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: -10).isActive = true
        
        if let error = error {
            errorBanner.text = error
        } else {
            errorBanner.text = "An error occurred. Please try again."
        }
        
        errorBanner.font = UIFont(name: "Avenir Medium", size: 30)
        errorBanner.textColor = .white
        errorBanner.numberOfLines = 0
        errorBanner.lineBreakMode = .byWordWrapping
        errorBanner.textAlignment = .center
        
        dismissButton.addTarget(self, action: #selector(doneButton(_:)), for: .touchUpInside)
    }
    
    func foodRequest(food: Food) {
        self.performSegue(withIdentifier: "Food Scanned", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segue = segue.destination as! FoodScanViewController
        segue.navigationController?.navigationBar.isHidden = false
        segue.setupView(self.databaseRequest.result)
    }
    
    @objc func doneButton(_ sender: Any) {
        databaseRequest.currentlyProcessing = false
        popupView!.removeFromSuperview()
        alreadyProcessed = false
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
