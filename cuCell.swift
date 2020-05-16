//
//  cuCell.swift
//  practiceMessenger
//
//  Created by Amanda Burger on 5/13/20.
//  Copyright © 2020 Amanda Burger. All rights reserved.
//

import UIKit

class cuCell: UITableViewCell {

    
  
    @IBOutlet weak var senderProfImage: UIImageView!
    
   
    @IBOutlet weak var senderLabel: UILabel!
    
 
    @IBOutlet weak var messageLabel: UILabel!
  
   
    
    @IBOutlet weak var backView: UIView!

    
    
    @IBOutlet weak var downConst: NSLayoutConstraint!
   
    
    
    
    
    
    override func awakeFromNib() {
        downConst.isActive = true
        super.awakeFromNib()
        
    }
   
     private func setUpLabelsAndConstraints() {
       
        
    }
    
    
    
    
}
