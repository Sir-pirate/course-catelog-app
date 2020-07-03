//
//  Favorite.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/26/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import UIKit

class Favorite: UITableViewController{
   

    var commentForCourse:clase?
    var favoriteCollection:[clase] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        //print(favoriteCollection.count)
      
       // print(favoriteCollection.count)
        if let DCfavoriteCollection = clase.loadFavorite(){
              favoriteCollection =  DCfavoriteCollection
        }
        
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoriteCollection.count
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favoriteCollection.remove(at: indexPath.row)
            clase.saveFavorite(favoriteCollection)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func unFavoriteCell(unfavoritecell:FavoriteCell){
        let selectedIndexPath = tableView.indexPath(for:unfavoritecell)
        favoriteCollection.remove(at: selectedIndexPath!.row)
        clase.saveFavorite(favoriteCollection)
        tableView.deleteRows(at: [selectedIndexPath!], with: .fade)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favoriteToDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteToDetail",  let  courseDetail = segue.destination as? courseDetalViewController{
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            let selectedCourse = favoriteCollection[selectedIndexPath.row]
             courseDetail.CRN = selectedCourse.CRN
            
        }
        if segue.identifier  == "favoriteToComment", let commentDetail = segue.destination as? Comment_Main{
            if let DCcommentOfCourse = commentForCourse{
                commentDetail.commentOfCourse = DCcommentOfCourse
            }
        }
    }
    func comment(commentTapped:FavoriteCell){
        let indexpathClicked = tableView.indexPath(for: commentTapped)
        commentForCourse = favoriteCollection[indexpathClicked!.row]
        
        
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)  as! FavoriteCell
     cell.fatherDelegate = self
        // Configure the cell...
        cell.status.text = favoriteCollection[indexPath.row].SEATS
            cell.courseTitle.text = favoriteCollection[indexPath.row].TITLE
            cell.instructorName.text = favoriteCollection[indexPath.row].INSTRUCTOR1_NAME
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
