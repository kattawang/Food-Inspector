//
//  CameraTestViewController.swift
//  CareIt
//
//  Created by Hughes on 1/3/19.
//  Copyright © 2019 Jason Kozarsky (student LM). All rights reserved.
//
import UIKit
import Vision /* We'll be using the Vision framework to make the barcode scanning a lot easier. */

/*
 Ideally, this screen should allow you to pick either an image or take a photo. Then it should
 analyze whatever image is given to look for a barcode.
 */
class CameraTestViewController:
    UIViewController, /* Makes this a view. */
    UIImagePickerControllerDelegate, /* Allows this view to take over image picking. */
    UINavigationControllerDelegate /* For some reason, this is needed so that the imagePicker actually works. */
    {
    
    /*
     This is a placeholder right now for what we'll do with the barcode information.
     For now, I'm displaying it after analyzing for debugging purposes.
     */
    @IBOutlet weak var barcodeText: UILabel!
    
    /*
     There's no outlet to this because it actually can't get added programatically.
     This picker controls the
     a) image selection
     b) camera view
     required to get a picture into the app from elsewhere.
    */
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var currentImage: UIImage?
    @IBOutlet weak var analyzePictureButton: UIButton!
    
    /*
     This action allows the user to choose an image from their phone (or emulator)'s local storage
     so that they can analyze it for a barcode. Presumably in the final app people will mostly want
     to analyze things that they take pictures of, but this is useful for the time being.
     */
    @IBAction func choosePictureTouchedUpInside(_ sender: Any) {
        analyzePictureButton.isEnabled = true
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    /*
     This function may look scary, but really it's just a bunch of gross code. ¯\_(ツ)_/¯
     All it does is take the current user-selected image and convert it into a Vision-friendly
     format. Then it requests a barcode from the image analyzer and slaps the barcode onto a text
     label if it's valid.
    */
    @IBAction func analyzePictureTouchedUpInside(_ sender: Any) {
        /*
         We start by converting the image from a UIImage? to a CIImage.
         TODO: we should probably add some code here that throws up a little alert asking for the user
         to try again, since it's obviously their fault and my code is perfect.
        */
        guard let image = currentImage else {return}
        guard let convertedImage = CIImage(image: image) else {return}
        
        /*
         Then, we'll initialize a VNImageRequestHandler
         (I don't know how the options work, and it seems to work fine without them)
         that we'll pass the newly converted image. The image will be in the .up orientation
         (the user should take the photo vertically, maybe we should add a check for this? idk.)
        */
        let imageAnalyzer = VNImageRequestHandler(ciImage: convertedImage, orientation: .up, options: [:])
        let barcodeRequest = VNDetectBarcodesRequest()
        
        do {
            try imageAnalyzer.perform([barcodeRequest]) //we're passing a single barcode request, since that's all we care about.
        } catch {
            //empty catch statement, we should add a little alert here too if the analysis fails
        }
        if let results = barcodeRequest.results { //if the code works, then slap the last element of the results up on the label on the screen
            for i in results {
                if let barcode = i as? VNBarcodeObservation {
                    print(barcode.payloadStringValue!)
                    barcodeText.text = barcode.payloadStringValue!
                }
            }
        }
    }
    
    /*
     This action should allow the user to open up a camera view so that they can take a picture for image
     analysis. This may actually have to segue to another screen where there's a camera view, but I'm not so
     sure. For now, it totally works.
     */
    @IBAction func takePictureTouchedUpInside(_ sender: Any) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            analyzePictureButton.isEnabled = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            barcodeText.text = "no camera recognized" //just to check.
        }
    }
    
    /*
     All this function does is close the imagePicker view when the cancel button is hit.
    */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated:true, completion: nil) //then cancel the view.
    }
    
    /*
     This function takes the picked image from the UIImagePickerController (thanks for the code, Swope)
     and sets currentImage equal to this selected image.
    */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.currentImage = pickedImage
            imagePicker.dismiss(animated: true, completion: nil)
        } else {
            //we should probably do something here.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyzePictureButton.isEnabled = false //we're going to disable the button until the person uploads an image
        imagePicker.delegate = self //this line of code is needed, for some weird reason. ¯\_(ツ)_/¯
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
