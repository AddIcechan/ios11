//
//  MainTableViewController.swift
//  iOS 11
//
//  Created by ADDICE on 2017/8/9.
//  Copyright © 2017年 ADDICE. All rights reserved.
//

import UIKit

enum Soureces: String {
    case DynamicFont = "Dynamic Font"
    case ARKit = "ARKit"
    case CoreML = "Core ML"
}

class MainTableViewController: UITableViewController {

    lazy var sources : [Soureces] = [.DynamicFont, .ARKit, .CoreML]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Demo"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change", style: .plain, target: self, action: #selector(changeItemPressed))
    }
    
    @objc func changeItemPressed() {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.orange]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        cell.textLabel?.text = sources[indexPath.row].rawValue
        return cell
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "leading") { (action, view, completionHandler) in
            completionHandler(true)
        }
        action.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "delete") { (action, view, completionHandler) in
            completionHandler(true)
        }
        action.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: sources[indexPath.row].rawValue, sender: self)
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let identifer = Soureces(rawValue: segue.identifier ?? "") else {
            return
        }
        segue.destination.title = identifer.rawValue
        switch identifer {
        case .DynamicFont:
            let vc = segue.destination as? DynamicFontController
            vc?.navigationItem.largeTitleDisplayMode = .never
            
        case .ARKit:
            break
        case .CoreML:
            break
        }
    }
    

}
