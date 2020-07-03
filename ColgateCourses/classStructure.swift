//
//  classStructure.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/19/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import Foundation
//
//  Subject.swift
//  courseCatalog
//
//  Created by Yaoqi Shou on 6/17/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import UIKit

struct subject: Decodable{
    var courseCollection:[clase]?
    var name:subjectName
    
    init(courseCollection:[clase],name:subjectName) {
        self.courseCollection = courseCollection
        self.name = name
    }
    enum subjectName: String, Codable{
        case African_American_Studies = "African American Studies"
        case African_Studies = "African Studies"
        case African_Latin_Amer_Studies = "Africana & Latin Amer Studies"
        case Anthropology = "Anthropology"
        case Arabic = "Arabic"
        case Art_and_Art_History = "Art and Art History"
        case Arts_Humanities  =  "Arts & Humanities"
        case Asian_studies = "Asian Studies"
        case Astronomy = "Astronomy"
        case Biology = "Biology"
        case Caribbean_Studies = "Caribbean Studies"
        case Chinese = "Chinese"
        case Chemistry = "Chemistry"
        case Classics = "Classics"
        case Computer_Science = "Computer Science"
        case Core_Curriculum = "Core Curriculum"
        case Economics = "Economics"
        case Educational_Studies = "Educational Studies"
        case English = "English"
        case Environmental_Biology = "Environmental Biology"
        case Environmental_Economics = "Environmental Economics"
        case Environmental_Geography = "Environmental Geography"
        case Environmental_Geology = "Environmental Geology"
        case Environmental_Studies = "Environmental Studies"
        case Extended_Study = "Extended Study"
        case Film_Media_Studies = "Film & Media Studies"
        case First_Year_Seminar = "First-Year Seminar"
        case French = "French"
        case Geography = "Geography"
        case Geology = "Geology"
        case German = "German"
        case Greek = "Greek"
        case Hebrew = "Hebrew"
        case History = "History"
        case International_Relations = "International Relations"
        case Italian = "Italian"
        case Japanese = "Japanese"
        case Jewish_Studies = "Jew Studies"
        case LGBTQ_Studies = "LGBTQ Studies"
        case Latin = "Latin"
        case Latin_American_Studies = "Latin American Studies"
        case Less_Commonly_Taught_Language = "Less Commonly Taught Languages"
        case Linguistics = "Linguistics"
        case Mathematics = "Mathematics"
        case Medieval_Rernaissance_St = "Medieval & Renaissance St"
        case Middle_East_Islamic_St = "Middle East & Islamic St"
        case Museum_Studies = "Museum Studies"
        case Music = "Music"
        case Native_American_Studies = "Native American Studies"
        case Neuroscience = "Neuroscience"
        case Peace_Conflict_Studies = "Peace & Conflict Studies"
        case Philosophy = "Philosphy"
        case Physics = "Physics"
        case Political_Science = "Political Science"
        case Psychology = "Psychology"
        case Religion = "Religion"
        case Russian_And_Eurasian_Studies = "Russian and Eurasian Studies"
        case Social_Studies = "Social Science"
        case Sociology = "Sociology"
        case Spanish = "Spanish"
        case Theater =  "Theater"
        case University_Studies =  "University Studies"
        case Woman_Studies  = "Woman Studies"
        case Writing_Rhetoric = "Writing & Rhetoriic"
    }
}

struct catelog: Decodable{
    var subjectCollection:[subject]
    
    init(subjectCollection:[subject]) {
        self.subjectCollection = subjectCollection
    }
    mutating func addSubject(newSubject:subject){
        subjectCollection.append(newSubject)
    }
    func printAllSubject(){
        for index in 0...63{
            print(self.subjectCollection[index].name)
        }
    }
    func totalNumber(){
        print(self.subjectCollection.count)
    }
}

struct URLBook: Decodable{
    var book:[URL]
    
    init(book:[URL]) {
        self.book = book
    }
    mutating func add(Url:URL){
        book.append(Url)
    }
}


