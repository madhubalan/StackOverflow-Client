//
//  HomeViewController.swift
//  StackOverflow
//
//  Created by Madhu on 05/12/16.
//  Copyright © 2016 com.task. All rights reserved.
//

import UIKit

//public protocol EnumDisplayMode {
//    var sortedBy : Int {get}
//}


extension UIAlertController
{
    class func showMsg(title : String, msg : String, controller:UIViewController)
    {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            action -> Void in
        })
        
        controller.present(alertController, animated: true)
    }

}

extension HomeViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let questionList = self.questions, let tags = questionList[collectionView.tag].tags
        {
            return tags.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
        
        if let questionList = self.questions, let tags = questionList[collectionView.tag].tags
        {
            tCell.lblTag.text = tags[indexPath.item]
        }
        
        return tCell
    }
    
    
 
}

extension HomeViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let questionList = self.questions, let tags = questionList[collectionView.tag].tags
        {
            
            if let font = UIFont.init(name: "SanFranciscoDisplay-Regular", size: 17)
            {
                let attributes : [String: AnyObject] = [NSFontAttributeName : font]
                let text = tags[indexPath.item]
                let height = CGFloat(29)
               let rect = text.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
                
                return CGSize(width:rect.size.width + 20, height: height)
            }
                
            
        }
        return CGSize(width: 0, height: 0)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 15 :5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
 
}

extension HomeViewController : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // push same controller for display Tagged string
        if let questionList = self.questions, let tags = questionList[collectionView.tag].tags
        {
            let tag = tags[indexPath.item]
            let tagViewController = HomeViewController.homeViewController()
            tagViewController.tagged = tag
            tagViewController.displayMode = .TaggedQuestions
        self.navigationController?.pushViewController(tagViewController, animated: true)

        }
        
    }
}

extension HomeViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView.tag == 0)
        {
            if let questionList = self.questions
            {
                return questionList.count
            }
 
        }
        else if(tableView.tag == 1)
        {
            if let _ = UserDefaults.standard.object(forKey: ACCESS_TOKEN) as? String
            {
                return 3
            }
            else
            {
                return 2
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView.tag == 0)
        {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as! QuestionTableViewCell
            cell.collectionView.tag = indexPath.row
            
            if let questionList = self.questions
            {
                let question = questionList[indexPath.row]
                if let title = question.title, let score = question.score, let name = question.owner?.displayName, let created = question.creationDate
                {
                    cell.lblQuestionDesc.text = title
                    cell.lblUpvoteCount.text = String(describing: score)
                    let date = Date(timeIntervalSince1970: TimeInterval(created))
                    cell.lblUserAndTime.text = "- Asked by \(name) \(date.convertLocalTimestamp())"
                    cell.collectionView.delegate = self
                    cell.collectionView.dataSource = self
                    
                    cell.layoutIfNeeded()
                    cell.collectionView.reloadData()
                    cell.constraintCollectionViewHeight.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
                }
            }
            
            return cell
        }
        else
        {
             let cell = tableView.dequeueReusableCell(withIdentifier: "MoreOptionsTableViewCell", for: indexPath) as! MoreOptionsTableViewCell
            
            var isLoggedIn = false
            if let _ = UserDefaults.standard.object(forKey: ACCESS_TOKEN) as? String
            {
                isLoggedIn = true
            }
        
            switch indexPath.row {
            case 0:
                cell.lblTitle.text = "All questions"
            case 1:
                if isLoggedIn
                {
                    cell.lblTitle.text = "Own question"
                }
                else
                {
                    cell.lblTitle.text = "Sign in"
                }
                
            case 2:
                cell.lblTitle.text = "Log out"
                
            default:
                break
            }
            
            return cell
        }
    }
}

extension HomeViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 1
        {
            var isLoggedIn = false
            if let _ = UserDefaults.standard.object(forKey: ACCESS_TOKEN) as? String
            {
                isLoggedIn = true
            }
            
            switch indexPath.row {
            case 0:
                self.displayMode = .AllQuestions
                self.sortMode = 0
                self.loadScrollview()
                self.loadQuestion()
            
            case 1:
                if isLoggedIn
                {
                    self.displayMode = .OwnQuestions
                    self.sortMode = 0
                    self.loadScrollview()
                    self.loadQuestion()
                }
                else
                {
                    UIApplication.shared.keyWindow?.rootViewController = SignInViewController.signInViewController()
                }
                
            case 2:

                let alertController = UIAlertController(title: "", message: "Do you want to logout?", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default)
                {
                    action -> Void in
                    
                    UserDefaults.standard.set(nil, forKey: ACCESS_TOKEN)
                    UIApplication.shared.keyWindow?.rootViewController = SignInViewController.signInViewController()
                })
                
                alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default)
                {
                    action -> Void in
                    
                })

                self.present(alertController, animated: true)
                
            default:
                break
            }
            self.changeMoreViewState(isOpen: false)
        }
    }
}

extension HomeViewController : UIScrollViewDelegate
{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.tag == 0
        {
           self.changeMoreViewState(isOpen: false)
        }
        
    }
}

