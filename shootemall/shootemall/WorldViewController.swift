//
//  WorldViewController.swift
//  shootemall
//
//  Created by Tom Kastek on 22.03.18.
//  Copyright © 2018 Sonius94. All rights reserved.
//

import UIKit

class WorldViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var worldLabel: UILabel!
    
    var scenarioHandler: ScenarioHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }
    
    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func backToMenu(_ sender: Any) {
        dismissThis()
    }
    
    func dismissThis() {
        dismiss(animated: true, completion: nil)
    }
}

extension WorldViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scenarioHandler?.getAvailableScenariosCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let scenario = scenarioHandler?.getAvailableScenario(byIndex: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorldCell", for: indexPath) as! WorldTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.configure(scenario: scenario)
        
        return cell
    }
}

extension WorldViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? WorldTableViewCell, let scene = cell.scenario  {
            self.scenarioHandler?.currentScenario = scene
            dismissThis()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

