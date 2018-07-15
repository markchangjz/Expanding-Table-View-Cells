//
//  ViewController.swift
//  ExpandedView
//
//  Created by MarkChang on 2018/7/15.
//  Copyright © 2018年 MarkChang. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class TableViewController: UITableViewController {
    
    var tableViewData = [cellData]()
    var lastOpenedSection = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableViewData = [cellData(opened: false, title: "Title 1", sectionData: ["Cell 1-1", "Cell 1-2", "Cell 1-3"]),
                         cellData(opened: false, title: "Title 2", sectionData: ["Cell 2-1", "Cell 2-2"]),
                         cellData(opened: false, title: "Title 3", sectionData: ["Cell 3-1", "Cell 3-2", "Cell 3-3"]),
                         cellData(opened: false, title: "Title 4", sectionData: ["Cell 4-1"])]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell()
            }
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        } else {
            // Use different cell identifier if needed
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell()
            }
            cell.textLabel?.text = "      " + tableViewData[indexPath.section].sectionData[dataIndex]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            if indexPath.section != lastOpenedSection {
                tableViewData[lastOpenedSection].opened = false
                let sections = IndexSet.init(integer: lastOpenedSection)
                tableView.reloadSections(sections, with: .fade)
            }
            
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .fade)
            } else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .fade)
                
                lastOpenedSection = indexPath.section
            }
            print("Tapped at \(tableViewData[indexPath.section].title)")
        } else {
            print("Tapped at \(tableViewData[indexPath.section].sectionData[indexPath.row - 1])")
        }
    }
}