class HomeViewController: UIViewController {
    
    
    //MARK : Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLeftBar: UIButton!
    @IBOutlet weak var viewMore: UIView!
    @IBOutlet weak var tableViewMoreOptions: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var constraintViewMoreTop: NSLayoutConstraint!
    @IBOutlet weak var lblNoQuestion: UILabel!
    
    
    //MARK : Local
    
    var questions : [Question]?
    
    enum DispalyMode : Int{
        case AllQuestions = 0
        case OwnQuestions
        case TaggedQuestions
    }
    var tagged : String?
    
    var sortMode = 0
    var scrollView : UIScrollView?
    var displayMode = DispalyMode.AllQuestions

    //MARK : lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeInterface()
        self.activityIndicator.isHidden = false
        self.loadQuestion()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    //MARK : helper methods
    
    static func homeViewController()-> HomeViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        return vc
    }
    
    func changeMoreViewState(isOpen:Bool)
    {
        self.constraintViewMoreTop.constant = isOpen ? 0 : -135
        UIView.animate(withDuration: 0.35) {
        self.view.layoutIfNeeded()
        }
    }
    func initializeInterface()
    
    {
        self.tableView.tableFooterView = UIView()
        self.tableViewMoreOptions.tableFooterView = UIView()
        self.tableViewMoreOptions.rowHeight = 44
       self.loadScrollview()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        
        if displayMode == .TaggedQuestions, let tag = self.tagged
        {
            self.title = tag
            self.navigationItem.rightBarButtonItem = nil
        }
        
    }
    
    func loadQuestion()
    {
        // send api request
        
        if self.displayMode == .AllQuestions || self.displayMode == .TaggedQuestions, let mode = AllQuestionSortType(rawValue: sortMode)
        {
            APIHandler.getAllQuestoin(sType: mode, tagged: tagged, onSuccess: { (response) in
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
                self.lblNoQuestion.isHidden = true
                self.questions = response.items
                self.tableView.reloadData()
                
            }) { (error) in
                self.activityIndicator.stopAnimating()
                UIAlertController.showMsg(title: "Oops!", msg: "Somethig went wrong... please try again", controller: self)
            }
        }
        else if let mode = OwnQuestionSortType(rawValue: sortMode)
        {
            APIHandler.getOwnQuestoin(sType: mode, onSuccess: { (response) in
                self.activityIndicator.stopAnimating()

                if let items = response.items, items.count > 0
                {
                    self.tableView.isHidden = false
                    self.lblNoQuestion.isHidden = true
                    self.questions = items
                    self.tableView.reloadData()
                }
                else
                {
                    self.tableView.isHidden = true
                    self.lblNoQuestion.isHidden = false
                    
                }
                
                
            }) { (error) in
                self.activityIndicator.stopAnimating()
                UIAlertController.showMsg(title: "Oops!", msg: "Somethig went wrong... please try again", controller: self)
            }
        }

    }
    
    func loadScrollview()
    {
        if self.displayMode != .TaggedQuestions
        {
            let width = UIScreen.main.bounds.width - 84
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: 40))
            if let sView = scrollView
            {
                sView.showsVerticalScrollIndicator = false
                sView.showsHorizontalScrollIndicator = false
                self.navigationItem.titleView = sView
                
                let allItems = (displayMode == .AllQuestions) ? AllQuestionSortType.allItems() : OwnQuestionSortType.allItems()
                var contentWidth: Int = 0
                
                for i in 0..<allItems.count
                {
                    if let font = UIFont(name:"SanFranciscoDisplay-Regular", size: 20)
                    {
                        let attributes : [String: AnyObject] = [NSFontAttributeName : font]
                        let str = allItems[i]
                        let rect = str.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
                        
                        let btn = UIButton(frame: CGRect(x: contentWidth, y: 0, width:Int(rect.size.width) + 10, height: 40))
                        btn.addTarget(self, action: #selector(self.titleButtonOnClick(sender:)), for: .touchUpInside)
                        btn.setTitleColor(UIColor.lightGray, for: .normal)
                        btn.setTitleColor(UIColor.darkGray, for: .selected)
                        contentWidth = contentWidth + Int(rect.size.width) + 20
                        sView .addSubview(btn)
                        btn.titleLabel?.font = font
                        btn.setTitle(str, for: .normal)
                        btn.tag = i
                        if (i == 0)
                        {
                            btn.isSelected = true
                        }
                    }
                }
                scrollView?.contentSize = CGSize(width: contentWidth, height: 40)
            }
        }
        
    }

    
    //MARK : Actions
    
    @IBAction func rightButton(_ sender: AnyObject) {
        
        if self.constraintViewMoreTop.constant == 0
        {
             self.changeMoreViewState(isOpen: false)
        }
        else
        {
            self.changeMoreViewState(isOpen: true)
        }
        
    }
    
    func titleButtonOnClick(sender : UIButton)
    {
        self.changeMoreViewState(isOpen: false)
        // deleselect 
        if let sView = scrollView
        {
            for view in sView.subviews
            {
                if let v = view as? UIButton
                {
                    v.isSelected = false
                }
            }
        }
        
        sender.isSelected = true
        sortMode = sender.tag
        self.loadQuestion()
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
