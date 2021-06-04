//
//  ViewController.swift
//  SmileChecker
//
//  Created by 関戸優紀 on 2021/05/22.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    let realm = try! Realm()
    let addresses = try! Realm().objects(Content.self)
    var notificationToken: NotificationToken?
    var image: UIImage? = nil
    
    @IBOutlet var label1:UILabel!
    @IBOutlet var label2:UILabel!
    @IBOutlet var label3:UILabel!
    @IBOutlet var photoImageView: UIImageView!
    
/*func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }*/
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
        "Cell", for: indexPath) as! TopicTableViewCell
        cell.placeTextView.text = addresses[indexPath.row].place
        cell.topicTextView.text = addresses[indexPath.row].topic
        return cell
    }
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true,completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "toRegister", sender: nil)
        /*let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "toRegister") as! RegisterViewController
                self.present(ViewController, animated: true, completion: nil)*/
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toRegister" {
                let Register: RegisterViewController = segue.destination as! RegisterViewController
                
                Register.image = self.image!
            }
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
    
 
  
        }




