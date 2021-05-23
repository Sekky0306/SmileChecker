//
//  ViewController.swift
//  SmileChecker
//
//  Created by 関戸優紀 on 2021/05/22.
//

import UIKit


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var label1:UILabel!
    @IBOutlet var label2:UILabel!
    @IBOutlet var label3:UILabel!
    @IBOutlet var photoImageView: UIImageView!
    
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
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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




