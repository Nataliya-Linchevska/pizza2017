

import Foundation
import Firebase

class TableModel: FirebaseDataProtocol {
    
    //Properties
    
    var pictureId: Int
    var pictureName: String = ""
    var portraitMode: Int
    var rotation: Int
    var tableId: Int
    var key: String = ""
    var xCoordinate: Int
    var xResolution: Int
    var yCoordinate: Int
    var yResolution: Int
    
    //MARK: Init
    
    
    init(pictureId: Int, pictureName: String, portraitMode: Int, rotation: Int, tableId: Int, key: String, xCoordinate: Int, xResolution: Int, yCoordinate: Int, yResolution: Int) {
        self.pictureId = pictureId
        self.pictureName = pictureName
        self.portraitMode = portraitMode
        self.rotation = rotation
        self.tableId = tableId
        self.key = key
        self.xCoordinate = xCoordinate
        self.xResolution = xResolution
        self.yCoordinate = yCoordinate
        self.yResolution = yResolution
    }
    
    //MARK: Functions
    
    func getPostData() -> [String : Any] {
        
        return [
            FirebaseTables.Tables.Child.pictureId : pictureId,
            FirebaseTables.Tables.Child.pictureName : pictureName,
            FirebaseTables.Tables.Child.portraitMode : portraitMode,
            FirebaseTables.Tables.Child.rotation : rotation,
            FirebaseTables.Tables.Child.tableId : tableId,
            FirebaseTables.Tables.Child.key : key,
            FirebaseTables.Tables.Child.xCoordinate : xCoordinate,
            FirebaseTables.Tables.Child.xResolution : xResolution,
            FirebaseTables.Tables.Child.yCoordinate : yCoordinate,
            FirebaseTables.Tables.Child.yResolution : yResolution,
            
        ]
        
    }
    
}
