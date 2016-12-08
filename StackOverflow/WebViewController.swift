//
//  WebViewController.swift
//  StackOverflow
//
//  Created by Madhu on 07/12/16.
//  Copyright © 2016 com.task. All rights reserved.
//

import UIKit

protocol WebViewControllerDelegate {
    
    func didGetOAuthToken(token:String)
    func didCancelOAuth()
}

extension WebViewController: UIWebViewDelegate
{
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
       
        if let url = webView.request?.mainDocumentURL, url.absoluteString.contains(REDIRECT_URL)
        {
           
            let array = url.absoluteString.components(separatedBy: "#")
            if array.count > 1
            {
                let values = array[1].components(separatedBy: "=")
                if (values.count > 1) && values.first == ACCESS_TOKEN, let delegate = self.delegate
                {
                    if let token = values[1].components(separatedBy: "&").first
                    {
                        // remove cookies
                        self.removeCookies()
                        delegate.didGetOAuthToken(token: token)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

class WebViewController: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - local variables
    
    var delegate : WebViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func webViewController(delegate:WebViewControllerDelegate?) -> WebViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.delegate = delegate
        return vc
    }
    
    // MARK: - Helper methods
    func loadData()
    {
        let str = "https://stackexchange.com/oauth/dialog?client_id=8526&redirect_uri=https%3a%2f%2fstackexchange.com%2foauth%2flogin_success&scope=&response_type=token&state=&returnurl=%2foauth%2fdialog%3fclient_id%3d8526%26redirect_uri%3dhttps%253a%252f%252fstackexchange.com%252foauth%252flogin_success%26scope%3d%26response_type%3dtoken%26state%3d"
        
       if let url = URL(string: str)
       {
            let request = URLRequest(url: url)
            self.webView.loadRequest(request)
        }
    }
    
    func removeCookies()
    {
        
        let storage = HTTPCookieStorage.shared
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
    }
    // MARK: - Actions
    
    @IBAction func DoneOnClick(_ sender: AnyObject) {
        if let delegate = self.delegate
        {
            delegate.didCancelOAuth()
        }
        self.dismiss(animated: true, completion: nil)
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
