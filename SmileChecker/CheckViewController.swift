//
//  CheckViewController.swift
//  SmileChecker
//
//  Created by 関戸優紀 on 2021/05/23.
//

import UIKit

class CheckViewController: UIViewController {
    @IBOutlet var label1:UILabel!
    @IBOutlet var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func share(){
        print("シェア")
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
