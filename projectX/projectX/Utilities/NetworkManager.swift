//
//  NetworkManager.swift
//  projectX
//
//  Created by Radomyr Bezghin on 10/3/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import Foundation
import Firebase

class NetworkManager {
    
    static let shared = NetworkManager()
     
    let db = Firestore.firestore()
    
    func getDataForUser(_ uid: String,completion: @escaping (_ user: User?,_ error: Error?) -> Void){
        // Create a query against the collection.
        let query = db.users.whereField("userID", isEqualTo: uid)
        
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
}

extension NetworkManager{
    
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
}
