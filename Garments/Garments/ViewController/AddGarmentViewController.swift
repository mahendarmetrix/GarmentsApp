//
//  AddGarmentViewController.swift
//  Garments
//
//  Created by Mahedndar Ramidi on 6/7/22.
//

import UIKit

class AddGarmentViewController: UIViewController {
    @IBOutlet private var garmentNameTextField: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveGarmentButtonPressed))
        title = "Add a Garment"
    }
    

    @objc private func saveGarmentButtonPressed() {
        
        guard let garmentName = garmentNameTextField?.text, garmentName.count > 0 else {
            showError()
            return
        }
        let garmetData = GarmentData(name: garmentName, creationTime: Date())
        CoreDataManager.shared.saveGarmentData(garmetData)
        dismiss(animated: true, completion: nil)
    }
    
    func showError() {
        let alert = UIAlertController(title: "Empty Garment Name", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {[weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true)
    }
    

}
