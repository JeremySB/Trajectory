//
//  CommMenteeViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class CommMenteeViewController: UIViewController {
    
    lazy var connService: ConnectionService = FirebaseConnectionService()
    
    var mentees = [User]()
    
    @IBOutlet weak var childView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        connService.addMenteesListener { (mentees, error) in
            if let mentees = mentees {
                self.mentees = mentees
                print(mentees)
                self.childView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = childView.indexPathsForSelectedItems {
            let mentee = self.mentees[indexPath[0][1]]
            let vc = segue.destination as! CommSwipeMenteeViewController
            vc.user = mentee
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CommMenteeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mentees.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenteeCollectionViewCell", for: indexPath) as! CommUserCollectionViewCell
        
        let name = mentees[indexPath.row].name
        let uid = mentees[indexPath.row].id
        
        cell.displayContent(uid: uid, name: name)
        
        return cell
    }
    
    
    
}

extension CommMenteeViewController: UICollectionViewDelegate {
    
}
