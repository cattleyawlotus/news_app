//
//  dbEdit.swift
//  finalHm
//
//  Created by apple on 2021/5/26.
//

import Foundation
class DBEdit{
    static func initDB()
    {
        let sqlite = SQLiteManager.sharedInstance
        
        if !sqlite.openDB()
        {return}
        
        let createSql = "CREATE TABLE IF NOT EXISTS NEWS('title' TEXT NOT NULL PRIMARY KEY, " +
        "'path' TEXT, 'passtime' TEXT, 'image' TEXT);"
        
        if !sqlite.execNoneQuerySQL(sql: createSql){
            sqlite.closeDB();return
        }
        
        let cleanALLStu = "DELETE FROM NEWS"
        if !sqlite.execNoneQuerySQL(sql: cleanALLStu){
            sqlite.closeDB();return
        }
        
        let resetStu = "DELETE FROM sqlite_sequence WHERE name = 'title';"
        if !sqlite.execNoneQuerySQL(sql: resetStu){
            sqlite.closeDB();return
        }
        /**
         let stu0 = "INSERT INTO student(name,phone) VALUES('张三','zhangsan@whu.edu.cn');"
         let stu1 = "INSERT INTO student(name,phone) VALUES('李四','lisi@whu.edu.cn');"
         
         if !sqlite.execNoneQuerySQL(sql: stu0){sqlite.closeDB();return}
         if !sqlite.execNoneQuerySQL(sql: stu1){sqlite.closeDB();return}
         */
        
        
        sqlite.closeDB()
    }
    static func GetNews()->[News]{
        let sqlite = SQLiteManager.sharedInstance
        
        var newsSet:[News] = []
        if !sqlite.openDB(){return newsSet}
        
        let queryResult = sqlite.execQuerySQL(sql: "SELECT title, path, passtime FROM NEWS")
        for item in queryResult!{
            var fetchNews:News = News(title:"title")
            fetchNews.title = "\(item["title"]!)"
            fetchNews.passtime = "\(item["passtime"]!)"
            fetchNews.path = "\(item["path"]!)"
            newsSet.append(fetchNews)
        }
        
        sqlite.closeDB();
        return newsSet
    }
//    返回对应次序和位置的新闻
    static func LoadNews(pos:Int)->News{
        let sqlite = SQLiteManager.sharedInstance
        var fetchNews:News = News(title:"title")
        
        if !sqlite.openDB(){return fetchNews}
        
        let queryResult = sqlite.execQuerySQL(sql: "SELECT title, path, passtime FROM NEWS")
        let result = queryResult![pos]
        fetchNews.title = "\(result["title"]!)"
        fetchNews.passtime = "\(result["passtime"]!)"
        fetchNews.path = "\(result["path"]!)"
         
        
        sqlite.closeDB();
        return fetchNews
    }
    
    static func GetCount()->Int{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return 0}
        let queryResult = sqlite.execQuerySQL(sql: "SELECT COUNT(*) FROM NEWS")
        let num = queryResult![0]["COUNT(*)"]
        return num as! Int
    }
    
    static func DeleteNews(title:String){
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return}
        let delete = "DELETE FROM NEWS WHERE title='\(title)' "
        if !sqlite.execNoneQuerySQL(sql: delete){
            sqlite.closeDB();return }
        sqlite.closeDB()
    }
    
}
