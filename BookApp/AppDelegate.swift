//
//  AppDelegate.swift
//  BookApp
//
//  Created by Jayaprakash Manchu on 29/09/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import Dispatch

let FreeEBooks = "https://www.googleapis.com/books/v1/volumes?filter=ebooks&q=a"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var queue : OperationQueue? // the queue to run our "ParseOperation"

    var parser : ParseOperation? // the NSOperation driving the parsing of the RSS feed

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        retrieveDataFromSource()
        return true
    }

    func retrieveDataFromSource() {
        
        let request = URLRequest(url: URL(string: FreeEBooks)!)
        let sessionTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                OperationQueue.main.addOperation({
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if (error! as NSError).code == NSURLErrorAppTransportSecurityRequiresSecureConnection {
                        // if you get error NSURLErrorAppTransportSecurityRequiresSecureConnection (-1022),
                        // then your Info.plist has not been properly configured to match the target server.
                        //
                        abort()
                    } else {
                        self.handleError(error!)
                    }
                })
            } else {
                // create the queue to run our ParseOperation
                self.queue = OperationQueue()
                
                // create an ParseOperation (NSOperation subclass) to parse the RSS feed data so that the UI is not blocked
                self.parser = ParseOperation(data: data!)
                self.parser?.errorHandler = { (parseError) in
                    DispatchQueue.main.async { [weak self] in 
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        self?.handleError(parseError)
                    }
                }
                
                self.parser?.completionBlock = { [weak self] in
                    if let booksModel = self?.parser?.booksModel {
                        // The completion block may execute on any thread.  Because operations
                        // involving the UI are about to be performed, make sure they execute on the main thread.
                        //
                        DispatchQueue.main.async { [weak self] in
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            // The root rootViewController is the only child of the navigation
                            // controller, which is the window's rootViewController.
                            //
                            if let bookViewController = (self?.window?.rootViewController as? UINavigationController)?.topViewController as? BookViewController {
                                bookViewController.bookModel = booksModel
                            }
                        }

                    }
                    self?.queue = nil
                }
                
                self.queue?.addOperation(self.parser!)
            }
        }
        
        sessionTask.resume()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func handleError(_ error: Error) {
        //error.localizedDescription
        let alert = UIAlertController(title: "Cannot Show Top Paid Apps", message: error.localizedDescription, preferredStyle: .actionSheet)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // dissmissal of alert completed
        }
        alert.addAction(OKAction)
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}















