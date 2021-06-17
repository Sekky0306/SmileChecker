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
//import MLKit
//import MLKitFaceDetection




class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate{
    @IBOutlet weak var registerImageView: UIImageView!
    @IBOutlet var placeTextView: UITextView!
    @IBOutlet var topicTextView: UITextView!
    @IBOutlet var level: UILabel!
    let realm = try! Realm()
    let addresses = try! Realm().objects(Content.self)
    var notificationToken: NotificationToken?
    var image3: UIImage? = nil
    //var visionImage: FIRVisionImage? = nil
   
  
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true,completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
      //  registerImageView.image = info[.originalImage]as?UIImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerImageView.image = image3
      /*  let options = FaceDetectorOptions()
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
        }*/
        guard let image2 = self.registerImageView.image, let cgImage = image2.cgImage else {
            return
        }

        // storyboardに置いたimageViewからCIImageを生成する
        let ciImage = CIImage(cgImage: cgImage)

        // 顔認識なのでTypeをCIDetectorTypeFaceに指定する
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])

        // 取得するパラメーターを指定する
        let options = [CIDetectorSmile : true]

        // 画像から特徴を抽出する
        let features = detector?.features(in: ciImage, options: options)

        var resultString = "DETECTED FACES:\n\n"

        for feature in features as! [CIFaceFeature] {
            resultString.append("hasSmile: \(feature.hasSmile ? "YES" : "NO")\n")

           // resultString.append("\n")
        }
        if options == [CIDetectorSmile : true]{
            
    
        level.text = String(resultString)
       
        }
        }
    

 @IBAction func register() {
 let newContent = Content()
      
 newContent.place = placeTextView.text!
 newContent.topic = topicTextView.text!
 //newContent.score = level.text!
    let image = registerImageView.image!
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