struct clase:Decodable, Equatable, Encodable{
    var TERM_CODE:String
    var CRN:String
    var DISPLAY_KEY: String//"MATH 105 A",
    var TITLE:String //"Introduction to Statistics",
    var INSTRUCTOR1_NAME: String?//"Robertson A.",
    var INSTRUCTOR2_NAME: String?//null,
    var INSTRUCTOR3_NAME: String?//null,
//
    var MEET1_DAYS: String?//"MWF",
    var MEET1_BEGIN_TIME12:String?// "10:20",
    var MEET1_BEGIN_TIME12AM:String? //"10:20 AM",
    var MEET1_END_TIME12: String?//"11:10",
    var MEET1_END_TIME12AM: String? //"11:10 AM",

    var MEET2_DAYS: String?//null,
    var MEET2_BEGIN_TIME12:String?// null,
    var MEET2_BEGIN_TIME12AM:String?// null,
    var MEET2_END_TIME12: String?//null,
    var MEET2_END_TIME12AM: String?//null,

    var MEET3_DAYS:String?// null,
    var MEET3_BEGIN_TIME12:String?// null,
    var MEET3_BEGIN_TIME12AM: String?//null,
    var MEET3_END_TIME12: String?//null,
    var MEET3_END_TIME12AM: String?//null,

    var PRE_REQS: String?//"Three years of secondary school mathematics",
    var NOTES: String?//null,
    var CLASS_YEAR_RESTRICTIONS: String?//null,
    var MAJOR_RESTRICTIONS: String?//null,
    var SPECIAL_APPROVAL: String?//null,
    var CATALOG_RESTRICTIONS: String?//null,
    var STATUS: String?//"Waitlist",
    var SEATS: String?//"77/75",
    var RESERVED_SEATS: String?//null
    
    
    static func == (lhs:clase, rhs:clase) -> Bool{
        return lhs.DISPLAY_KEY == rhs.DISPLAY_KEY && lhs.CRN == rhs.CRN
    }
    
    static func loadFavorite() ->[clase]?{
        guard let codedFavorite = try?Data(contentsOf: ArchiveURL)
            else{return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<clase>.self, from: codedFavorite)
    }
    
