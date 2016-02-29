//
//  ImageFileViewController.swift
//  InstaGram
//
//  Created by saritha on 2/26/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit
import Parse

class ImageFileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var buttonTake: UIButton!
    
    @IBOutlet var imageAction: UIImageView!
    var vc:UIImagePickerController!

    @IBOutlet var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false

     
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ButtonAction(sender: AnyObject) {
         vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    @IBAction func photAction(sender: AnyObject) {
        
        
        UserMedia.postUserImage(imageAction.image!, withCaption: textView.text!) { (success:Bool, error:NSError?) -> Void in
        if (success)
        {
            print("daisy, doodle do")
            
            }
            else
        {
            print("nada send image")
            }
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
            buttonTake.hidden = true;
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            //imageAction.image= originalImage
            imageAction.image = editedImage
            self.dismissViewControllerAnimated(true, completion: nil)
            var s = CGSizeMake(20, 10)
            self.resize(imageAction.image!, newSize: s)
    }

    @IBAction func newbutton(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onAction(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut();
        
        
        }
    
    

}

