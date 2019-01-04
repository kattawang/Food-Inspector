//
//  CameraTestViewController.swift
//  CareIt
//
//  Created by Jason Kozarsky (student LM) on 1/3/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//

import UIKit

/*
 Ideally, this screen should allow you to pick either an image or take a photo. Then it should
 analyze whatever image is given to look for a barcode.
 */
class CameraTestViewController: UIViewController, UIImagePickerControllerDelegate {
    
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var currentImage: CIImage?
    

    /*
     This action should allow the user to choose a picture, instead of having to go and take a picture.
     This will probably be useful for when we don't have an actual camera to work with (like, maybe when
     we're testing on our laptops.)
     -Hughes
     */
    @IBAction func choosePictureTouchedUpInside(_ sender: Any) {
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
    
    @IBAction func analyzePictureTouchedUpInside(_ sender: Any) {
        guard let currentImage = currentImage else {return}
        
    }
    
    /*
     This action should allow the user to open up a camera view so that they can take a picture for image
     analysis. This may actually have to segue to another screen where there's a camera view, but I'm not so
     sure.
     TODO: this needs more thought and testing.
     -Hughes
     */
    @IBAction func takePictureTouchedUpInside(_ sender: Any) {
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //we should check here to make absolutely sure that the image they picked is actually a still image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
