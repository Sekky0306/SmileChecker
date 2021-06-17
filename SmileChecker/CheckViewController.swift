//
//  CheckViewController.swift
//  SmileChecker
//
//  Created by 関戸優紀 on 2021/05/23.
//

import UIKit
import RealmSwift
//import MLKitFaceDetection
//import Firebase


class CheckViewController: UIViewController {
    @IBOutlet var label1:UILabel!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var placeTextView: UITextView!
    @IBOutlet var topicTextView: UITextView!
    let realm = try! Realm()
    let addresses = try! Realm().objects(Content.self)
    var notificationToken: NotificationToken?
    var argString = ""
    var argString2 = ""
    //var argString3 = ""
    var image: NSData!
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        placeTextView.text = argString
        topicTextView.text = argString2
        //label1.text = argString3
        photoImageView.image = UIImage(data: image as Data)!
        self.placeTextView.isEditable = false
        self.topicTextView.isEditable = false
        
        
        

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
