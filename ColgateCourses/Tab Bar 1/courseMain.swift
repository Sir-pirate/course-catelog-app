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
            
        }
        
        

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! courseCell
         

        
        cell.motherDelegate = self
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
        return 5
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {// to courseDetailViewController
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
        
        if segue.identifier == "toComment", let commentMain = segue.destination as? Comment_Main{// to comment_main
            if let DCcommentOfCourse = commentForCourse{
            commentMain.commentOfCourse = DCcommentOfCourse
            }
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "courseToDetail", sender: nil)
    }
    
    func comment(commentTapped:courseCell){// pass the clase object of the selected comment into comment_main
        let indexpathClicked = tableView.indexPath(for: commentTapped)
        commentForCourse = specificSubject?.courseCollection![indexpathClicked!.row]
        
    }
    
    
    func favoriteACell(favoriteCell:courseCell){
        let indexpathClicked = tableView.indexPath(for: favoriteCell)
        let secondTab = (self.tabBarController?.viewControllers![1])! as! Favorite as Favorite
        secondTab.favoriteCollection.append((specificSubject?.courseCollection![indexpathClicked!.row])!)
        secondTab.tableView.reloadData()
        clase.saveFavorite(secondTab.favoriteCollection)
          
        
     }
    func unfavoriteACell(unfavoriteCell:courseCell){
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
