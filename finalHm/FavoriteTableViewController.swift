//
//  FavoriteTableViewController.swift
//  finalHm
//
//  Created by apple on 2021/5/26.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    var searchController : UISearchController!
    var newsSet:[News] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearch()
        self.tableView.reloadData()
        /*
        setRefreshView()
        setMoreView()
        loadMore()
 */
    }

    func initSearch()
    {
        let resultsController = SearchNewsTableViewController()
        
        searchController = UISearchController(searchResultsController: resultsController)
        
        let searchBar = searchController.searchBar
        searchBar.scopeButtonTitles = ["新闻标题"]
        searchBar.placeholder = "Enter a search item"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultsController
        self.definesPresentationContext = true
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DBEdit.GetCount()
        
    }

    var count:Int = 0
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favNewsCell", for: indexPath)
        let anews :News = DBEdit.LoadNews(pos: count)

        cell.textLabel?.text = "\(anews.title)"
        cell.detailTextLabel?.text = "\(anews.passtime)"
        count = count+1
    
        return cell
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        newsSet = DBEdit.GetNews()
        if let dest = segue.destination as? FavDetailViewController
        {
            dest.news = newsSet[ tableView.indexPathForSelectedRow!.row]
        }
    }
    func showBadge(){
        let itemNum = DBEdit.GetCount()
        navigationController?.tabBarItem.badgeValue = "\(itemNum)"
    }
   

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        newsSet = DBEdit.GetNews()
        if editingStyle == .delete {
            // Delete the row from the data source
            DBEdit.DeleteNews(title: newsSet[indexPath.row].title)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        newsSet = DBEdit.GetNews()
        tableView.reloadData()
        count = 0
        
        navigationController?.tabBarItem.badgeValue = nil
        initSearch()
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
