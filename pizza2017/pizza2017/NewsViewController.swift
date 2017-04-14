//
//  NewsViewController.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let newsFirebaseHelper = NewsFirebaseHelper()
    var news = [NewsModel]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        newsFirebaseHelper.initFirebaseObserve(key: "") { 
            self.news = self.newsFirebaseHelper.getNews()
            print(self.news)
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "News", for: indexPath) as! NewsTableViewCell
        
        let new = news[indexPath.row]
        
        cell.lblTitle.text = new.title
        
        cell.tvNews.text = new.description
        
        let date = Date(timeIntervalSince1970: TimeInterval(new.timeStamp/1000))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        cell.lblDate.text = dateFormatter.string(from: date)
        if cell.newsImage.image == nil {
            newsFirebaseHelper.getImageFromStorage(nameOfImage: String(new.photoName), callBack: { image in
                cell.newsImage.image = image
            })
        }
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
