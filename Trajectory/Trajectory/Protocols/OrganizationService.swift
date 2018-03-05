//
//  OrganizationService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/19/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

protocol OrganizationService {
    func getAllOrganizations(_ completion: @escaping ([Organization]?, OrganizationServiceError?) -> Void)
    
    func getOrganization(with id: String, completion: @escaping (Organization?, OrganizationServiceError?) -> Void)
    
    func getOrganizations(for uid: String, completion: @escaping ([Organization]?, OrganizationServiceError?) -> Void)
    
    func getMembers(of organizationIds: [String], completion: @escaping ([User]?, OrganizationServiceError?) -> Void)
    
    func getCurrentOrganizations(_ completion: @escaping ([Organization]?, OrganizationServiceError?) -> Void)
    
    func joinOrganization(_ id: String, completion: ((OrganizationServiceError?) -> Void)?)
    
    func leaveOrganization(_ id: String, completion: ((OrganizationServiceError?) -> Void)?)
    
}

enum OrganizationServiceError: Error {
    case NotLoggedIn
    case InvalidData(String?)
    case NoOrganizations
    case Misc(String)
}
