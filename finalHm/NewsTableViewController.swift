//
//  TableViewController.swift
//  finalHm
//
//  Created by apple on 2021/5/8.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let xib =  UINib(nibName: "imageNewsTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "customNewsCell")
        tableView.rowHeight = 130
        setRefreshView()
        setMoreView()
        loadMore()
        DBEdit.initDB()
    }
    
    
    
    //上拉刷新视图
    func setMoreView() {
        let loadMoreView = UIView(frame: CGRect(x:0, y:self.tableView.contentSize.height,width:self.tableView.bounds.size.width, height:60))
        loadMoreView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        loadMoreView.backgroundColor = self.tableView.backgroundColor
        
        //添加中间的环形进度条
        let indicator = UIActivityIndicatorView()
        //indicator.color = UIColor.darkGray
        let indicatorX = self.view.frame.width/2-indicator.frame.width/2
        let indicatorY = loadMoreView.frame.size.height/2-indicator.frame.height/2
        indicator.frame = CGRect(x:indicatorX, y:indicatorY, width:indicator.frame.width, height:indicator.frame.height)
        indicator.startAnimating()
        loadMoreView.addSubview(indicator)
        self.tableView.tableFooterView = loadMoreView
    }
    
    func setRefreshView()
    {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        self.refreshData()
    }

    
    // 刷新数据
    @objc func refreshData() {
        NewsManager.shared.refresh{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.refreshControl!.endRefreshing()
    }
    
    
    
    //加载更多数据
    func loadMore(){
        print("加载新数据！")
        NewsManager.shared.fetchMore {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsManager.shared.news.count
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customNewsCell", for: indexPath) as! imageNewsTableViewCell
        //todo init cell
        let anews = NewsManager.shared.news[indexPath.row]
        cell.NewsTitleLabel?.text = anews.title
        cell.NewsTimeLabel?.text = anews.passtime
        cell.NewsImage.loadURLimage(imageurl: anews.image)
        //当下拉到底部，执行loadMore()
        if (indexPath.row == NewsManager.shared.news.count-1) {
            loadMore()
        }
        
        return cell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newsDetail", sender: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? ViewController
        {
            dest.news = NewsManager.shared.news[ tableView.indexPathForSelectedRow!.row]
        }
    }
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        
    }
}
