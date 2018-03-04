//
//  MemberDetailViewController.swift
//  westeros
//
//  Created by Hector Aguado on 3/3/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController, MemberListViewControllerDelegate {
  
    // MARK: - Outlets
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personAliasLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    @IBOutlet weak var backgroundSigilImage: UIImageView!
    
    // MARK: - Properties
    var model: Person
    
    // MARK: - Initialization
    init(model: Person){
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.name
    }
    // Chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = model.name
        super.viewWillAppear(animated)
        syncModelWithView()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func houseDidChange(){
        navigationController?.popViewController(animated: true)
    }
    
    
    
    func syncModelWithView() {
        personNameLabel.text = model.name
        personAliasLabel.text = model.alias
        personImage.image = model.photo
        backgroundSigilImage.image = model.house.sigil.image
    }
    func memberListViewController(_ vc: MemberListViewController, didSelectedMember member: Person) {
        self.model = member
        syncModelWithView()
    }

}

