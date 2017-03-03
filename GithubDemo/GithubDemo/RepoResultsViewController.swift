//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD


protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}

// Main ViewController
class RepoResultsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, SettingsPresentingViewControllerDelegate {
    internal func didCancelSettings() {
        doSearch()
    }

    internal func didSaveSettings(settings: GithubRepoSearchSettings) {
        
    }


    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = UIColor(hue: 0.0389, saturation: 0.74, brightness: 0.93, alpha: 1.0)
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
        
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
                
            }   

            self.repos = newRepos
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repos = repos{
            return repos.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pinK = UIColor(hue: 0.9333, saturation: 0.23, brightness: 0.93, alpha: 1.0)
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! beibeiCell
        cell.backgroundColor = pinK
        
        //This two are the same thing but pass to different places. Cell is local here. github is in beibeiCell
        cell.github = repos[indexPath.row]
        let info_at_row_index = repos[indexPath.row]

        //Parse string into URL
        cell.pictureView?.setImageWith(URL(string: "\(info_at_row_index.ownerAvatarURL!)")!)
        
        cell.owner.text = ("by \(info_at_row_index.ownerHandle!)")
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destinationViewController as! UINavigationController
        let vc = navController.topViewController as! SearchSettingsViewController
        vc.delegate = self
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
