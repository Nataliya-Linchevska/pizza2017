
import Foundation
import Firebase

class TablesFirebaseHelper: FirebaseHelper {
    
    //MARK: Properties
    
    private var tables = [TableModel]()
    
    //MARK: Functions
    
    override func getTableName() -> String {
        
        return FirebaseTables.Tables.TableName
        
    }
    
    
    func initFirebaseObserve(key: String, callback: @escaping ()->()) {
        
        tables.removeAll()
        
        super.initObserve { (snapshot) -> () in
            self.updateTables(snapshot, key)
            callback()
        }
        
    }
    
    func getTables() -> [TableModel] {
        
        return tables
        
    }
    
    func getTable(_ index: Int) -> TableModel {
        
        return tables[index]
        
    }
    
    private func updateTables(_ snapshot: FIRDataSnapshot, _ dishKey: String) {
        
        tables.removeAll()
        
        for items in snapshot.children {
            
            let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
            
            let key = tasksInFirebase[FirebaseTables.Tables.Child.key] as? String
            let pictureId = tasksInFirebase[FirebaseTables.Tables.Child.pictureId] as? Int
            let pictureName = tasksInFirebase[FirebaseTables.Tables.Child.pictureName] as? String
            let portraitMode = tasksInFirebase[FirebaseTables.Tables.Child.portraitMode] as? Int
            let rotation = tasksInFirebase[FirebaseTables.Tables.Child.rotation] as? Int
            let tableId = tasksInFirebase[FirebaseTables.Tables.Child.tableId] as? Int
            let xCoordinate = tasksInFirebase[FirebaseTables.Tables.Child.xCoordinate] as? Int
            let xResolution = tasksInFirebase[FirebaseTables.Tables.Child.xResolution] as? Int
            let yCoordinate = tasksInFirebase[FirebaseTables.Tables.Child.yCoordinate] as? Int
            let yResolution = tasksInFirebase[FirebaseTables.Tables.Child.yResolution] as? Int
            
           
            tables.append(TableModel(pictureId: pictureId ?? 0, pictureName: pictureName ?? "", portraitMode: portraitMode!, rotation: rotation!, tableId: tableId!, key: key!, xCoordinate: xCoordinate!, xResolution: xResolution!, yCoordinate: yCoordinate!, yResolution: yResolution!))
            
            
        }
        
    }
}


