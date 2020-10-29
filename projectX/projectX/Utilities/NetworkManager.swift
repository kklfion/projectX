//
//  NetworkManager.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation
import Firebase

enum Fields: String {
    case stationID = "stationID"
    case userID = "userID"
    case postID = "postID"
    case userInfo = "userInfo"
}
class NetworkManager {

    static let shared = NetworkManager()

    let db = Firestore.firestore()
    /// fetches 1 document with uid, must be decodable
    func getDocumentFor<GenericDocument>(uid: String,completion: @escaping (_ document: GenericDocument?,_ error: Error?) -> Void) where GenericDocument: Decodable{
        // Create a query against the collection.
        let query = db.stations.document("\(uid)")
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
    /// fetches 1 document with uid, must be decodable
    func getDocumentsFor<GenericDocument>(query: Query,completion: @escaping (_ document: [GenericDocument]?,_ error: Error?) -> Void) where GenericDocument: Decodable{
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
    func getDataForUser(_ uid: String,completion: @escaping (_ user: User?,_ error: Error?) -> Void){
        // Create a query against the collection.
        let query = db.users.whereField(Fields.userID.rawValue, isEqualTo: uid)

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
        let query = db.posts.whereField(Fields.stationID.rawValue, isEqualTo: uid)

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
        let query = db.boards.whereField(Fields.stationID.rawValue, isEqualTo: uid)

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
