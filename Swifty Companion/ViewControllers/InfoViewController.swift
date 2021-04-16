//
//  InfoViewController.swift
//  Swifty Companion
//
//  Created by Михаил Фокин on 21.01.2021.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet var displayName: UILabel!
    @IBOutlet var userEmail: UILabel!
    @IBOutlet var userLogin: UILabel!
    @IBOutlet var userPhone: UILabel!
    @IBOutlet var userPoint: UILabel!
    @IBOutlet var userWallet: UILabel!
    @IBOutlet var userPoolMonth: UILabel!
    @IBOutlet var userPoolYear: UILabel!
    @IBOutlet var userLocation: UILabel!
    @IBOutlet var userCountry: UILabel!
    @IBOutlet var userCity: UILabel!
    @IBOutlet var userAddress: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = self.user else { return }
        
        displayName.text = user.displayname
        userLogin.text = user.login
        userEmail.text = user.email
        userPhone.text = user.phone
        userPoint.text = String(user.correctionPoint!)
        userWallet.text = String(user.wallet)
        userLocation.text = user.location
        userPoolMonth.text = user.poolMonth
        userPoolYear.text = user.poolYear
        userCountry.text = user.campus[0].country
        userCity.text = user.campus[0].city
        userAddress.text = user.campus[0].address
    }
}
