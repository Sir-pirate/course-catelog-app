//
//  Comment.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/27/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import UIKit
import FirebaseFirestore
//import FirebaseFirestore
class Comment_Main: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    var starRating: Int?
    var commentOfCourse:clase?
    var commentCollection: [userComment]?
    var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var subviewComment: UITextView!
    @IBOutlet weak var totalStars: UILabel!
 
    @IBOutlet var starCollection: [UIButton]!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func starTapped(_ sender: UIButton) {
        let starFill = UIImage(systemName: "star.fill")
        let starNotFill = UIImage(systemName: "star")
            for button in starCollection{
                if button.tag <= sender.tag {
                    button.setImage(starFill, for: .normal)
                }else{
                    button.setImage(starNotFill, for: .normal)
                }
            }
        print(sender.isSelected)
        starRating = sender.tag
        
        //print(starRating)
        //print("comment in \(commentCollection)")
    }
    

    
    
    @IBOutlet weak var textFieldBackground: UIImageView!
    

//////////////////////////////////////////////////TableViewConfiguration////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let DCcommentCollection = commentCollection{
            return DCcommentCollection.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! Comment
        if let DCcommentCollection = commentCollection{
            if DCcommentCollection[indexPath.row].starRating != 100{
                cell.score.text = String(DCcommentCollection[indexPath.row].starRating)}
            else{
               cell.score.text = ""
            }
                cell.commentTextLabel.text = DCcommentCollection[indexPath.row].comment
            cell.commentDate.text = DCcommentCollection[indexPath.row].date
        }else{
            
        }
                    
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
/////////////////////////////////////////////////Write Comment Configuration///////////////////////////////////////////////////
    @IBOutlet var blurView: UIVisualEffectView!
    
    @IBOutlet var popUpView: UIView!
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {// when user is done  writing the review
        animateOut(desiredView: popUpView)
        animateOut(desiredView: blurView)
        
        
        if sender == doneButton{
        //  create data for firebase
        let newComment = subviewComment.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let newStarRating = starRating
        let newCommentOfCourse  = commentOfCourse!.DISPLAY_KEY
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let timeString = formatter.string(from: today)
        
        //uplooad to fiirerbase
         let db = Firestore.firestore()
        print("new comment is : \(newComment)")
        db.collection(newCommentOfCourse).addDocument(data: ["comment": newComment, "starRating": newStarRating ?? 100, "date":timeString]) { (error) in
                if error != nil{
                    print("unable to save comment")
                }
            }
        reloadAfterDoneTapped()
        }////////////////////////////////////////////////reload data here////////////////////////////////////////////////////////////
        subviewComment.text = ""
    }
    
    func reloadAfterDoneTapped(){
   
        let db = Firestore.firestore()
        db.collection(commentOfCourse!.DISPLAY_KEY).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    let myComments:[userComment] = try! querySnapshot!.decoded()
                    DispatchQueue.main.async {
                        

                        self.commentCollection = myComments.sorted {
                                                   $0.date > $1.date
                                               }
                        self.commentTableView.reloadData()
                        
                    }
                }
        }
        totalStars.text = String(round(calculate(collection: commentCollection!)*100)/100)
    }
    
    @IBAction func commentButtonTapped(_ sender: Any) {
        animateIn(desiredView: blurView)
        animateIn(desiredView: popUpView)
        preSetStarImage()
        
    }
    func animateIn(desiredView:UIView){
        let backgroundView = self.view!
        //attach the desiredView to the screen
        
        backgroundView.addSubview(desiredView)
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center

        //animate the subview
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        })
    }
    
    func animateOut(desiredView:UIView){
        UIView.animate(withDuration: 0.3, animations:  {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
            
        },completion: {_ in
             desiredView.removeFromSuperview()
          }
        )
    }

    @IBOutlet weak var commentTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.separatorStyle = .none
        //print(commentOfCourse?.DISPLAY_KEY)
        blurView.bounds = self.view.bounds
        popUpView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.8, height: self.view.bounds.height * 0.28)
        
        // Do any additional setup after loading the view.
            textFieldBackground.layer.cornerRadius = 5
            textFieldBackground.layer.borderWidth = 0
            textFieldBackground.layer.borderColor = UIColor.clear.cgColor
            textFieldBackground.layer.masksToBounds = true
        
            textFieldBackground.layer.shadowColor = UIColor.gray.cgColor
            textFieldBackground.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            textFieldBackground.layer.shadowRadius = 6.0
            textFieldBackground.layer.shadowOpacity = 0.6
            textFieldBackground.layer.masksToBounds = false
        

//        textFieldBackground.layer.shadowPath = UIBezierPath(roundedRect: self.view.bounds, cornerRadius: self.view.layer.cornerRadius).cgPath
            popUpView.layer.cornerRadius = 5
            popUpView.layer.borderWidth = 0
            popUpView.layer.borderColor = UIColor.clear.cgColor
            popUpView.layer.masksToBounds = true
        
            popUpView.layer.shadowColor = UIColor.gray.cgColor
            popUpView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            popUpView.layer.shadowRadius = 6.0
            popUpView.layer.shadowOpacity = 0.6
            popUpView.layer.masksToBounds = false
        //configure the done button above the key board
         self.subviewComment.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        //  configure the disable Done button
        subviewComment.delegate = self
        doneButton.isEnabled = false
        doneButton.alpha = 0.5
        
        
        
        

    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
            doneButton.isEnabled = true
            doneButton.alpha = 1
        }else{
            doneButton.isEnabled = false
            doneButton.alpha = 0.5
            
        }
     }
    
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    override func loadView() {
        super.loadView()
    
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
        commentTableView.backgroundView = activityIndicatorView
    }
    
    func calculate(collection:[userComment])  -> Double{
        var x = 0.0
        var y = 0.0
        for singleComment in collection{
            if singleComment.starRating != 100{
                x = x + Double(singleComment.starRating)
                y = y + 1
            }
            
        }
        return Double(x/y)
    }
    
    override func viewWillAppear(_ animated: Bool){
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.estimatedRowHeight = 600
         activityIndicatorView.startAnimating()
        let db = Firestore.firestore()
        db.collection(commentOfCourse!.DISPLAY_KEY).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    let myComments:[userComment] = try! querySnapshot!.decoded()
                    DispatchQueue.main.async {
                        self.commentCollection = myComments.sorted {
                            $0.date > $1.date
                        }
                        self.commentTableView.reloadData()
                        self.activityIndicatorView.stopAnimating()
                        if self.checkScoreValid(collection: myComments){
                            self.totalStars.text = String(round(self.calculate(collection: myComments)*100)/100)
                        }else{
                            self.totalStars.text = ""
                        }
                    }
                }
        }
    }
    
    func preSetStarImage(){
        for button in starCollection{
            let starImage = UIImage(systemName: "star")
            button.setImage(starImage, for: .normal)
        }
        
    }
    
    func checkScoreValid(collection:[userComment]) -> Bool{
        if collection.count == 0{
            return false
        }else{
            for i in collection{
                if i.starRating != 100{
                    return true
                }
            }
        }
        return false
       
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.3,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


