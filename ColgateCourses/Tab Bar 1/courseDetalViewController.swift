//
//  courseDetalViewController.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/19/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import UIKit
import SafariServices

class courseDetalViewController: UIViewController {
    var CRN: String?
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var displayKey: UILabel!
    @IBOutlet weak var meetingTime: UILabel!
    @IBOutlet weak var term: UILabel!
    @IBOutlet weak var CRNlabel: UILabel!
    @IBOutlet weak var instructor: UILabel!
    @IBOutlet weak var meetingLocation: UILabel!
    @IBOutlet weak var credits: UILabel!
    @IBOutlet weak var courseDescription: UILabel!
    @IBOutlet weak var coreArea: UILabel!
    @IBOutlet weak var AreaOfnquiry: UILabel!
    @IBOutlet weak var M: UILabel!
    @IBOutlet weak var T: UILabel!
    @IBOutlet weak var W: UILabel!
    @IBOutlet weak var R: UILabel!
    @IBOutlet weak var F: UILabel!
    
    @IBOutlet weak var detailWebView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let DCcrn = CRN{
        let testURL = URL(string: "https://api.colgate.edu/v1/courses/202001/\(DCcrn)")!
        let courseFetcher = courseController()
                backgroundImageView.layer.cornerRadius = 10
                    backgroundImageView.layer.borderWidth = 10
                    backgroundImageView.layer.borderColor = UIColor.clear.cgColor
                    backgroundImageView.layer.masksToBounds = true
        
                    backgroundImageView.layer.shadowColor = UIColor.gray.cgColor
                    backgroundImageView.layer.shadowOffset = CGSize(width: 10, height: 10)
                    backgroundImageView.layer.shadowRadius = 10.0
                    backgroundImageView.layer.shadowOpacity = 0.6
                    backgroundImageView.layer.masksToBounds = false
            backgroundImageView.layer.shadowPath = UIBezierPath(roundedRect: backgroundImageView.bounds, cornerRadius: backgroundImageView.layer.cornerRadius).cgPath
            courseFetcher.fetchCourseInfo(url: testURL){(detailCourse) in

                //print("meeting location:\(detailCourse[0].MEET1_LOCATION)")
                DispatchQueue.main.async {
                    
                    
    
                    let specificCourse = detailCourse[0]
                    //print("selected course Title is \(specificCourse.TITLE)")
                    self.courseTitle.text = specificCourse.TITLE
                    self.displayKey.text = specificCourse.DISPLAY_KEY
                    if let DCbeginTime = specificCourse.MEET1_BEGIN_TIME12AM,
                        let DCendTime = specificCourse.MEET1_END_TIME12AM{
                        self.meetingTime.text = "\(DCbeginTime) - \(DCendTime)"
                    }
                    self.term.text = specificCourse.TERM_DESC
                    self.CRNlabel.text = specificCourse.CRN
                    if let DcInsructor = specificCourse.INSTRUCTOR1_NAME{
                    self.instructor.text = DcInsructor
                    }else {self.instructor.text = "TBD"}
                    
                    self.meetingLocation.text = specificCourse.MEET1_LOCATION
                    if let DCcredits = specificCourse.CREDIT_HRS{
                        self.credits.text = String(DCcredits)
                    }
                    if let DCdescription = specificCourse.DESCRIPTION{
                    self.courseDescription.text = DCdescription.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                    }
                    
                    if let DCcoreArea = specificCourse.CORE_AREA{
                    self.coreArea.text = DCcoreArea
                    }else{self.coreArea.text = "Does not satisfy the CORE requirement"}
                    
                    if let DCareaOfInquiry = specificCourse.INQUIRY_AREA{
                    self.AreaOfnquiry.text = DCareaOfInquiry
                    }else {self.AreaOfnquiry.text = "Does not satisfy the areas of inquiry requirement"
                    }
                    if let daysOfWeek = specificCourse.MEET1_DAYS{
                        for i in daysOfWeek{
                            switch i {
                            case "M":
                                self.M.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
                            case "T":
                                self.T.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
                            case "W":
                                self.W.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
                            case "R":
                                self.R.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
                            case "F":
                                self.F.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
                            default:
                                print("no schedule found")
                            }
                        }
                    }
                }
                
            }
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if let DCcrn = CRN{
         let detailWebUrl = URL(string: "https://www.colgate.edu/academics/course-offerings#/202001/\(DCcrn)")!
        let vc = SFSafariViewController(url: detailWebUrl)
            vc.preferredBarTintColor = navigationController?.navigationBar.barTintColor
            present(vc,animated: true)
        }
    }
//    override func viewWillDisappear(_ animated: Bool){
//         UINavigationBar.appearance().barTintColor = UIColor(red: 119, green: 29, blue: 29, alpha: 1)
//        //UINavigationBar.appearance().barTintColor = .black
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
