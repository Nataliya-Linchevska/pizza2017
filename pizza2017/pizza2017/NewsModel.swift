

import Foundation

class NewsModel: FirebaseDataProtocol {
    
    //Properties
    
    var description: String = ""
    var photoUrl: String = ""
    var photoName: String = ""
    var timeStamp: Int
    var key: String = ""
    var title: String = ""
    
    //MARK: Init
    
    
    init(title: String, description: String, photoUrl: String, photoName: String, timeStamp: Int, key: String) {
        self.title = title
        self.description = description
        self.photoUrl = photoUrl
        self.photoName = photoName
        self.key = key
        self.timeStamp = timeStamp
    }
    
    //MARK: Functions
    
    func getPostData() -> [String : Any] {
        
        return [
            
            FirebaseTables.News.Child.Key : key,
            FirebaseTables.News.Child.TimeStamp : timeStamp,
            FirebaseTables.News.Child.Title : title,
            FirebaseTables.News.Child.Description : description,
            FirebaseTables.News.Child.PhotoName : photoName,
            FirebaseTables.News.Child.PhotoUrl : photoUrl,
            
        ]
        
    }
    
}

