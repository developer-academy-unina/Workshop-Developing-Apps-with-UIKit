//
//  MentorsTableViewController.swift
//  Mentors_UIKit
//
//  Created by Giovanni Monaco on 22/03/23.
//

import UIKit

class MentorsTableViewController: UITableViewController {
    
    // Called when the view is about to be added to a view hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload of the table view.
        tableView.reloadData()
    }

    // Called when the view has been added to a view hierarchy.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Displays an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    // Tell the data source to return the number of sections in the table view.
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // Tell the data source to return the number of rows in a given section of a table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return mentors.count
        } else {
            return 0
        }
    }
    
    // Ask the data source for a cell to insert in a particular location of the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MentorCell", for: indexPath) as! MentorTableViewCell
        
        // Fetch model object to display
        let mentor = mentors[indexPath.row]
        
        // Configure cell
        cell.update(with: mentor)
        cell.showsReorderControl = true
        
        // Return cell
        return cell
    }
    
    // Tell the data source to return the height of the rows in the table view.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Ask the data source to commit the insertion or deletion of a specified row in the receiver.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            mentors.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Tell the data source to move a row at a specific location in the table view to another location.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedMentor = mentors.remove(at: fromIndexPath.row)
        mentors.insert(movedMentor, at: to.row)
    }
    
    // Ask the delegate for the editing style of a row at a particular location in a table view.
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // MARK: - Navigation

    /*
    // Preparation before navigation.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "MentorDetail",
               let destination = segue.destination as? MentorDetailViewController,
               let mentorIndex = tableView.indexPathForSelectedRow?.row
           {
               destination.mentor = mentors[mentorIndex]
           }
    }
     */

    // Segue used when the row is tapped
    @IBSegueAction func showMentorDetail(_ coder: NSCoder) -> MentorDetailViewController? {
            let mentorToShow = mentors[tableView.indexPathForSelectedRow?.row ?? 0]
            return MentorDetailViewController(coder: coder, mentor: mentorToShow)
    }
    
    // Segue used when + is tapped
    @IBSegueAction func addMentorSegue(_ coder: NSCoder) -> MentorDetailViewController? {
        return MentorDetailViewController(coder: coder, mentor: nil)
    }
    
    // Unwind Segue ToMentorsTableView
    @IBAction func unwindToMentorsTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
              let sourceViewController = segue.source as? MentorDetailViewController,
              let mentor = sourceViewController.mentor else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            mentors[selectedIndexPath.row] = mentor
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: mentors.count, section: 0)
            mentors.append(mentor)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
}
