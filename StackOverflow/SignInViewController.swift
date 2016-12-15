//
//  SignInViewController.swift
//  StackOverflow
//
//  Created by Madhu on 05/12/16.
//  Copyright © 2016 com.task. All rights reserved.
//

import UIKit

extension SignInViewController : WebViewControllerDelegate
{
    func didGetOAuthToken(token: String)
    {
        UserDefaults.standard.set(token, forKey: ACCESS_TOKEN)
        UserDefaults.standard.synchronize()
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNav") as? UINavigationController
        {
             UIApplication.shared.keyWindow?.rootViewController = vc
        }

    }
    func didCancelOAuth() {
        print("cancelled")
    }
}

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func signInViewController() -> SignInViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController")
        return vc as! SignInViewController
    }
    
    
    // MARK: - Actions
    
    @IBAction func btnSignInOnClick(_ sender: AnyObject) {
        
        let vc = WebViewController.webViewController(delegate:self)
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btnSkipOnClick(_ sender: Any) {
        
        UserDefaults.standard.set(nil, forKey: ACCESS_TOKEN)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeNav")
        UIApplication.shared.keyWindow?.rootViewController = vc
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
