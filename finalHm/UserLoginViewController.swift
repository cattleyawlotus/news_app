//
//  UserLoginViewController.swift
//  finalHm
//
//  Created by apple on 2021/5/19.
//

import UIKit

class UserLoginViewController: UIViewController {

    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        txtUser.text = "2019302050089"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginEvent(_ sender: Any) {
        let usercode = txtUser.text!
        let password = txtPwd.text!
        
        if password == "123" && usercode == "2019302050089"{
            self.performSegue(withIdentifier: "login", sender: self)
        }
        else
        {
            let p = UIAlertController(title: "登录失败", message: "用户名或密码错误", preferredStyle: .alert)
            p.addAction(UIAlertAction(title: "确定", style: .default, handler: {(act:UIAlertAction) in self.txtPwd.text = ""}))
            present(p, animated: false, completion: nil)
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

}
