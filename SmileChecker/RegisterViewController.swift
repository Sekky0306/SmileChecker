//
//  RegisterViewController.swift
//  SmileChecker
//
//  Created by 関戸優紀 on 2021/05/23.
//


import UIKit
import RealmSwift
//import Firebase
//import CoreML
import MLKit
import MLKitFaceDetection




class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate{
    @IBOutlet weak var registerImageView: UIImageView!
    @IBOutlet var placeTextView: UITextView!
    @IBOutlet var topicTextView: UITextView!
    @IBOutlet var level: UILabel!
    let realm = try! Realm()
    let addresses = try! Realm().objects(Content.self)
    var notificationToken: NotificationToken?
    var image: UIImage? = nil
    //var visionImage: FIRVisionImage? = nil
   
  
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
        let options = FaceDetectorOptions()
        options.performanceMode = .accurate
        options.landmarkMode = .all
        options.classificationMode = .all
        let image2 = registerImageView.image
        let image = VisionImage(image: UIImage)
        registerImageView.image.orientation = image2.imageOrientation
        let faceDetector = FaceDetector.faceDetector(options: options)
        weak var weakSelf = self
        faceDetector.process(visionImage) { faces, error in
          guard let strongSelf = weakSelf else {
            print("Self is nil!")
            return
          }
          guard error == nil, let faces = faces, !faces.isEmpty else {
            // ...
            return
          }

          // Faces detected
          // ...
        }
        
        for face in faces {
          let frame = face.frame
            if face.hasSmilingProbability {
                let smileProb = face.smilingProbability
              }
        }
        if smileProb >= 0.7{
            level.text = String("\(smileProb*10)点")
        } else {
            level.text = String("認識失敗")
        }
      
         
        }
    

 @IBAction func register() {
 let newContent = Content()
      
 newContent.place = placeTextView.text!
 newContent.topic = topicTextView.text!
newContent.score = level.text!
let image = info[.originalImage] as! UIImage
let data = NSData(data: image.jpegData(compressionQuality: 0.9)!)
    newContent.data = data
    
    try! realm.write {
    realm.add(newContent)
    }
        dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "toCell", sender: nil)
 }

 /*   func createLocalDataFile() {
            // 作成するテキストファイルの名前
            let fileName = "\(NSUUID().uuidString).png"

            // DocumentディレクトリのfileURLを取得
            if documentDirectoryFileURL != nil {
                // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
                let path = documentDirectoryFileURL.appendingPathComponent(fileName)
                documentDirectoryFileURL = path
            }
        }*/
    

}
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


