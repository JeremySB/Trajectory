//
//  FindOrgsViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class FindOrgsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {

    var searchResults : [User] = []
    var mentors : [User] = []
    let initialSearchTerm : String = ""
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var userService: UserService = FirebaseUserService()
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        
        let name = searchResults[indexPath.row].name
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
        searchResults.removeAll()
        for item in mentors {
            if (item.name?.contains(searchString)) ?? false {
                searchResults.append(item)
            }
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "mentorInfo" {
            if let indexPath = collectionView.indexPathsForSelectedItems {
                let vc = segue.destination as! MentorInfoViewController
                vc.user = self.searchResults[indexPath[0][1]]
            }
        }
    }
    

}
