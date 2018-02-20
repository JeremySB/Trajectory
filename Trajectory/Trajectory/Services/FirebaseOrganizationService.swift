//
//  FirebaseOrganizationService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/19/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Firebase
import CodableFirebase

class FirebaseOrganizationService: OrganizationService {
    let organizationIdKey = "organizationId"
    let orgCollection = "organizations"
    
    func getOrganization(with id: String, completion: @escaping (Organization?, OrganizationServiceError?) -> Void) {
        db.collection(orgCollection).document(id).getDocument(completion: { (orgSnapshot, error) in
            do {
                let orgDecoded = try FirestoreDecoder().decode(Organization.self, from: orgSnapshot!.data()!)
                completion(orgDecoded, nil)
            } catch {
                completion(nil, .InvalidData(error.localizedDescription))
            }
        })
    }
    
    lazy var db = Firestore.firestore()
    
    func getAllOrganizations(_ completion: @escaping ([Organization]?, OrganizationServiceError?) -> Void) {
        db.collection(orgCollection).getDocuments { (snapshot, error) in
            if let error = error {
                return completion(nil, .Misc(error.localizedDescription))
            }
            guard let snapshot = snapshot else { return }
            var orgs = [Organization]()
            for org in snapshot.documents {
                if let orgDecoded = try? FirestoreDecoder().decode(Organization.self, from: org.data()) {
                    orgs.append(orgDecoded)
                }
            }
            
            completion(orgs, nil)
        }
    }
    
    func getOrganizations(for uid: String, completion: @escaping ([Organization]?, OrganizationServiceError?) -> Void) {
        db.collection("users").document(uid).collection("organizations").getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return completion(nil, .Misc(error!.localizedDescription)) }
            
            var orgs = [Organization]()
            
            let dispatch = DispatchGroup()
            
            for orgId in snapshot.documents {
                guard let id = orgId.get(self.organizationIdKey) as? String else { continue }
                dispatch.enter()
                self.getOrganization(with: id, completion: { (org, error) in
                    if let org = org {
                        orgs.append(org)
                    }
                    dispatch.leave()
                })
            }
            
            dispatch.notify(queue: .main) {
                completion(orgs, nil)
            }
        }
    }
    
    func getCurrentOrganizations(_ completion: @escaping ([Organization]?, OrganizationServiceError?) -> Void) {
        if let uid = Auth.auth().currentUser?.uid {
            getOrganizations(for: uid, completion: completion)
        }
        else {
            completion(nil, .NotLoggedIn)
        }
    }
    
    func joinOrganization(_ id: String, completion: ((OrganizationServiceError?) -> Void)?) {
        if let uid = Auth.auth().currentUser?.uid {
            db.collection("users").document(uid).collection("organizations").addDocument(data: [organizationIdKey: id], completion: { (error) in
                if let error = error {
                    completion?(.Misc(error.localizedDescription))
                } else {
                    completion?(nil)
                }
            })
        }
        else {
            completion?(.NotLoggedIn)
        }
    }
    
    func leaveOrganization(_ id: String, completion: ((OrganizationServiceError?) -> Void)?) {
        // TODO
    }
    
}
