//
//  courseMain.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/18/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import UIKit
import FirebaseFirestore

class courseMain: UITableViewController {
   // var grandmaDelegate: Favorite!
    var specificSubject:subject?
    var commentForCourse:clase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        if let DCsubject = specificSubject{
            navigationItem.title  = DCsubject.name.rawValue
           //set navigation title to be the subject name (e.g. Computer Science)

        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Number of Section
        return 1
    }
   //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // number of Rows in each sections
        if let DCsubject = specificSubject{
            if let DCcourseCollection = DCsubject.courseCollection{
                return DCcourseCollection.count
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       //configure individual cell to display individual courses,(course name, favorite, comment, instructor name, course status)
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! courseCell
    
        cell.motherDelegate = self//set delegate
       if let DCsubject = specificSubject{
           if let DCcourseCollection = DCsubject.courseCollection{
          
            if let DCinstructor = DCcourseCollection[indexPath.row].INSTRUCTOR1_NAME{//set instructor name
                cell.courseInstructor.text = DCinstructor}
            else{cell.courseInstructor.text = "TBD"}

            let checkCollection = clase.loadFavorite()
            if let DCfavorite = checkCollection{
                if DCfavorite.contains(DCcourseCollection[indexPath.row]){
                    let heartFill = UIImage(systemName: "heart.fill")
                    cell.favoriteButton.setImage(heartFill, for: .normal)
                    cell.favoriteButton.isSelected =  true
                }
            }
            cell.courseName.text = DCcourseCollection[indexPath.row].TITLE // set title name
            cell.status.text = DCcourseCollection[indexPath.row].SEATS // set seats status
           }
       }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       //header format
        return 5
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // to courseDetailViewController, when user click on a specific course-->
       //gather data before performing as well as passing data into next view control
        if segue.identifier == "courseToDetail",
            let  courseDetail = segue.destination as? courseDetalViewController{
                if let DCsubject = specificSubject{
                    if let DCcourseCollection = DCsubject.courseCollection{
                         let selectedIndexPath = tableView.indexPathForSelectedRow!
                         let selectedCourse = DCcourseCollection[selectedIndexPath.row]
                        courseDetail.CRN = selectedCourse.CRN
          
                    }
                }
        }
        
        if segue.identifier == "toComment", let commentMain = segue.destination as? Comment_Main{
           // to comment_main, when user click on comment button 
           //--> perform segue
           //--> go to comment section
            if let DCcommentOfCourse = commentForCourse{
            commentMain.commentOfCourse = DCcommentOfCourse
            }
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // perform segue when clicked on specific course
        performSegue(withIdentifier: "courseToDetail", sender: nil)
    }
    
    func comment(commentTapped:courseCell){
       //User action (comment)
       // pass the clase object of the selected comment into comment_main
        let indexpathClicked = tableView.indexPath(for: commentTapped)
        commentForCourse = specificSubject?.courseCollection![indexpathClicked!.row]
        
    }
    
    
    func favoriteACell(favoriteCell:courseCell){
       //User action(mark a course favorite)
        let indexpathClicked = tableView.indexPath(for: favoriteCell)
        let secondTab = (self.tabBarController?.viewControllers![1])! as! Favorite as Favorite
        secondTab.favoriteCollection.append((specificSubject?.courseCollection![indexpathClicked!.row])!)
        secondTab.tableView.reloadData()
        clase.saveFavorite(secondTab.favoriteCollection)
          
        
     }
   
    func unfavoriteACell(unfavoriteCell:courseCell){
       //User action(unmark a course  favorite)
        let indexpathClicked = tableView.indexPath(for: unfavoriteCell)
        let secondTab = (self.tabBarController?.viewControllers![1])! as! Favorite as Favorite
        for i in secondTab.favoriteCollection{
            if i ==  (specificSubject?.courseCollection![indexpathClicked!.row])!{
                let removeIndex = secondTab.favoriteCollection.firstIndex(of: i)
                secondTab.favoriteCollection.remove(at: removeIndex!)
                clase.saveFavorite(secondTab.favoriteCollection)
                secondTab.tableView.reloadData()
            }
        }
    }
    



}
