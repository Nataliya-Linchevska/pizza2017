
import Foundation
import Firebase

class ReservedTablesFirebaseHelper: FirebaseHelper {
    
    //MARK: Properties
    
    private var tables = [ReservedTableModel]()
    
    //MARK: Functions
    
    override func getTableName() -> String {
        
        return FirebaseTables.ReservedTables.TableName
        
    }
    
    
    func initFirebaseObserve(key: String, callback: @escaping ()->()) {
        
        tables.removeAll()
        
        super.initObserve { (snapshot) -> () in
            self.updateTables(snapshot, key)
            callback()
        }
        
    }
    
    func getTables() -> [ReservedTableModel] {
        
        return tables
        
    }
    
    func getTable(_ index: Int) -> ReservedTableModel {
        
        return tables[index]
        
    }
    
    private func updateTables(_ snapshot: FIRDataSnapshot, _ dishKey: String) {
        
        tables.removeAll()
        
        for items in snapshot.children {
            
            let tasksInFirebase = (items as! FIRDataSnapshot).value as! NSDictionary
            
            let key = tasksInFirebase[FirebaseTables.ReservedTables.Child.key] as? String
            let clientName = tasksInFirebase[FirebaseTables.ReservedTables.Child.clientName] as? String
            let commentClient = tasksInFirebase[FirebaseTables.ReservedTables.Child.commentClient] as? String
            let date = tasksInFirebase[FirebaseTables.ReservedTables.Child.date] as? [String:Int]
            let isCheckedByAdmin = tasksInFirebase[FirebaseTables.ReservedTables.Child.isCheckedByAdmin] as? Int
            let isNotificated = tasksInFirebase[FirebaseTables.ReservedTables.Child.isNotificated] as? Int
            let phoneClient = tasksInFirebase[FirebaseTables.ReservedTables.Child.phoneClient] as? String
            let tableKey = tasksInFirebase[FirebaseTables.ReservedTables.Child.tableKey] as? String
            let userId = tasksInFirebase[FirebaseTables.ReservedTables.Child.userId] as? String
            
            guard let keyUnwrapped = key else {
                continue
            }
            
            tables.append(ReservedTableModel(clientName: clientName!, commentClient: commentClient!, date: date!, isCheckedByAdmin: isCheckedByAdmin!, isNotificated: isNotificated!, key: key!, phoneClient: phoneClient!, tableKey: tableKey!, userId: userId!))
            
            
        }
        
    }
}
