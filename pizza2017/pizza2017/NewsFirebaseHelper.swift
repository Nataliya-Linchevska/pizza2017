

import Foundation
import Firebase

class NewsFirebaseHelper: FirebaseHelper {
    
    //MARK: Properties
    
    private var news = [NewsModel]()
    
    //MARK: Firebase Functions
    
    override func getTableName() -> String {
        
        return FirebaseTables.News.TableName
        
    }
    
    override func getImageFolderName() -> String {
        
        return FirebaseTables.News.ImageFolder
        
    }
    
    func initFirebaseObserve(key: String, callback: @escaping ()->()) {
        
        news.removeAll()
        
        super.initObserve { (snapshot) -> () in
            self.updateNewsGroups(snapshot, key)
            callback()
        }
        
    }
    
    
    //MARK: Dishes Functions
    
    func getNews() -> [NewsModel] {
        
        return news
        
    }
    
    func getNews(_ index: Int) -> NewsModel {
        
        return news[index]
        
    }
    
    private func updateNewsGroups(_ snapshot: FIRDataSnapshot, _ dishKey: String) {
        
        news.removeAll()
        
        for items in snapshot.children {
            
            let validDishDictionary = (items as! FIRDataSnapshot).value as! NSDictionary
            let title = validDishDictionary[FirebaseTables.News.Child.Title] as! String
            let timeStamp = validDishDictionary[FirebaseTables.News.Child.TimeStamp] as! Int
            let description = validDishDictionary[FirebaseTables.News.Child.Description] as! String
            let photoUrl = validDishDictionary[FirebaseTables.News.Child.PhotoUrl] as! String
            let photoName = validDishDictionary[FirebaseTables.News.Child.PhotoName] as! String
            let key = validDishDictionary[FirebaseTables.News.Child.Key] as! String
            
            let new = NewsModel(title: title, description: description, photoUrl: photoUrl, photoName: photoName, timeStamp: timeStamp, key: key)
            
            news.append(new)
        }
    }
    
    
}
