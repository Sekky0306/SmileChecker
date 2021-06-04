//
//  RegisterViewController.swift
//  SmileChecker
//
//  Created by 関戸優紀 on 2021/05/23.
//


import UIKit
import RealmSwift

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate{
    @IBOutlet weak var registerImageView: UIImageView!
    @IBOutlet var placeTextView: UITextView!
    @IBOutlet var topicTextView: UITextView!
    let realm = try! Realm()
    let addresses = try! Realm().objects(Content.self)
    var notificationToken: NotificationToken?
    var image: UIImage? = nil
    
  /*  func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true,completion: nil)
        }
    }　*/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        registerImageView.image = info[.originalImage]as?UIImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerImageView.image = self.image
        }
      
        // Do any additional setup after loading the view.
    @IBAction func register() {
        let newContent = Content()
        newContent.place = placeTextView.text!
        newContent.topic = topicTextView.text!
        

        try! realm.write {
        realm.add(newContent)
        }

        dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "toCell", sender: nil)
        
        
    }

    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


