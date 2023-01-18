//
//  GarmentsListViewController.swift
//  Garments
//
//  Created by Mahedndar Ramidi on 6/7/22.
//

import UIKit

class GarmentsListViewController: UIViewController {
    @IBOutlet private var garmentTableView: UITableView?
    var garmentDataList = [GarmentData]()
    var currentSortType: SortType = .name
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addGarmentButtonPressed))
        title = "Garments List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadGarments()
    }
    
    @objc private func addGarmentButtonPressed() {
        guard let addGarmentVC = self.storyboard?.instantiateViewController(withIdentifier: "addGarmentVC") else {
            return
        }
        addGarmentVC.modalPresentationStyle = .fullScreen
        present(addGarmentVC, animated: true, completion: nil)
    }

    @IBAction func sortSegmentControlChanged( segmentControl : UISegmentedControl) {
        currentSortType = segmentControl.selectedSegmentIndex == 0 ? .name : .creationTime
        reloadGarments()
    }
    
    func reloadGarments() {
        self.garmentDataList = CoreDataManager.shared.getAllGarments(sortedBy: currentSortType.rawValue)
        self.garmentTableView?.reloadData()
    }
}

extension GarmentsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return garmentDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "garmentCell")
        cell?.textLabel?.text = garmentDataList[indexPath.row].name
        return cell ?? UITableViewCell()
    }
    
    
}
