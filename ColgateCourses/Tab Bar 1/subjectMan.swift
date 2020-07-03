//
//  CollectionViewControlleer.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/18/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
import FirebaseFirestore

class CollectionViewControlleer: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var subjectCollection:[subject] = []
    var subjectString:[String] = ["African American Studies","African Studies","Africana & Latin Amer Studies","Anthropology","Arabic","Art and Art History","Arts & Humanities","Asian Studies","Astronomy","Biology","Caribbean Studies","Chemistry","Chinese","Classics","Computer Science","Core Curriculum","Economics","Educational Studies","English","Environmental Biology","Environmental Economics","Environmental Geography","Environmental Geology","Environmental Studies","Extended Studies","Film & Media Studies","First-Year Seminar","French","Geography","Geology","German","Greek","Hebrew","History","International Relations", "Italian","Japanese", "Jewish Studies","LGBTQ Studies","Latin","Latin American Studies","Less Commonly Taught Languages","Linguistics","Mathematics","Medieval & Renaissance St","Middle East & Islamic St","Museum Studies","Music","Native American Studies","Neuroscience","Peace & Conflict Studies","Philosphy","Physics","Political Science","Psychology","Religion","Russian and Eurasian Studies","Social Science","Sociology","Spanish", "Theater","University Studies", "Woman's Studies","Writing & Rhetoric"]
    override func viewDidLoad() {
       let boss = subjectController()
        

    for index in 0...63{
        boss.fetchClassInfo(index: index){(clase) in
            DispatchQueue.main.async {
                let newSubject = makeNewSubject(subjectIndex: index, collectionOfCourse: clase)
                self.subjectCollection.append(newSubject)
            }
        }
    }
    let db = Firestore.firestore()
        let currentDateTime = Date()
        
        db.collection("Time Test").addDocument(data: ["comment": "This is setting date testng", "starRating": 5,  "time": currentDateTime]) { (error) in
            if error != nil{
                print("unable to save comment")
                }
            }
    


        super.viewDidLoad()

    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:   UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let numberofItem: CGFloat = 3

        let collectionViewWidth = self.collectionView.bounds.width

        let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing

        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left

        let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)

        

        return CGSize(width: width, height: width)
    }


//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subjectCell", for: indexPath) as! subjectCell
//        let boss = subjectController()
//        boss.fetchClassInfo(index: indexPath.row){(clase) in
//            DispatchQueue.main.async {
//                let newSubject = makeNewSubject(subjectIndex: indexPath.row, collectionOfCourse: clase)
//                cell.xxxx.text = newSubject.name.rawValue
//            }
//        }
//        return cell
//    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subjectCell", for: indexPath) as! subjectCell
        cell.xxxx.text = subjectString[indexPath.row]
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
           backItem.title = "back"
           navigationItem.backBarButtonItem = backItem
        if segue.identifier ==  "subjectToCourse",
            let subjectDetailController = segue.destination as? courseMain{
                let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first
                subjectCollection.sort{$0.name.rawValue < $1.name.rawValue}//sort 64 subjects
                let selectedSubject  = subjectCollection[selectedIndexPath!.row]//locate selected subject
                subjectDetailController.specificSubject = selectedSubject// pass the subject into next TableView
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "subjectToCourse", sender: nil)
    }
    override func  viewWillAppear(_ animated: Bool) {
        
 
    
    
}

}



