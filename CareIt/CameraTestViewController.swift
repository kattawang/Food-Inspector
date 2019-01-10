//
//  CameraTestViewController.swift
//  CareIt
//
//  Created by Jason Kozarsky (student LM) on 1/3/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit
import Vision

/*
 Ideally, this screen should allow you to pick either an image or take a photo. Then it should
 analyze whatever image is given to look for a barcode.
 */
class CameraTestViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var currentImage: UIImage?
    @IBOutlet weak var analyzePictureButton: UIButton!
    
    /*
     This action should allow the user to choose a picture, instead of having to go and take a picture.
     This will probably be useful for when we don't have an actual camera to work with (like, maybe when
     we're testing on our laptops.)
     -Hughes
     */
    @IBAction func choosePictureTouchedUpInside(_ sender: Any) {
        analyzePictureButton.isEnabled = true
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func analyzePictureTouchedUpInside(_ sender: Any) {
        guard let image = currentImage else {print("no image");return}
        guard let convertedImage = CIImage(image: image) else {return}
        let imageAnalyzer = VNImageRequestHandler(ciImage: convertedImage, orientation: .up, options: [:])
        let barcodeRequest = VNDetectBarcodesRequest()
        do {
            try imageAnalyzer.perform([barcodeRequest])
            print("analyzing")
        } catch {
            
        }
        
        if let results = barcodeRequest.results {
            for i in results {
                if let barcode = i as? VNBarcodeObservation {
                    print(barcode.payloadStringValue)
                }
            }
        }
    }
    
    /*
     This action should allow the user to open up a camera view so that they can take a picture for image
     analysis. This may actually have to segue to another screen where there's a camera view, but I'm not so
     sure.
     TODO: this needs more thought and testing.
     -Hughes
     */
    @IBAction func takePictureTouchedUpInside(_ sender: Any) {
        tryToEnablePictureButton()
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated:true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.currentImage = pickedImage
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyzePictureButton.isEnabled = false //we're going to disable the button until the person uploads an image
        imagePicker.delegate = self
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
