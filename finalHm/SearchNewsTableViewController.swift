//
//  SearchNewsTableViewController.swift
//  finalHm
//
//  Created by apple on 2021/6/10.
//

import UIKit

class SearchNewsTableViewController: UITableViewController ,UISearchResultsUpdating{
    
    var allNews = DBEdit.GetNews()
    var filterNews:[News] = []
    var count:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "favCell")
    }

    // MARK: - Table view data source

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        if searchString.isEmpty {return}
        switch searchController.searchBar.selectedScopeButtonIndex {
        case 0:
            filterNews = allNews.filter{(news)->Bool in
                return news.title.contains(searchString)
            }
        default:
            return
        }
        tableView.reloadData()
        //print(filterNews)
        print(allNews)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(allNews)
        // #warning Incomplete implementation, return the number of rows
        return filterNews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(allNews)
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)

        // Configure the cell...

        cell.textLabel?.text = filterNews[indexPath.row].title
        cell.detailTextLabel?.text = filterNews[indexPath.row].passtime
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = mainstoryboard.instantiateViewController(withIdentifier: "favDetailVC") as! FavDetailViewController
        let nav = self.presentingViewController?.navigationController
        detailVC.news = filterNews[indexPath.row]
        nav?.pushViewController(detailVC, animated: true)
    }

//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    

}
