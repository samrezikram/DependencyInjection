//
//  ViewController.swift
//  DI
//
//  Created by Samrez Ikram on 02/04/2023.
//

import UIKit
import AppUIKit
import ApiKit

extension APICaller : DataFetcable {}
class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
//    https://iosacademy.io/api/v1/courses/index.php
    
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
    view.addSubview(button)
    button.backgroundColor = .systemBlue
    button.setTitle("Tap Me", for: UIControl.State.normal)
    button.center = view.center
    button.setTitleColor(.white, for: UIControl.State.normal)
    button.addTarget(self, action: #selector(didTapButton), for:  .touchUpInside)
        
  }

  @objc private func didTapButton() {
    let vc = CoursesViewController(dataFetchable: APICaller.shared)
    present(vc, animated: true)
  }

}

