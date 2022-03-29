//
//  imageNewsTableViewCell.swift
//  finalHm
//
//  Created by apple on 2021/6/10.
//

import UIKit
import  Foundation

class imageNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var NewsTitleLabel: UILabel!
    @IBOutlet weak var NewsTimeLabel: UILabel!
    @IBOutlet weak var NewsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        NewsTitleLabel.numberOfLines = 0
        NewsTitleLabel.lineBreakMode = NSLineBreakMode.byCharWrapping
        // Configure the view for the selected state
    }
    
}
extension UIImageView{
    func loadURLimage(imageurl : String){
        //创建URL对象
        let url = URL(string: imageurl)!
        //创建请求对象
        let request = URLRequest(url: url)

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil{
                print(error.debugDescription)
            }else{
                //将图片数据赋予UIImage
                let img = UIImage(data:data!)

                // 这里需要改UI，需要回到主线程
                DispatchQueue.main.async {
                  self.image = img
                }

            }
        }) as URLSessionTask

        //使用resume方法启动任务
        dataTask.resume()
    }
}

