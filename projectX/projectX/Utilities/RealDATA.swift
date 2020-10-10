//
//  RealDATA.swift
//  projectX
//
//  Created by Jake Nations on 10/10/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//
import FirebaseFirestore





struct queryData {
    

    
    static func queryPost(completion: @escaping (_ stations: [Post]) -> Void){
         var db: Firestore!
         db = Firestore.firestore()
         let basicQuery = db.collection("posts").limit(to: 5)
         var posts = [Post]()
         basicQuery.getDocuments { (snapshot, error) in
          if let snapshotDocuments = snapshot?.documents {
              for document in snapshotDocuments{
                  do{
                      if let post = try document.data(as: Post.self){
                          print(post.userInfo.name)
                          posts.append(post)
                      }
                  } catch let error as NSError{
                      print("error: \(error.localizedDescription)")
                  }
              }
          }
            completion(posts)
        }
          
    }//function end
    
}//struct end


