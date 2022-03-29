//
//  ViewController.swift
//  finalHm
//
//  Created by apple on 2021/5/8.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var news:News?
    
    @IBOutlet weak var web: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: news!.path)
        let request =  URLRequest(url: url!)
        web.load(request)
        
        
        
    }

    @IBAction func tt(_ sender: Any) {
        
        let alert = UIAlertController(title: "提示", message: "收藏成功", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: {_ in self.navigationController?.popViewController(animated: true)}))
        
        self.present(alert, animated: true, completion: nil)
        
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return}
        let insert = "INSERT INTO NEWS(title,path,passtime,image) VALUES( '\(self.news!.title)', '\(self.news!.path)',  '\(self.news!.passtime)',  '\(self.news!.image)'); "
        if !sqlite.execNoneQuerySQL(sql: insert){
            sqlite.closeDB();return }
        sqlite.closeDB()
        let nav = tabBarController?.viewControllers?[1] as? UINavigationController
        let fav = nav?.viewControllers.first as? FavoriteTableViewController
        fav?.showBadge()
        
        performSegue(withIdentifier: "unWin", sender: self)
    }
    
}