    static func saveFavorite(_ favoriteClass:[clase]){
        let propertyListEncoder = PropertyListEncoder()
        let codedFavorite = try? propertyListEncoder.encode(favoriteClass)
        try? codedFavorite?.write(to:ArchiveURL, options: .noFileProtection)
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("favoriteClasses").appendingPathExtension("plist")

    
    enum CodingKeys: String, CodingKey{
        case TERM_CODE = "TERM_CODE"
        case CRN = "CRN"
        case DISPLAY_KEY = "DISPLAY_KEY"
        case TITLE = "TITLE"
        case INSTRUCTOR1_NAME = "INSTRUCTOR1_NAME"
        case INSTRUCTOR2_NAME = "INSTRUCTOR2_NAME"
        case INSTRUCTOR3_NAME = "INSTRUCTOR3_NAME"
//
        case MEET1_DAYS = "MEET1_DAYS"
        case MEET1_BEGIN_TIME12 = "MEET1_BEGIN_TIME12"
        case MEET1_BEGIN_TIME12AM = "MEET1_BEGIN_TIME12AM"
        case MEET1_END_TIME12 = "MEET1_END_TIME12"
        case MEET1_END_TIME12AM = "MEET1_END_TIME12AM"

        case MEET2_DAYS = "MEET2_DAYS"
        case MEET2_BEGIN_TIME12 =  "MEET2_BEGIN_TIME12"
        case MEET2_BEGIN_TIME12AM = "MEET2_BEGIN_TIME12AM"
        case MEET2_END_TIME12 = "MEET2_END_TIME12"
        case MEET2_END_TIME12AM = "MEET2_END_TIME12AM"

        case MEET3_DAYS = "MEET3_DAYS"
        case MEET3_BEGIN_TIME12 = "MEET3_BEGIN_TIME12"
        case MEET3_BEGIN_TIME12AM = "MEET3_BEGIN_TIME12AM"
        case MEET3_END_TIME12 = "MEET3_END_TIME12"
        case MEET3_END_TIME12AM = "MEET3_END_TIME12AM"

        case PRE_REQS = "PRE_REQS"
        case NOTES = "NOTES"
        case CLASS_YEAR_RESTRICTIONS = "CLASS_YEAR_RESTRICTIONS"
        case MAJOR_RESTRICTIONS = "MAJOR_RESTRICTIONS"
        case SPECIAL_APPROVAL = "SPECIAL_APPROVAL"
        case CATALOG_RESTRICTIONS = "CATALOG_RESTRICTIONS"
        case STATUS = "STATUS"
        case SEATS = "SEATS"
        case RESERVED_SEATS = "RESERVED_SEATS"

    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.TERM_CODE = try valueContainer.decode(String.self, forKey:CodingKeys.TERM_CODE)
        self.CRN  = try valueContainer.decode(String.self, forKey: CodingKeys.CRN)
        self.DISPLAY_KEY  = try valueContainer.decode(String.self, forKey: CodingKeys.DISPLAY_KEY)
        self.TITLE  = try valueContainer.decode(String.self, forKey: CodingKeys.TITLE)
        self.INSTRUCTOR1_NAME  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.INSTRUCTOR1_NAME)
        self.INSTRUCTOR2_NAME = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.INSTRUCTOR2_NAME)
        self.INSTRUCTOR3_NAME  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.INSTRUCTOR3_NAME)

        self.MEET1_DAYS  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET1_DAYS)
        self.MEET1_BEGIN_TIME12 = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET1_BEGIN_TIME12)
       self.MEET1_BEGIN_TIME12AM  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET1_BEGIN_TIME12AM)
        self.MEET1_END_TIME12  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET1_END_TIME12)
        self.MEET1_END_TIME12AM  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET1_END_TIME12AM)

        self.MEET2_DAYS  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET2_DAYS)
        self.MEET2_BEGIN_TIME12 = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET2_BEGIN_TIME12)
        self.MEET2_BEGIN_TIME12AM  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET2_BEGIN_TIME12AM)
        self.MEET2_END_TIME12  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET2_END_TIME12)
        self.MEET2_END_TIME12AM  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET2_END_TIME12AM)

        self.MEET3_DAYS  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET3_DAYS)
        self.MEET3_BEGIN_TIME12 = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET3_BEGIN_TIME12)
        self.MEET3_BEGIN_TIME12AM  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET3_BEGIN_TIME12AM)
        self.MEET3_END_TIME12  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET3_END_TIME12)
        self.MEET3_END_TIME12AM  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET3_END_TIME12AM)

        self.PRE_REQS = try valueContainer.decodeIfPresent(String.self, forKey:CodingKeys.PRE_REQS)
        self.NOTES = try valueContainer.decodeIfPresent(String.self, forKey:CodingKeys.NOTES)
        self.CLASS_YEAR_RESTRICTIONS = try valueContainer.decodeIfPresent(String.self, forKey:CodingKeys.CLASS_YEAR_RESTRICTIONS)
        self.MAJOR_RESTRICTIONS = try valueContainer.decodeIfPresent(String.self, forKey:CodingKeys.MAJOR_RESTRICTIONS)
        self.SPECIAL_APPROVAL = try valueContainer.decodeIfPresent(String.self, forKey:CodingKeys.SPECIAL_APPROVAL)
        self.CATALOG_RESTRICTIONS = try valueContainer.decodeIfPresent(String.self, forKey:CodingKeys.CATALOG_RESTRICTIONS)
        self.STATUS = try valueContainer.decodeIfPresent(String.self, forKey:CodingKeys.STATUS)
        self.SEATS = try valueContainer.decodeIfPresent(String.self, forKey:CodingKeys.SEATS)
        self.RESERVED_SEATS = try valueContainer.decodeIfPresent(String.self, forKey:CodingKeys.RESERVED_SEATS)
 
    }
    
}
func getUrlFromBook() -> URLBook{
    
    var UrlBook = URLBook(book: [])
    let url1 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ALS1&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url2 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ALS2&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url3 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ALST&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
  let url4 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ANTH&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url5 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ARAB&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url6 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ARTS&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url7 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=AHUM&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url8 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ASIA&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url9 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ASTR&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    
      let url10 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=BIOL&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url11 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ALS3&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url12 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=CHEM&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url13 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=CHIN&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url14 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=CLAS&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url15 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=COSC&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url16 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=CORE&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url17 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ECON&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url18 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=EDUC&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url19 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ENGL&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url20 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ENS1&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    
      let url21 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ENS2&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url22 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ENS3&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url23 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ENS4&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url24 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ENST&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url25 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=EXST&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url26 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=FMST&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
      let url27 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=FSEM&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url28 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=FREN&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url29 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=GEOG&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url30 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=GEOL&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    
    let url31 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=GERM&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url32 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=GREK&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url33 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=HEBR&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url34 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=HIST&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url35 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=IREL&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url36 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ITAL&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url37 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=JAPN&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    
    let url38 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=JWST&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url39 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=LGBT&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url40 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=LATN&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
        
    let url41 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=ALS4&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url42 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=LCTL&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url43 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=LING&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url44 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=MATH&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url45 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=MARS&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url46 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=MIST&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url47 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=MUSE&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url48 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=MUSI&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url49 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=NAST&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url50 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=NEUR&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    
    let url51 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=PCON&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url52 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=PHIL&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url53 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=PHYS&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url54 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=POSC&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url55 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=PSYC&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url56 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=RELG&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url57 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=REST&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url58 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=SOSC&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url59 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=SOCI&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url60 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=SPAN&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
        
    let url61 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=THEA&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url62 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=UNST&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url63 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=WMST&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    let url64 = URL(string: "https://api.colgate.edu/v1/courses/search?keyword=&termCode=202001&program[]=WRIT&coreArea=&inquiryArea=&meetTimeMorning=&meetTimeAfternoon=&meetTimeEvening=&openCoursesOnly=")!
    UrlBook.add(Url: url1)
    UrlBook.add(Url: url2)
    UrlBook.add(Url: url3)
    UrlBook.add(Url: url4)
    UrlBook.add(Url: url5)
    UrlBook.add(Url: url6)
    UrlBook.add(Url: url7)
    UrlBook.add(Url: url8)
    UrlBook.add(Url: url9)
    UrlBook.add(Url: url10)
    UrlBook.add(Url: url11)
    UrlBook.add(Url: url12)
    UrlBook.add(Url: url13)
    UrlBook.add(Url: url14)
    UrlBook.add(Url: url15)
    UrlBook.add(Url: url16)
    UrlBook.add(Url: url17)
    UrlBook.add(Url: url18)
    UrlBook.add(Url: url19)
    UrlBook.add(Url: url20)
    UrlBook.add(Url: url21)
    UrlBook.add(Url: url22)
    UrlBook.add(Url: url23)
    UrlBook.add(Url: url24)
    UrlBook.add(Url: url25)
    UrlBook.add(Url: url26)
    UrlBook.add(Url: url27)
    UrlBook.add(Url: url28)
    UrlBook.add(Url: url29)
    UrlBook.add(Url: url30)
    UrlBook.add(Url: url31)
    UrlBook.add(Url: url32)
    UrlBook.add(Url: url33)
    UrlBook.add(Url: url34)
    UrlBook.add(Url: url35)
    UrlBook.add(Url: url36)
    UrlBook.add(Url: url37)
    UrlBook.add(Url: url38)
    UrlBook.add(Url: url39)
    UrlBook.add(Url: url40)
    UrlBook.add(Url: url41)
    UrlBook.add(Url: url42)
    UrlBook.add(Url: url43)
    UrlBook.add(Url: url44)
    UrlBook.add(Url: url45)
    UrlBook.add(Url: url46)
    UrlBook.add(Url: url47)
    UrlBook.add(Url: url48)
    UrlBook.add(Url: url49)
    UrlBook.add(Url: url50)
    UrlBook.add(Url: url51)
    UrlBook.add(Url: url52)
    UrlBook.add(Url: url53)
    UrlBook.add(Url: url54)
    UrlBook.add(Url: url55)
    UrlBook.add(Url: url56)
    UrlBook.add(Url: url57)
    UrlBook.add(Url: url58)
    UrlBook.add(Url: url59)
    UrlBook.add(Url: url60)
    UrlBook.add(Url: url61)
    UrlBook.add(Url: url62)
    UrlBook.add(Url: url63)
    UrlBook.add(Url: url64)
    return UrlBook
}
func makeNewSubject (subjectIndex:Int, collectionOfCourse:[clase]) -> subject{
    switch subjectIndex{
    case 0:
        return subject(courseCollection: collectionOfCourse, name: .African_American_Studies)
    case 1:
        return subject(courseCollection: collectionOfCourse, name: .African_Studies)
    case 2:
        return subject(courseCollection: collectionOfCourse, name: .African_Latin_Amer_Studies)
    case 3:
        return subject(courseCollection: collectionOfCourse, name: .Anthropology)
    case 4:
        return subject(courseCollection: collectionOfCourse, name: .Arabic)
    case 5:
        return subject(courseCollection: collectionOfCourse, name: .Art_and_Art_History)
    case 6:
        return subject(courseCollection: collectionOfCourse, name: .Arts_Humanities)
    case 7:
        return subject(courseCollection: collectionOfCourse, name: .Asian_studies)
    case 8:
        return subject(courseCollection: collectionOfCourse, name: .Astronomy)
    case 9:
        return subject(courseCollection: collectionOfCourse, name: .Biology)
    case 10:
        return subject(courseCollection: collectionOfCourse, name: .Caribbean_Studies)
    case 11:
        return subject(courseCollection: collectionOfCourse, name: .Chemistry)
    case 12:
        return subject(courseCollection: collectionOfCourse, name: .Chinese)
    case 13:
        return subject(courseCollection: collectionOfCourse, name: .Classics)
    case 14:
        return subject(courseCollection: collectionOfCourse, name: .Computer_Science)
    case 15:
        return subject(courseCollection: collectionOfCourse, name: .Core_Curriculum)
    case 16:
        return subject(courseCollection: collectionOfCourse, name: .Economics)
    case 17:
        return subject(courseCollection: collectionOfCourse, name: .Educational_Studies)
    case 18:
        return subject(courseCollection: collectionOfCourse, name: .English)
    case 19:
        return subject(courseCollection: collectionOfCourse, name: .Environmental_Biology)
    case 20:
        return subject(courseCollection: collectionOfCourse, name: .Environmental_Economics)
    case 21:
        return subject(courseCollection: collectionOfCourse, name: .Environmental_Geography)
    case 22:
        return subject(courseCollection: collectionOfCourse, name: .Environmental_Geology)
    case 23:
        return subject(courseCollection: collectionOfCourse, name: .Environmental_Studies)
    case 24:
        return subject(courseCollection: collectionOfCourse, name: .Extended_Study)
    case 25:
        return subject(courseCollection: collectionOfCourse, name: .Film_Media_Studies)
    case 26:
        return subject(courseCollection: collectionOfCourse, name: .First_Year_Seminar)
    case 27:
        return subject(courseCollection: collectionOfCourse, name: .French)
    case 28:
        return subject(courseCollection: collectionOfCourse, name: .Geography)
    case 29:
        return subject(courseCollection: collectionOfCourse, name: .Geology)
    case 30:
        return subject(courseCollection: collectionOfCourse, name: .German)
    case 31:
        return subject(courseCollection: collectionOfCourse, name: .Greek)
    case 32:
        return subject(courseCollection: collectionOfCourse, name: .Hebrew)
    case 33:
        return subject(courseCollection: collectionOfCourse, name: .History)//
    case 34:
        return subject(courseCollection: collectionOfCourse, name: .International_Relations)
    case 35:
        return subject(courseCollection: collectionOfCourse, name: .Italian)
    case 36:
        return subject(courseCollection: collectionOfCourse, name: .Japanese)
    case 37:
        return subject(courseCollection: collectionOfCourse, name: .Jewish_Studies)
    case 38:
        return subject(courseCollection: collectionOfCourse, name: .LGBTQ_Studies)
    case 39:
        return subject(courseCollection: collectionOfCourse, name: .Latin)
    case 40:
        return subject(courseCollection: collectionOfCourse, name: .Latin_American_Studies)
    case 41:
        return subject(courseCollection: collectionOfCourse, name: .Less_Commonly_Taught_Language)
    case 42:
        return subject(courseCollection: collectionOfCourse, name: .Linguistics)
    case 43:
        return subject(courseCollection: collectionOfCourse, name: .Mathematics)
    case 44:
        return subject(courseCollection: collectionOfCourse, name: .Medieval_Rernaissance_St)
    case 45:
        return subject(courseCollection: collectionOfCourse, name: .Middle_East_Islamic_St)
    case 46:
        return subject(courseCollection: collectionOfCourse, name: .Museum_Studies)
    case 47:
        return subject(courseCollection: collectionOfCourse, name: .Music)
    case 48:
        return subject(courseCollection: collectionOfCourse, name: .Native_American_Studies)
    case 49:
        return subject(courseCollection: collectionOfCourse, name: .Neuroscience)
    case 50:
        return subject(courseCollection: collectionOfCourse, name: .Peace_Conflict_Studies)
    case 51:
        return subject(courseCollection: collectionOfCourse, name: .Philosophy)
    case 52:
        return subject(courseCollection: collectionOfCourse, name: .Physics)
    case 53:
        return subject(courseCollection: collectionOfCourse, name: .Political_Science)
    case 54:
        return subject(courseCollection: collectionOfCourse, name: .Psychology)
    case 55:
        return subject(courseCollection: collectionOfCourse, name: .Religion)
    case 56:
        return subject(courseCollection: collectionOfCourse, name: .Russian_And_Eurasian_Studies)
    case 57:
        return subject(courseCollection: collectionOfCourse, name: .Social_Studies)
    case 58:
        return subject(courseCollection: collectionOfCourse, name: .Sociology)
    case 59:
        return subject(courseCollection: collectionOfCourse, name: .Spanish)
    case 60:
        return subject(courseCollection: collectionOfCourse, name: .Theater)
    case 61:
        return subject(courseCollection: collectionOfCourse, name: .University_Studies)
    case 62:
        return subject(courseCollection: collectionOfCourse, name: .Woman_Studies)
    case 63:
        return subject(courseCollection: collectionOfCourse, name: .Writing_Rhetoric)
    default:
        fatalError("index out of subject number")
    }
}
struct detailCourse: Decodable{
    var TITLE:String?
    var DISPLAY_KEY: String?
    var MEET1_DAYS: String?
    var MEET1_BEGIN_TIME12AM: String?
    var MEET1_END_TIME12AM:String?
    var TERM_DESC: String?
    var CRN:String?
    var INSTRUCTOR1_NAME: String?
    var MEET1_LOCATION: String?
    var CREDIT_HRS: Float?
    var DESCRIPTION: String?
    var CORE_AREA: String?
    var INQUIRY_AREA: String?
    
    
    enum CodingKeys: String, CodingKey{
        case TITLE = "TITLE"
        case DISPLAY_KEY = "DISPLAY_KEY"
        case MEET1_DAYS = "MEET1_DAYS"
        case MEET1_BEGIN_TIME12AM = "MEET1_BEGIN_TIME12AM"
        case MEET1_END_TIME12AM = "MEET1_END_TIME12AM"
        case TERM_DESC = "TERM_DESC"
        case CRN = "CRN"
        case INSTRUCTOR1_NAME = "INSTRUCTOR1_NAME"
        case MEET1_LOCATION = "MEET1_LOCATION"
        case CREDIT_HRS  = "CREDIT_HRS"
        case DESCRIPTION = "DESCRIPTION"
        case CORE_AREA = "CORE_AREA"
        case INQURY_AREA = "INQUIRY_AREA"
    }
    init(from decoder: Decoder) throws {
           let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
           self.TITLE = try valueContainer.decodeIfPresent(String.self, forKey:CodingKeys.TITLE)
           self.DISPLAY_KEY  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.DISPLAY_KEY)
           self.MEET1_DAYS  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET1_DAYS)
           self.MEET1_BEGIN_TIME12AM  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET1_BEGIN_TIME12AM)
           self.MEET1_END_TIME12AM  = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET1_END_TIME12AM)
           self.TERM_DESC = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.TERM_DESC)
           self.CRN = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.CRN)
           self.CRN = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.CRN)
           self.INSTRUCTOR1_NAME = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.INSTRUCTOR1_NAME)
           self.CREDIT_HRS = try valueContainer.decodeIfPresent(Float.self, forKey: CodingKeys.CREDIT_HRS)
           self.DESCRIPTION = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.DESCRIPTION)
           self.CORE_AREA = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.CORE_AREA)
           self.INQUIRY_AREA = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.INQURY_AREA)
        self.MEET1_LOCATION = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.MEET1_LOCATION)
        
    }
    
}

struct userComment: Decodable{
    var comment:String
    var starRating:Int
    var date:String
  //  var date: Date
  //  var professor: String?
    
    init(comment:String,starRating:Int,date:String) {
        self.comment = comment
        self.starRating = starRating
        self.date = date
    }
}




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
