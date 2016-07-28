//
//  DetailViewController.swift
//  CollegeProfileBuilderA
//
//  Created by Saurav Desai on 7/25/16.
//  Copyright © 2016 Saurav Desai. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collegeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var enrollmentTextField: UITextField!
    @IBOutlet weak var webAddressTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var savedLabel: UILabel!
    var imagePicker = UIImagePickerController()
    var college : College!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collegeTextField.delegate = self
        locationTextField.delegate = self
        enrollmentTextField.delegate = self
        webAddressTextField.delegate = self
        imagePicker.delegate = self
        collegeTextField.text = college.name
        locationTextField.text = college.location
        enrollmentTextField.text = "\(college.enrollment)"
        webAddressTextField.text = college.urlString
        imageView.image = college.image
        savedLabel.text = ""
    }
    
    func endAllEditing(){
        collegeTextField.endEditing(true)
        locationTextField.endEditing(true)
        enrollmentTextField.endEditing(true)
        webAddressTextField.endEditing(true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true) { 
            let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.imageView.image = selectedImage
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        savedLabel.text = ""
    }
    @IBAction func onTappedLibraryButton(sender: UIButton) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        endAllEditing()
    }
    
    @IBAction func onTappedCameraButton(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        endAllEditing()
    }
    
    @IBAction func onTappedGoButton(sender: UIButton) {
        let url = NSURL(string: college.urlString)!
        UIApplication.sharedApplication().openURL(url)
        endAllEditing()
    }
    
    @IBAction func onTappedSaveButton(sender: AnyObject) {
        college.name = collegeTextField.text!
        college.location = locationTextField.text!
        college.enrollment = Int(enrollmentTextField.text!)!
        college.image = imageView.image!
        college.urlString = webAddressTextField.text!
        savedLabel.text = "Saved"
        endAllEditing()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! MapViewController
        dvc.university = college
    }
}
