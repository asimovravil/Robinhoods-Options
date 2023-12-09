//
//  StrongExternalKokService.swift
//  Cashens Language
//
//  Created by Ravil on 14.10.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

final class KnowSetup {
    static let shared = KnowSetup()
    var getPrivacyLolKekPolicyURL: URL?
    func request(completion: @escaping (URL?) -> Void) {
        FirebaseApp.configure()
        if let url = IDontKnow.url, let url = URL(string: url) {
            completion(url)
            return
        }
        let document = Firestore.firestore().collection("global").document("wTLEtV7UtScf2LKWaGKW")
        
        document.getDocument { [weak self] doc, error in
            let privacy = doc?.get("privacy") as? String
            self?.getPrivacyLolKekPolicyURL = URL(string: privacy ?? "")
            if
                let doc = doc,
                let quiz = doc.get("quiz") as? Bool, quiz,
                let terms = doc.get("terms") as? String
            {
                completion(URL(string: terms))
            } else {
                completion(nil)
            }
        }
    }
}

