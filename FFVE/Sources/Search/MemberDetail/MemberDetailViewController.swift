//
//  ProfessionalsSearchViewController.swift
//  FFVE
//
//  Created by Margarita Blanc on 31/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit
import MapKit

final class MemberDetailViewController: UIViewController {
    
    @IBOutlet weak var memberName: UILabel!
    
    @IBOutlet weak var memberType: UILabel!
    
    @IBOutlet weak var presidentLabel: UILabel!
    
    @IBOutlet weak var coordinates: UILabel!
    
    @IBOutlet weak var adress: UILabel!
    
    @IBOutlet weak var memberMap: MKMapView!
    
    @IBOutlet weak var shareButton: UIButton!
    
    private var map: MemberMap?
    
    var viewModel: MemberDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map = MemberMap(map: memberMap)
        bind(to: viewModel)
        viewModel.viewDidAppear() 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavBar()
    }
    
    private func bind(to viewModel: MemberDetailViewModel){
        viewModel.memberNameLabelText = { [weak self] name in
            self?.memberName.text = name
        }
        
        viewModel.memberItem = { [weak self] member in
            self?.map?.update(member: member)
        }
        
        viewModel.memberTypeLabelText = { [weak self] type in
            self?.memberType.text = type
        }
        
        viewModel.presidentLabelText = { [weak self] text in
            self?.presidentLabel.text = text
        }
        
        viewModel.coordinatesLabelText = { [weak self] text in
            self?.coordinates.text = text
        }
        
        viewModel.adressLabelText = { [weak self] text in
            self?.adress.text = text
        }
    }
    
    private func setUI() {
        setNavBar()
    }
    
    private func setNavBar() {
        
        navigationItem.title = "Recherche de membre"
        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle"), landscapeImagePhone: UIImage(systemName: "info"), style: .done, target: self, action: #selector(buttonInfoTapped))
        self.navigationItem.setRightBarButton(button, animated: true)
    }
    
    @objc private func buttonInfoTapped() {
        viewModel.didPressInfoLogo()
    }
    
    @IBAction func share(_ sender: UIButton) {
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        view.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {return}
        UIGraphicsEndImageContext()
        let imagesToShare: [AnyObject] = [image]

        viewModel.didShare(objects: imagesToShare)
    }
}
