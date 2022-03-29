//
//  FavDetailViewController.swift
//  finalHm
//
//  Created by apple on 2021/6/8.
//

import UIKit
import WebKit

class FavDetailViewController: UIViewController {

    var news:News?
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: news!.path)
        let request =  URLRequest(url: url!)
        WKnewsView.load(request)
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var WKnewsView: WKWebView!
  
//    @IBAction func tt(_ sender: Any) {
//
//        let alert = UIAlertController(title: "提示", message: "删除成功", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: {_ in self.navigationController?.popViewController(animated: true)}))
//
//        self.present(alert, animated: true, completion: nil)
//
//        DBEdit.DeleteNews(title: news!.title)
//
//
//        //performSegue(withIdentifier: "favUnwin", sender: self)
//    }
    /*
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */

}
