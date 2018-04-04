//
//  CommMentorViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class CommMentorViewController: UIViewController {
    
    lazy var connService: ConnectionService = FirebaseConnectionService()
    
    var mentors = [User]()
    
    @IBOutlet weak var childView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        connService.addMentorsListener { (mentors, error) in
            if let mentors = mentors {
                self.mentors = mentors
                print(mentors)
                self.childView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = childView.indexPathsForSelectedItems {
            let mentor = self.mentors[indexPath[0][1]]
            let vc = segue.destination as! CommSwipeMentorViewController
            vc.user = mentor
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


extension CommMentorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mentors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MentorCollectionViewCell", for: indexPath) as! CommUserCollectionViewCell
        
        let name = mentors[indexPath.row].name
        let uid = mentors[indexPath.row].id
        
        cell.displayContent(uid: uid, name: name)
        
        return cell
    }
    


}

extension CommMentorViewController: UICollectionViewDelegate {
    
}
