//
//  ViewController.swift
//  SmileChecker
//
//  Created by 関戸優紀 on 2021/05/22.
//

import UIKit
import RealmSwift
//import Firebase 



class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource{
    
  //  public init?(data: NSData)
@IBOutlet var tableView: UITableView!
    let realm = try! Realm()
    let addresses = try! Realm().objects(Content.self)
    var notificationToken: NotificationToken?
    var image: UIImage? = nil
    var check = ""
    var check2 = ""
    var check3 = ""
    var pictures: Results<PictureData>!
    var photo: NSData!
    var photo1: UIImage? = nil
    var photo2: UIImage? = nil
 
    
    // ドキュメントディレクトリの「ファイルURL」（URL型）定義
     //   var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

        // ドキュメントディレクトリの「パス」（String型）定義
      //  let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
       
    //笑顔関連
  /*  let options = VisionFaceDetectorOptions()
    options.performanceMode = .accurate
    options.landmarkMode = .all
    options.classificationMode = .all]
    lazy var vision = Vision.vision()
    let faceDetector = vision.faceDetector(options: options) */

    // Real-time contour detection of multiple faces
   
   

    
    /*@IBOutlet var label1:UILabel!
    @IBOutlet var label2:UILabel!
    @IBOutlet var label3:UILabel!
    @IBOutlet var photoImageView: UIImageView!
 */
    
/*func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }*/
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
        "Cell", for: indexPath) as! TopicTableViewCell
        cell.place.text = addresses[indexPath.row].place
        cell.topic.text = addresses[indexPath.row].topic
        //cell.level.text = addresses[indexPath.row].score
    cell.photoImageView.image =  UIImage(data: addresses[indexPath.row].data as Data)
      //  let : UIImage? = UIImage(data: data)
        //cell.photoImageView.image = addresses[indexPath.row].pictureDates
        
        return cell
    }
    
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
        check = addresses[indexPath.row].place
        check2 = addresses[indexPath.row].topic
       // check3 = addresses[indexPath.row].score
        photo = addresses[indexPath.row].data
        performSegue(withIdentifier: "showDetailSegue", sender: nil)
     tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true,completion: nil)
        }
      
    }
    
    //cell削除関連
    /* func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
        {
            return true
        }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)  {
          
        if editingStyle == UITableViewCell.EditingStyle.delete{
            self.addresses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        }*/
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
        
        guard let image4 = info[.originalImage] as? UIImage, let cgImage = image4.cgImage else {
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
        
        for feature in features as! [CIFaceFeature] {
            if feature.hasSmile == true{
                self.performSegue(withIdentifier: "toRegister", sender: nil)
            }
        }

       // var resultString = "DETECTED FACES:\n\n"

        /*for feature in features as! [CIFaceFeature] {
            resultString.append("bounds: \(NSCoder.string(for: feature.bounds))\n")
            resultString.append("hasSmile: \(feature.hasSmile ? "YES" : "NO")\n")

            resultString.append("\n")
        }*/
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toRegister" {
                let Register: RegisterViewController = segue.destination as! RegisterViewController
                
                Register.image3 = self.image!
            }else if segue.identifier == "showDetailSegue"{
                let nextView: CheckViewController = segue.destination as! CheckViewController
                nextView.argString = check
                nextView.argString2 = check2
                nextView.image = photo
               // nextView.argString3 = check3
            }
        }
 /*   override func viewWillAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }*/
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        notificationToken = addresses.observe { [weak self] _ in
        self?.tableView.reloadData()
            
       }
        
    }
    @IBAction func add(){
        let myAlert = UIAlertController(title: "画像の選択", message: "画像を撮影もしくは、選択してください", preferredStyle: UIAlertController.Style.actionSheet)
                
                // アクションを生成.
        
        let myAction_1 = UIAlertAction(title: "カメラ", style: UIAlertAction.Style.default, handler: { [self]
                    (action: UIAlertAction!) in
                    print("カメラ")
                    presentPickerController(sourceType: .camera)
                })
                
        let myAction_2 = UIAlertAction(title: "アルバム", style: UIAlertAction.Style.destructive, handler: { [self]
                    (action: UIAlertAction!) in
                    print("アルバム")
                    presentPickerController(sourceType: .photoLibrary)
                })
                
                let myAction_3 = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
                    (action: UIAlertAction!) in
                    print("キャンセル")
                })
                
                // アクションを追加.
            myAlert.addAction(myAction_1)
                myAlert.addAction(myAction_2)
                myAlert.addAction(myAction_3)
                
                self.present(myAlert, animated: true, completion: nil)
            }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Realmの初期化
        let realm = try! Realm()
        // Realmから保存されている写真のデータを取得
        pictures = realm.objects(PictureData.self)
        // CollectionViewを更新
       
    }
    
   
    }
    
 
  
        




