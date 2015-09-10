//
//  MasterViewController.swift
//  GithubSummary
//
//  Created by Matthew Jones on 15/09/09.
//  Copyright (c) 2015 mattj.co. All rights reserved.
//

import UIKit

class RepoListViewController: UITableViewController {

    var repos = [Repo]()


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // retrieve repos to display and populate
        let url = NSURL(string: "https://api.github.com/users/jonesmattc/repos")
        let request: NSURLRequest = NSURLRequest(URL: url!)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse? >= nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!
        var jsonResult: [NSDictionary] = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: nil) as! [NSDictionary]
        for jsonRepo in jsonResult {
                            let name = jsonRepo.objectForKey("name") as! String
                          let numStars = jsonRepo.objectForKey("stargazers_count") as! NSNumber
                          let numFavs = jsonRepo.objectForKey("watchers_count") as! NSNumber
                        let language = jsonRepo.objectForKey("language") as? String
            let repoLink = jsonRepo.objectForKey("html_url") as! String
            let repo = Repo(name: name, numStars: numStars, numFavs: numFavs, language: language, repoLink: repoLink)
                        self.repos.append(repo)
        }
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
//            var jsonResult: [NSDictionary] = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! [NSDictionary]
//            for jsonRepo in jsonResult {
//                let name = jsonRepo.objectForKey("name") as! String
//                let numStars = jsonRepo.objectForKey("stargazers_count") as! NSNumber
//                let numFavs = jsonRepo.objectForKey("watchers_count") as! NSNumber
//                let language = jsonRepo.objectForKey("language") as? String
//                let repo = Repo(name: name, numStars: numStars, numFavs: numFavs, language: language)
//                self.repos.append(repo)
//            }
//        }
        
//        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let repo = repos[indexPath.row] as Repo
            (segue.destinationViewController as! RepoDetailViewController).repo = repo
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath) as! UITableViewCell

        let repo = repos[indexPath.row] as Repo
        cell.textLabel!.text = repo.name
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            repos.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

