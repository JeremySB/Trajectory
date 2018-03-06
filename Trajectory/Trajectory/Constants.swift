//
//  Constants.swift
//  Trajectory
//
//  Created by Jeremy Bost on 3/3/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

struct FirestoreValues {
    // connection document keys
    static let connectionSentRequestDate = "sentRequestDate"
    
    // membership document keys
    static let membershipOrgId = "organizationId"
    static let membershipUid = "uid"
    static let membershipJoinDate = "joinDate"
    
    // root level collections
    static let organizationCollection = "organizations"
    static let membershipCollection = "org_memberships"
    static let userCollection = "users"
    static let goalCollection = "goals"
    static let connectionCollection = "connections"
}
