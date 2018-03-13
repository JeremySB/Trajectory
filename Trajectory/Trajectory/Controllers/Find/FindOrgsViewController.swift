//
//  FindOrgsViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class FindOrgsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {

    weak var scrollController: FindViewController!
    var searchResults = [[String : [User]]]()
    var usersPerOrganization = [Organization : [User]]()
    var mentors : [User] = []
    let initialSearchTerm : String = ""
    let searchController = UISearchController(searchResultsController: nil)
    
    //TODO - Temporary user's organization array until actually implemented
    var userOrganizations = [Organization]()
    
    lazy var userService: UserService = FirebaseUserService()
    lazy var orgService: OrganizationService = FirebaseOrganizationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.becomeFirstResponder()
        
        // TODO: remove. only for testing
        orgService.joinOrganization("Test Org", completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        populateOrgsAndUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Array(searchResults[section])[0].value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell

        let name = Array(searchResults[indexPath.section])[0].value[indexPath.row].name
        let image = UIImage(named:"profileImg")!
        
        cell.displayContent(image: image, name: name ?? "Error")
        
        return cell
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: FindCollectionView!
    
    func populateOrgsAndUsers() {
        orgService.getCurrentOrganizations { (orgs, error) in
            if let orgs = orgs {
                self.userOrganizations = orgs
                
                let dispatch = DispatchGroup()
                
                for org in orgs {
                    guard let orgId = org.id else { continue }
                    dispatch.enter()
                    self.orgService.getMembers(of: [orgId], completion: { (users, errors) in
                        self.usersPerOrganization[org] = users
                        dispatch.leave()
                    })
                }
                dispatch.notify(queue: .main, execute: {
                    self.collectionView.reloadData()
                })
            }
        }
    }
    
    //Update search results
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchString = searchBar.text
        
        //Get filtered results based on search string
        self.searchForMatches(searchString: searchString ?? "")
        self.collectionView.reloadData()
    }
    
    //Client-side searching
    func searchForMatches(searchString: String) {
        searchResults.removeAll()
        //Setup searchResults array with user's organizations
        for item in self.usersPerOrganization {
            let userResultsInOrg: [String: [User]] = [item.key.name ?? "" : item.value.filter({ (user) -> Bool in
                user.name?.lowercased().contains(searchString.lowercased()) ?? false
            })]
            
            searchResults.append(userResultsInOrg)
        }
        
        //Discard any dictionaries with no results
        var counter = 0
        for org in searchResults {
            if Array(org)[0].value.count == 0 {
                searchResults.remove(at: counter)
                counter = counter - 1
            }
            counter = counter + 1
        }
    }
    
    //User begins typing in search bar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        updateSearchResults(for: searchController)
    }
    
    //User enters another character in search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        updateSearchResults(for: searchController)
    }
    
    //User clicks search bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateSearchResults(for: searchController)
        searchBar.resignFirstResponder()
    }
    
    //User taps cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        updateSearchResults(for: searchController)
        searchBar.resignFirstResponder()
    }
    
    //Set section title to be corresponding organization's name
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath as IndexPath) as! SectionHeaderCollectionReusableView
        
        header.headerLabel.text = Array(searchResults[indexPath.section])[0].key
        
        return header
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "mentorInfo" {
            if let indexPath = collectionView.indexPathsForSelectedItems {
                let vc = segue.destination as! MentorInfoViewController
                vc.user = Array(searchResults[indexPath[0][0]])[0].value[indexPath[0][1]] //self.searchResults[indexPath[0][1]]
            }
        }
    }
}
