//
//  HistoryViewController.swift
//  Trajectory
//
//  Created by student on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import JTAppleCalendar

class HistoryViewController: UIViewController {
    @IBOutlet weak var Cal: JTAppleCalendarView!
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension HistoryViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        // This function should have the same code as the cellForItemAt function
        let myCustomCell = cell as! CalendarCollectionViewCell
        sharedFunctionToConfigureCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as! CalendarCollectionViewCell
        sharedFunctionToConfigureCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
        return myCustomCell
    }
    
    func sharedFunctionToConfigureCell(myCustomCell: CalendarCollectionViewCell, cellState: CellState, date: Date) {
        myCustomCell.dateLabel.text = cellState.text
        if cellState.dateBelongsTo == .thisMonth {
            myCustomCell.dateLabel.textColor = UIColor.white
        } else {
            myCustomCell.dateLabel.textColor = UIColor.gray
        }
        
        //if testCalendar.isDateInToday(date) {
        //    myCustomCell.backgroundColor = UIColor.red
        //} else {
        //    myCustomCell.backgroundColor = UIColor.white
        //}
        // more code configurations
        // ...
        // ...
        // ...
    }
}

extension HistoryViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "02/18/2017")!
        let endDate = formatter.date(from: "04/18/2018")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
}
