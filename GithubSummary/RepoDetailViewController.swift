//
//  DetailViewController.swift
//  GithubSummary
//
//  Created by Matthew Jones on 15/09/09.
//  Copyright (c) 2015 mattj.co. All rights reserved.
//

import UIKit

class RepoDetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var repo: Repo? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let repo: Repo = self.repo {
            if let label = self.detailDescriptionLabel {
                label.text = repo.language
            }
            
            self.title = repo.name
        }
    }

    @IBAction func openRepoUrl(sender: UIButton) {
        if let url = NSURL(string: repo!.repoLink) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

