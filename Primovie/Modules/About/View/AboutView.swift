//
//  AboutView.swift
//  Primovie
//
//  Created by Dayton on 14/11/21.
//

import UIKit

class AboutView: BaseView {
  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.configureNavBar(withTitle: "Profile", prefersLargeTitles: true)
  }
}
