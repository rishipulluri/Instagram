//
//  FeedViewController.swift
//  InstaGram
//
//  Created by saritha on 2/25/16.
//  Copyright © 2016 saritha. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
  
    @IBOutlet var textView: UITextView!

    @IBOutlet var captureBut: UIButton!
    @IBOutlet var PostHidden: UIButton!
    var allInfo: [PFObject]!
    var blo:UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.hidden = true
        PostHidden.hidden = true
        
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                print(media)
                self.allInfo = media
                print(self.allInfo)
                self.tableView.reloadData()
            } else {
                print("loopy")
            }
        }
        self.navigationItem.setHidesBackButton(true, animated: true)
        var leftNavBarButton = UIBarButtonItem(customView:captureBut)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        //let vc = UIImagePickerController()
        //vc.delegate = self
       // vc.allowsEditing = true
       // vc.sourceType = UIImagePickerControllerSourceType.Camera
       // self.presentViewController(vc, animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
    }
    
    
    override func viewWillAppear(animated: Bool) {
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                print(media)
                self.allInfo = media
                print(self.allInfo)
                self.tableView.reloadData()
            } else {
                print("loopy")
            }
        }
    }

    @IBAction func PostButton(sender: AnyObject) {
        let text = textView.text
        let post = UserMedia(comment: text)
        post.Postpost  (withCompletion:{(success:Bool, error:NSError?) -> Void in
            if (success)
            {
                print("succeess1123")
                
            }
            else
            {
                print("deltafilgof\(error?.localizedDescription)")
                print(PFUser.currentUser())
            }
        })
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     {
        if allInfo != nil{
            
        
        return allInfo.count
            print(allInfo.count)
        }
        else
        {
            return 0;
        }
    }
    

    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
     {
        let cell = tableView.dequeueReusableCellWithIdentifier("tablecell", forIndexPath: indexPath) as!  CelllTableTableViewCell
        
        
        var instaC = allInfo![indexPath.row];
        
        cell.CaptionForText.text = instaC.valueForKeyPath("caption") as! String
        
        var image: UIImage?
        if (instaC.valueForKeyPath("media") != nil)
        {
            let profileImage = instaC.valueForKeyPath("media") as! PFFile
            do
                {
                    let profile = try profileImage.getData()
                    image = UIImage(data: profile)
            
                }
                    catch
                {
                    print("Rohan raval ")
                }
                    cell.imageLabel.image = image;
        
        }
        
        return cell;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
