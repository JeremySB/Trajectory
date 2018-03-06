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
    lazy var db = Firestore.firestore()
    
    func getMembers(of organizationIds: [String], completion: @escaping ([User]?, OrganizationServiceError?) -> Void) {
        var memberIds = Set<String>()
        let dispatch = DispatchGroup()
        
        for orgId in organizationIds {
            dispatch.enter()
            db.collection(FirestoreValues.membershipCollection).whereField(FirestoreValues.membershipOrgId, isEqualTo: orgId).getDocuments(completion: { (snapshot, error) in
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        if let memUid = document.get(FirestoreValues.membershipUid) as? String {
                            memberIds.insert(memUid)
                        }
                    }
                }
                
                dispatch.leave()
            })
        }
        
        dispatch.notify(queue: .global()) {
            let userDispatch = DispatchGroup()
            let userService = FirebaseUserService()
            var users = [User]()
            for memberId in memberIds {
                userDispatch.enter()
                userService.getUser(uid: memberId, completion: { (user, error) in
                    if let user = user {
                        users.append(user)
                    }
                    userDispatch.leave()
                })
            }
            
            userDispatch.notify(queue: .global(), execute: {
                completion(users, nil)
            })
        }
    }
    
    func getOrganization(with id: String, completion: @escaping (Organization?, OrganizationServiceError?) -> Void) {
        db.collection(FirestoreValues.organizationCollection).document(id).getDocument(completion: { (orgSnapshot, error) in
            do {
                let orgDecoded = try FirestoreDecoder().decode(Organization.self, from: orgSnapshot!.data()!)
                orgDecoded.id = id
                completion(orgDecoded, nil)
            } catch {
                completion(nil, .InvalidData(error.localizedDescription))
            }
        })
    }
    
    func getAllOrganizations(_ completion: @escaping ([Organization]?, OrganizationServiceError?) -> Void) {
        db.collection(FirestoreValues.organizationCollection).getDocuments { (snapshot, error) in
            if let error = error {
                return completion(nil, .Misc(error.localizedDescription))
            }
            guard let snapshot = snapshot else { return }
            var orgs = [Organization]()
            for org in snapshot.documents {
                if let orgDecoded = try? FirestoreDecoder().decode(Organization.self, from: org.data()) {
                    orgDecoded.id = org.documentID
                    orgs.append(orgDecoded)
                }
            }
            
            completion(orgs, nil)
        }
    }
    
    func getOrganizations(for uid: String, completion: @escaping ([Organization]?, OrganizationServiceError?) -> Void) {
        db.collection(FirestoreValues.membershipCollection).whereField(FirestoreValues.membershipUid, isEqualTo: uid).getDocuments(completion: { (snapshot, error) in
            guard let snapshot = snapshot else { return completion(nil, .Misc(error!.localizedDescription)) }
            
            var orgs = [Organization]()
            
            let dispatch = DispatchGroup()
            
            for membership in snapshot.documents {
                guard let id = membership.get(FirestoreValues.membershipOrgId) as? String else { continue }
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
        })
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
            db.collection(FirestoreValues.membershipCollection).document(uid+" "+id)
                .setData([FirestoreValues.membershipOrgId: id, FirestoreValues.membershipUid: uid, "joinDate": FieldValue.serverTimestamp()],
                         completion: { (error) in
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
