//
//  FirestoreRepository.swift
//  catchBullying
//
//  Created by apple on 11/06/1443 AH.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

// create

// read

// update

// delete

class FirestoreRepository {
  
  static let db = Firestore.firestore()
  
  public static func create<T: Encodable>(collection: String, document: T, completion: @escaping (String) -> ()) {
    do {
      var ref: DocumentReference!
      try ref = db.collection(collection).addDocument(from: document) { error in
        if let error = error {
          fatalError(error.localizedDescription)
        }
        completion(ref.documentID)
      }
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
  public static func read<T: Decodable>(collection: String,
                                        field: String,
                                        value: Any, completion: @escaping (T) -> ()) {
    db.collection(collection).whereField(field, isEqualTo: value).getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      if let doc = snapshot?.documents.first {
        do {
          guard let data = try doc.data(as: T.self) else { return }
          completion(data)
        } catch {
          fatalError(error.localizedDescription)
        }
        
      }
    }
  }
  
  public static func read<T: Decodable>(collection: String,
                                        field: String,
                                        value: Any, completion: @escaping ([T]) -> ()) {
    db.collection(collection).whereField(field, isEqualTo: value).getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      var items: [T] = []
      if let docs = snapshot?.documents {
        for doc in docs {
          do {
            guard let data = try doc.data(as: T.self) else { return }
            items.append(data)
          } catch {
            fatalError(error.localizedDescription)
          }
        }
        completion(items)
      }
    }
  }
  
  public static func read<T: Decodable>(collection: String,
                                        field: String,
                                        valueAny: [Any], completion: @escaping ([T]) -> ()) {
    db.collection(collection).whereField(field, arrayContainsAny: valueAny).getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      var items: [T] = []
      if let docs = snapshot?.documents {
        for doc in docs {
          do {
            guard let data = try doc.data(as: T.self) else { return }
            items.append(data)
          } catch {
            fatalError(error.localizedDescription)
          }
        }
        completion(items)
      }
    }
  }
  
  public static func read<T: Decodable>(collection: String,
                                        field: String,
                                        values: [Any], completion: @escaping ([T]) -> ()) {
    db.collection(collection).whereField(field, in: values).getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      var items: [T] = []
      if let docs = snapshot?.documents {
        for doc in docs {
          do {
            guard let data = try doc.data(as: T.self) else { return }
            items.append(data)
          } catch {
            fatalError(error.localizedDescription)
          }
        }
        completion(items)
      }
    }
  }
  
  public static func read<T: Decodable>(collection: String,
                                        completion: @escaping ([T]) -> ()) {
    db.collection(collection).getDocuments { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      var items: [T] = []
      if let docs = snapshot?.documents {
        for doc in docs {
          do {
            guard let data = try doc.data(as: T.self) else { return }
            items.append(data)
          } catch {
            fatalError(error.localizedDescription)
          }
        }
        completion(items)
      }
    }
  }
  
  public static func read<T: Decodable>(collection: String, documentID: String,
                                        completion: @escaping (T) -> ()) {
    db.collection(collection).document(documentID).getDocument { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      if let doc = snapshot {
        do {
          guard let data = try doc.data(as: T.self) else { return }
          completion(data)
        } catch {
          fatalError(error.localizedDescription)
        }
        
      }
    }
  }
  
  public static func listen<T: Decodable>(collection: String, documentID: String, completion: @escaping (T) -> ()) {
    db.collection(collection).document(documentID).addSnapshotListener { snapshot, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      do {
        guard let data = try snapshot?.data(as: T.self) else { return }
        completion(data)
      } catch {
        fatalError(error.localizedDescription)
      }
    }
  }
  
  public static func update<T: Encodable>(collection: String,
                                          documentID: String,
                                          document: T, completion: @escaping () -> ()) {
    do {
      try db.collection(collection).document(documentID).setData(from: document, merge: true) { error in
        if let error = error {
          fatalError(error.localizedDescription)
        }
        completion()
      }
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
  public static func delete(collection: String,
                            documentID: String,
                            completion: @escaping () -> ()) {
    db.collection(collection).document(documentID).delete { error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
      completion()
    }
  }
}
