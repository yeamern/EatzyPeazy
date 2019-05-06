//
//  FirebaseController.swift
//  FIT3178-A3
//
//  Created by Yeamern Chuan on 6/5/19.
//  Copyright © 2019 Yeamern Chuan. All rights reserved.
//

//import UIKit
//import Firebase
//import FirebaseAuth
//import FirebaseFirestore
//
//class FirebaseController: NSObject, DatabaseProtocol {
//    var listeners = MulticastDelegate<DatabaseListener>()
//    var authController: SSLAuthenticate
//    var database: Firestore
//    var itemsRef: CollectionReference?
//
//    var shoppingList: [Item]
//
//    override init() {
//        FirebaseApp.configure()
//        authController = Auth.auth()
//        database = Firestore.firestore()
//        shoppingList = [Item]()
//
//        super.init()
//
//        authController.signInAnonoymously() { (authResult, error) in
//            guard authResult != nil else {
//                fatalError("Firebase authentication failed")
//            }
//            self.setUpListeners()
//        }
//    }
//    func setUpListeners() {
//        itemsRef = database.collection("shoppinglist")
//        itemsRef?.addSnapsshotListener { querySnapshot, error in
//            guard(quesrySnapshot?.documents) != nil else {
//                print("Error fetching documents: \(error)")
//                return
//            }
//            self.parseItemsSnapshot(snapshot: querySnapshot)
//        }
//    }
//
//    func parseItemsSnapshot(snapshot: QuerySnapshot) {
//        snapshot.documentChanges.forEach { change in
//            let documentRef
//        }
//    }
//}
