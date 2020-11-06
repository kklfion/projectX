//
//  NetworkManager.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation
import Firebase

///enables sending collection type as a parameter in a function
enum CollectionEnumType: String{
    case posts
    case users
    case missions
    case stations
    case comments
    
    case notifications
    case acceptedMissions
    case followedStations
    case likedPosts
    case likedComments
    case followers
    case blacklistedUsers

}

///enum used to create whereField queries with Firebase
enum FirestoreFields: String {
    
    case stationID
    case stationType
    case parentStationID
    
    case userID = "userID"
    case userInfo
    case userInfoUserID = "userInfo.userID"
    
    case postID
    
    case missionID

}
class NetworkManager {

    static let shared = NetworkManager()

    /// query example let query = NetworkManager.shared.db.posts.whereField("userInfo.userID", isEqualTo: userid)
    
    let db = Firestore.firestore()
}
//MARK: Get data
extension NetworkManager {
    /// fetches 1 document for uid, must be decodable
    func getDocumentForID<GenericDocument>(collection: CollectionEnumType,
                                           uid: String,
                                           completion: @escaping (_ document: GenericDocument?,_ error: Error?) -> Void)
                                           where GenericDocument: Decodable{
        // Create a query against the collection.
        let query = db.collection(collection.rawValue).document("\(uid)")
        query.getDocument { (document, error) in
            let result = Result {
              try document?.data(as: GenericDocument.self)
            }
            switch result {
            case .success(let genericDocument):
                if let genericDocument = genericDocument {
                    // A `genericDocument` value was successfully initialized from the DocumentSnapshot.
                    completion(genericDocument, nil)
                } else {
                    // A nil value was successfully initialized from the DocumentSnapshot,
                    // or the DocumentSnapshot was nil.
                    print("Document does not exist")
                    completion(nil, nil)
                }
            case .failure(let error):
                // A `City` value could not be initialized from the DocumentSnapshot.
                completion(nil, error)
            }
        }
    }
    /// fetches generic documents for query.
    func getDocumentsForQuery<GenericDocument>(query: Query,
                                               completion: @escaping (_ document: [GenericDocument]?,_ error: Error?) -> Void)
                                               where GenericDocument: Decodable{
        query.getDocuments { (snapshot, error) in
            if let error = error {

                completion(nil, error)
            }
            guard let documents = snapshot?.documents else { return }
            let genericDocs = documents.compactMap { (querySnapshot) -> GenericDocument? in
                return try? querySnapshot.data(as: GenericDocument.self)
            }
            if(genericDocs.count > 0){
                completion(genericDocs, nil)
            }else{
                completion(nil, nil)
            }
        }
    }
    
}
//MARK: Put data
extension NetworkManager {
    func writeDocumentsWith<GenericDocuments>(collectionType: CollectionEnumType,
                                              documents: [GenericDocuments],
                                              completion: @escaping (_ error: Error?) -> Void)
                                              where GenericDocuments: Encodable{
        for document in documents{
            do {
                let _ = try db.collection(collectionType.rawValue).addDocument(from: document)
            }
            catch {
                completion(error)
                break;
            }
            completion(nil)
        }
        
    }
    func deleteDocumentsWith(collectionType: CollectionEnumType,
                                              documentID: String,
                                              completion: @escaping (_ error: Error?) -> Void)
        {
        
        
        db.collection(collectionType.rawValue).document(documentID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
    }
}
    
//    db.collection("cities").document("DC").delete() { err in
//        if let err = err {
//            print("Error removing document: \(err)")
//        } else {
//            print("Document successfully removed!")
//        }
//    }


//MARK: outdated, can be refactored with generic queries
extension NetworkManager {
    func getDataForUser(_ uid: String,completion: @escaping (_ user: User?,_ error: Error?) -> Void){
        // Create a query against the collection.
        let query = db.users.whereField(FirestoreFields.userID.rawValue, isEqualTo: uid)

        query.getDocuments { (snapshot, error) in
            if let error = error {

                completion(nil, error)
            }
            guard let documents = snapshot?.documents else { return }
            let user = documents.compactMap { (querySnapshot) -> User? in
                return try? querySnapshot.data(as: User.self)
            }
            if(user.count == 1){
                completion(user[0], nil)
            }else{
                completion(nil, nil)
            }

        }
    }
    func getDataForStation(_ uid: String,completion: @escaping (_ station: Station?,_ error: Error?) -> Void){
        // Create a query against the collection.
        let query = db.stations.document("\(uid)")
        query.getDocument { (document, error) in
            let result = Result {
              try document?.data(as: Station.self)
            }
            switch result {
            case .success(let station):
                if let station = station {
                    // A `station` value was successfully initialized from the DocumentSnapshot.
                    print("Station: \(station)")
                } else {
                    // A nil value was successfully initialized from the DocumentSnapshot,
                    // or the DocumentSnapshot was nil.
                    print("Document does not exist")
                }
            case .failure(let error):
                // A `City` value could not be initialized from the DocumentSnapshot.
                print("Error decoding station: \(error)")
            }
        }
    }
    /// returns top posts for station
    func getPostsForStation(_ uid: String,completion: @escaping (_ post: [Post]?,_ error: Error?) -> Void){
        // Create a query against the collection.
        let query = db.posts.whereField(FirestoreFields.stationID.rawValue, isEqualTo: uid)

        query.getDocuments { (snapshot, error) in
            if let error = error {

                completion(nil, error)
            }
            guard let documents = snapshot?.documents else { return }
            let posts = documents.compactMap { (querySnapshot) -> Post? in
                return try? querySnapshot.data(as: Post.self)
            }
            if(posts.count > 0){
                completion(posts, nil)
            }else{
                completion(nil, nil)
            }
        }
    }
    func getMissionsForStation(_ uid: String,completion: @escaping (_ board: [Mission]?,_ error: Error?) -> Void){
        // Create a query against the collection.
        let query = db.missions.whereField(FirestoreFields.stationID.rawValue, isEqualTo: uid)

        query.getDocuments { (snapshot, error) in
            if let error = error {

                completion(nil, error)
            }
            guard let documents = snapshot?.documents else { return }
            let missions = documents.compactMap { (querySnapshot) -> Mission? in
                return try? querySnapshot.data(as: Mission.self)
            }
            if(missions.count > 0){
                completion(missions, nil)
            }else{
                completion(nil, nil)
            }
        }
    }
}
//MARK: Loading images Async
extension NetworkManager{
    func getAsynchImage(withURL url: URL?, completion: @escaping (_ image: UIImage?,_ error: Error?) -> ()){
        guard let url = url else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error in downloding image: \(error)")
                completion(nil, error)
            }
            else if let data = data {
                let image = UIImage(data: data)
                completion(image, nil)
            }
        }.resume()
    }
    func getAsynchImage(withURL url: URL, completion: @escaping (_ image: UIImage?,_ error: Error?) -> ()){
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error in downloding image: \(error)")
                completion(nil, error)
            }
            else if let data = data {
                let image = UIImage(data: data)
                completion(image, nil)
            }
        }.resume()
    }
    func getAsynchImage(withStringURL stringURL: String, completion: @escaping (_ image: UIImage?,_ error: Error?) -> ()){
        guard let url = URL(string: stringURL) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error in downloding image: \(error)")
                completion(nil, error)
            }
            else if let data = data {
                let image = UIImage(data: data)
                completion(image, nil)
            }
        }.resume()
    }
}
