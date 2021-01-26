//
//  TermsOfServiceView.swift
//  projectX
//
//  Created by Gurpreet Dhillon on 1/25/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//



import UIKit
import Foundation

class TermsOfServiceView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    let Necto: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22,weight: .heavy)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.text = "Necto Terms of Service"
        return label
    }()
    let effectiveDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.text = "Effective: January 24, 2021"
        return label
    }()
    
    
    
    
    
    
    /// Create sub-title (16 font, .bold) global call
    /// Create sub-text (14 font, .medium) global call
    
    
    let endUser: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.text = "END USER LICENSE AGREEMENT"
        return label
    }()
    let Intro: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Necto is licensed to You (End-User) by Project Necto, located at, UC Santa Cruz, California, United States (hereinafter: Licensor), for use only under the terms of this License Agreement. By downloading the Application from the Apple AppStore, and any update thereto (as permitted by this License Agreement), You indicate that You agree to be bound by all of the terms and conditions of this License Agreement, and that You accept this License Agreement. The parties of this License Agreement acknowledge that Apple is not a Party to this License Agreement and is not bound by any provisions or obligations with regard to the Application, such as warranty, liability, maintenance and support thereof. Necto, not Apple, is solely responsible for the licensed Application and the content thereof. This License Agreement may not provide for usage rules for the Application that are in conflict with the latest App Store Terms of Service. Necto acknowledges that it had the opportunity to review said terms and this License Agreement is not conflicting with them. All rights not expressly granted to You are reserved."
        return label
    }()
    let No1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "1. THE APPLICATION"
        return label
    }()
    let No1p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Necto (hereinafter: Application) is a piece of software created as an informative news source by college students for college students - and customized for Apple mobile devices. It is used as a discussion platform among college students who can earn real-life store discounts and accomplish missions posted by other users or potential recruiters. The Application is not tailored to comply with industry-specific regulations (Health Insurance Portability and Accountability Act (HIPAA), Federal Information Security Management Act (FISMA), etc.), so if your interactions would be subjected to such laws, you may not use this Application. You may not use the Application in a way that would violate the Gramm-Leach-Bliley Act (GLBA)."
        return label
    }()
    let No2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2. SCOPE OF LICENSE"
        return label
    }()
    let No2p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.1  You are given a non-transferable, non-exclusive, non-sublicensable license to install and use the Licensed Application on any Apple-branded Products that You (End-User) own or control and as permitted by the Usage Rules set forth in this section and the App Store Terms of Service, with the exception that such licensed Application may be accessed and used by other accounts associated with You (End-User, The Purchaser) via Family Sharing or volume purchasing."
        return label
    }()
    let No2p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.2  This license will also govern any updates of the Application provided by Licensor that replace, repair, and/or supplement the first Application, unless a separate license is provided for such update in which case the terms of that new license will govern."
        return label
    }()
    let No2p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.3  You may not share or make the Application available to third parties (unless to the degree allowed by the Apple Terms and Conditions, and with Necto's prior written consent), sell, rent, lend, lease or otherwise redistribute the Application."
        return label
    }()
    let No2p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.4  You may not reverse engineer, translate, disassemble, integrate, decompile, integrate, remove, modify, combine, create derivative works or updates of, adapt, or attempt to derive the source code of the Application, or any part thereof (except with Necto's prior written consent)."
        return label
    }()
    let No2p5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.5  You may not copy (excluding when expressly authorized by this license and the Usage Rules) or alter the Application or portions thereof. You may create and store copies only on devices that You own or control for backup keeping under the terms of this license, the App Store Terms of Service, and any other terms and conditions that apply to the device or software used. You may not remove any intellectual property notices. You acknowledge that no unauthorized third parties may gain access to these copies at any time."
        return label
    }()
    let No2p6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.6  Violations of the obligations mentioned above, as well as the attempt of such infringement, may be subject to prosecution and damages."
        return label
    }()
    let No2p7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.7  Licensor reserves the right to modify the terms and conditions of licensing."
        return label
    }()
    let No2p8: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.8  Nothing in this license should be interpreted to restrict third-party terms. When using the Application, You must ensure that You comply with applicable third-party terms and conditions."
        return label
    }()
    let No3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "3. TECHNICAL REQUIREMENTS"
        return label
    }()
    let No3p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "3.1  The Application requires a firmware version iOS 8.0 or higher. Licensor recommends using the latest version of the firmware."
        return label
    }()
    let No3p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "3.2  Licensor attempts to keep the Application updated so that it complies with modified/new versions of the firmware and new hardware. You are not granted rights to claim such an update."
        return label
    }()
    let No3p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "3.3  You acknowledge that it is Your responsibility to confirm and determine that the app end-user device on which You intend to use the Application satisfies the technical  specifications mentioned above."
        return label
    }()
    let No3p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "3.4  Licensor reserves the right to modify the technical specifications as it sees appropriate at any time."
        return label
    }()
    let No4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "4. MAINTENANCE AND SUPPORT"
        return label
    }()
    let No4p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "4.1  The Licensor is solely responsible for providing any maintenance and support services for this licensed Application. You can reach the Licensor at the email address listed in the App Store Overview for this licensed Application."
        return label
    }()
    let No4p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "4.2  Necto and the End-User acknowledge that Apple has no obligation whatsoever to furnish any maintenance and support services with respect to the licensed Application."
        return label
    }()
    let No5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "5. USER GENERATED CONTRIBUTIONS"
        return label
    }()
    let No5p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "The Application may invite you to chat, contribute to, or participate in blogs, message boards, online forums, and other functionality, and may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or in the Application, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, 'Contributions'). Contributions may be viewable by other users of the Application and through third-party websites or applications. As such, any Contributions you transmit may be treated as non-confidential and non-proprietary. When you create or make available any Contributions, you thereby represent and warrant that:"
        return label
    }()
    let No5p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = "1. The creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your Contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party."
        return label
    }()
    let No5p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p8: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p9: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p10: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p11: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p12: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p13: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p14: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p15: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No5p16: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    
    
    
    let No6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "6. CONTRIBUTION LICENSE"
        return label
    }()
    let No6p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No6p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No6p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No6p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    
    
    
    let No7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "7. LIABILITY"
        return label
    }()
    let No7p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No7p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    
    
    
    
    
    
    let No8: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "8. WARRANTY"
        return label
    }()
    let No8p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No8p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No8p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No8p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No8p5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No8p6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    
    
    
    // Needs padding
    let No9: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "9. PRODUCT CLAIMS"
        return label
    }()
    let No9p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No9p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No9p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No9p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    
    
    
    
    let No10: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "10. LEGAL COMPLIANCE"
        return label
    }()
    let No10p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    
    
    let No11: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "11. CONTACT INFORMATION"
        return label
    }()
    let No11p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    
    
    
    
    let No12: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "12. TERMINATION"
        return label
    }()
    let No12p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    
    
    let No13: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "13. THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY"
        return label
    }()
    let No13p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No13p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    
    
    let No14: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "14. INTELLECTUAL PROPERTY RIGHTS"
        return label
    }()
    let No14p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    
    
    let No15: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "15. APPLICABLE LAW"
        return label
    }()
    let No15p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    
    
    let No16: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "16. MISCELLANEOUS"
        return label
    }()
    let No16p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    let No16p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0;
        label.text = ""
        return label
    }()
    
    
    
    
    
    
    private func setupViews(){
        self.backgroundColor = .white
        self.addSubview(cancelButton)
        self.addSubview(Necto)
        self.addSubview(effectiveDate)
        self.addSubview(endUser)
        self.addSubview(Intro)
        self.addSubview(No1)
        self.addSubview(No1p1)
        self.addSubview(No2)
        self.addSubview(No2p1)
        self.addSubview(No2p2)
        self.addSubview(No2p3)
        self.addSubview(No2p4)
        self.addSubview(No2p5)
        self.addSubview(No2p6)
        self.addSubview(No2p7)
        self.addSubview(No2p8)
        self.addSubview(No3)
        self.addSubview(No3p1)
        self.addSubview(No3p2)
        self.addSubview(No3p3)
        self.addSubview(No3p4)
        cancelButton.addAnchors(top: self.safeAreaLayoutGuide.topAnchor,
                                leading: nil,
                                bottom: nil,
                                trailing: self.safeAreaLayoutGuide.trailingAnchor,
                                padding: .init(top: 10, left: 0, bottom: 0, right: 10))
        Necto.addAnchors(top: cancelButton.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 10, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        effectiveDate.addAnchors(top: Necto.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        endUser.addAnchors(top: effectiveDate.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 20, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
       Intro.addAnchors(top: endUser.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1.addAnchors(top: Intro.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 15, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p1.addAnchors(top: No1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2.addAnchors(top: No1p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 15, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2p1.addAnchors(top: No2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2p2.addAnchors(top: No2p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        No2p3.addAnchors(top: No2p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        No2p4.addAnchors(top: No2p3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        No2p5.addAnchors(top: No2p4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        No2p6.addAnchors(top: No2p5.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        No2p7.addAnchors(top: No2p6.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2p8.addAnchors(top: No2p7.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3.addAnchors(top: No2p8.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 15, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p1.addAnchors(top: No3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p2.addAnchors(top: No3p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p3.addAnchors(top: No3p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p4.addAnchors(top: No3p3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: self.bottomAnchor,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
    
    }
    
}
