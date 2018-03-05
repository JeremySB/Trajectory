//
//  FindOrgsViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class FindOrgsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {

    var searchResults = [[String : [User]]]()
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
        
        
        orgService.getCurrentOrganizations { (orgs, error) in
            if let orgs = orgs {
                self.userOrganizations = orgs
            }
        }
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
    
    //Update search results
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchString = searchBar.text
        
        //Get filtered results based on search string
        
        userService.getAllUsers { (users, error) in
            if let users = users {
                self.mentors = users
                self.searchForMatches(searchString: searchString ?? "")
                self.collectionView.reloadData()
            }
        }
    }
    
    //Client-side searching
    func searchForMatches(searchString: String) {
        //Create general search items array
        var searchItems : [User] = []
        //Filter through mentors using search string
        for item in mentors {
            if (item.name?.contains(searchString)) ?? false {
                searchItems.append(item)
            }
        }
        filterMatchesByOrganization(searchItems: searchItems)
    }
    
    //Client-side organization filtering
    func filterMatchesByOrganization(searchItems : [User]) {
        //Clear old search results
        searchResults.removeAll()
        //Setup searchResults array with user's organizations
        for org in userOrganizations {
            let myDictionary: [String: [User]] = [org.name ?? "" : []]
            searchResults.append(myDictionary)
        }
        //Sort search items by organization into searchResults array
        for item in searchItems {
            //Only add mentor if he is a part of one of the user's organizations
            //if let location = userOrganizations.index(of: (item.organization ?? "No Organization")) {
            //    searchResults[location][("No Organization")]!.append(item)
            //}
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
