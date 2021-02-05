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
    
    /// Customize Fonts/Types/Spacing
    
    let title:CGFloat = 22
    let titleType:UIFont.Weight = .heavy
    
    let date:CGFloat = 14
    let dateType:UIFont.Weight = .heavy
    
    let headerFont:CGFloat = 16
    let headerType:UIFont.Weight = .bold
    
    let paragraphFont:CGFloat = 12
    let paragraphType:UIFont.Weight = .medium
    
    let bottomNoteFont:CGFloat = 12
    let bottomNoteType:UIFont.Weight = .heavy
    
    let headerSpacing:CGFloat = 15
    let paragraphSpacing:CGFloat = 7
    
    
    /// For section 5 and 9 only
    
    let indent:CGFloat = 7
    
    

    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    lazy var Necto: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: title,weight: titleType)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.text = "Necto Terms of Service"
        return label
    }()
    lazy var effectiveDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: date, weight: dateType)
        label.tintColor = UIColor.black
        label.textAlignment = .center
        label.text = "Effective: January 24, 2021"
        return label
    }()
    lazy var endUser: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont,weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.text = "END USER LICENSE AGREEMENT"
        return label
    }()
    lazy var Intro: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "This is licensed to You (End-User) by Necto (hereinafter: Licensor), for use only under the terms of this License Agreement. By downloading the Application from the Apple AppStore, and any update thereto (as permitted by this License Agreement), You indicate that You agree to be bound by all of the terms and conditions of this License Agreement, and that You accept this License Agreement. The parties of this License Agreement acknowledge that Apple is not a Party to this License Agreement and is not bound by any provisions or obligations with regard to the Application, such as warranty, liability, maintenance and support thereof. Necto, not Apple, is solely responsible for the licensed Application and the content thereof. This License Agreement may not provide for usage rules for the Application that are in conflict with the latest App Store Terms of Service. Necto acknowledges that it had the opportunity to review said terms and this License Agreement is not conflicting with them. All rights not expressly granted to You are reserved."
        return label
    }()
    
    lazy var No1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "1. THE APPLICATION"
        return label
    }()
    lazy var No1p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Necto (hereinafter: Application) is a piece of software created as an informative news source by college students for college students - and customized for Apple mobile devices. It is used as a discussion platform among college students who can earn real-life store discounts and accomplish missions posted by other users or potential recruiters. The Application is not tailored to comply with industry-specific regulations (Health Insurance Portability and Accountability Act (HIPAA), Federal Information Security Management Act (FISMA), etc.), so if your interactions would be subjected to such laws, you may not use this Application. You may not use the Application in a way that would violate the Gramm-Leach-Bliley Act (GLBA)."
        return label
    }()
    
    lazy var No2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2. SCOPE OF LICENSE"
        return label
    }()
    lazy var No2p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.1  You are given a non-transferable, non-exclusive, non-sublicensable license to install and use the Licensed Application on any Apple-branded Products that You (End-User) own or control and as permitted by the Usage Rules set forth in this section and the App Store Terms of Service, with the exception that such licensed Application may be accessed and used by other accounts associated with You (End-User, The Purchaser) via Family Sharing or volume purchasing."
        return label
    }()
    lazy var No2p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.2  This license will also govern any updates of the Application provided by Licensor that replace, repair, and/or supplement the first Application, unless a separate license is provided for such update in which case the terms of that new license will govern."
        return label
    }()
    lazy var No2p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.3  You may not share or make the Application available to third parties (unless to the degree allowed by the Apple Terms and Conditions, and with Necto's prior written consent), sell, rent, lend, lease or otherwise redistribute the Application."
        return label
    }()
    lazy var No2p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.4  You may not reverse engineer, translate, disassemble, integrate, decompile, integrate, remove, modify, combine, create derivative works or updates of, adapt, or attempt to derive the source code of the Application, or any part thereof (except with Necto's prior written consent)."
        return label
    }()
    lazy var No2p5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.5  You may not copy (excluding when expressly authorized by this license and the Usage Rules) or alter the Application or portions thereof. You may create and store copies only on devices that You own or control for backup keeping under the terms of this license, the App Store Terms of Service, and any other terms and conditions that apply to the device or software used. You may not remove any intellectual property notices. You acknowledge that no unauthorized third parties may gain access to these copies at any time."
        return label
    }()
    lazy var No2p6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.6  Violations of the obligations mentioned above, as well as the attempt of such infringement, may be subject to prosecution and damages."
        return label
    }()
    lazy var No2p7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.7  Licensor reserves the right to modify the terms and conditions of licensing."
        return label
    }()
    lazy var No2p8: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2.8  Nothing in this license should be interpreted to restrict third-party terms. When using the Application, You must ensure that You comply with applicable third-party terms and conditions."
        return label
    }()
    
    lazy var No3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "3. TECHNICAL REQUIREMENTS"
        return label
    }()
    lazy var No3p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "3.1  The Application requires a firmware version iOS 8.0 or higher. Licensor recommends using the latest version of the firmware."
        return label
    }()
    lazy var No3p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "3.2  Licensor attempts to keep the Application updated so that it complies with modified/new versions of the firmware and new hardware. You are not granted rights to claim such an update."
        return label
    }()
    lazy var No3p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "3.3  You acknowledge that it is Your responsibility to confirm and determine that the app end-user device on which You intend to use the Application satisfies the technical  specifications mentioned above."
        return label
    }()
    lazy var No3p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "3.4  Licensor reserves the right to modify the technical specifications as it sees appropriate at any time."
        return label
    }()
    
    lazy var No4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "4. MAINTENANCE AND SUPPORT"
        return label
    }()
    lazy var No4p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "4.1  The Licensor is solely responsible for providing any maintenance and support services for this licensed Application. You can reach the Licensor at the email address listed in the App Store Overview for this licensed Application."
        return label
    }()
    lazy var No4p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "4.2  Necto and the End-User acknowledge that Apple has no obligation whatsoever to furnish any maintenance and support services with respect to the licensed Application."
        return label
    }()
    
    lazy var No5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "5. USER GENERATED CONTRIBUTIONS"
        return label
    }()
    lazy var No5p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "The Application may invite you to chat, contribute to, or participate in blogs, message boards, online forums, and other functionality, and may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or in the Application, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, 'Contributions'). Contributions may be viewable by other users of the Application and through third-party websites or applications. As such, any Contributions you transmit may be treated as non-confidential and non-proprietary. When you create or make available any Contributions, you thereby represent and warrant that:"
        return label
    }()
    lazy var No5p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "1. The creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your Contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party."
        return label
    }()
    lazy var No5p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2. You are the creator and owner of or have the necessary licenses, rights, consents, releases, and permissions to use and to authorize us, the Application, and other users of the Application to use your Contributions in any manner contemplated by the Application and these Terms of Use."
        return label
    }()
    lazy var No5p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "3. You have the written consent, release, and/or permission of each and every identifiable individual person in your Contributions to use the name or likeness or each and every such identifiable individual person to enable inclusion and use of your Contributions in any manner contemplated by the Application and these Terms of Use."
        return label
    }()
    lazy var No5p5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "4. Your Contributions are not false, inaccurate, or misleading."
        return label
    }()
    lazy var No5p6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "5. Your Contributions are not unsolicited or unauthorized advertising, promotional materials, pyramid schemes, chain letters, spam, mass mailings, or other forms of solicitation."
        return label
    }()
    lazy var No5p7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "6. Your Contributions are not obscene, lewd, lascivious, filthy, violent, harassing, libelous, slanderous, or otherwise objectionable (as determined by us)."
        return label
    }()
    lazy var No5p8: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "7. Your Contributions do not ridicule, mock, disparage, intimidate, or abuse anyone."
        return label
    }()
    lazy var No5p9: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "8. Your Contributions are not used to harass or threaten (in the legal sense of those terms) any other person and to promote violence against a specific person or class of people."
        return label
    }()
    lazy var No5p10: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "9. Your Contributions do not violate any applicable law, regulation, or rule."
        return label
    }()
    lazy var No5p11: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "10. Your Contributions do not violate the privacy or publicity rights of any third party."
        return label
    }()
    lazy var No5p12: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "11. Your Contributions do not contain any material that solicits personal information from anyone under the age of 18 or exploits people under the age of 18 in a sexual or violent manner."
        return label
    }()
    lazy var No5p13: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "12. Your Contributions do not violate any applicable law concerning child pornography, or otherwise intended to protect the health or well-being of minors."
        return label
    }()
    lazy var No5p14: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "13. Your Contributions do not include any offensive comments that are connected to race, national origin, gender, sexual preference, or physical handicap."
        return label
    }()
    lazy var No5p15: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "14. Your Contributions do not otherwise violate, or link to material that violates, any provision of these Terms of Use, or any applicable law or regulation."
        return label
    }()
    lazy var No5p16: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Any use of the Application in violation of the foregoing violates these Terms of Use and may result in, among other things, termination or suspension of your rights to use the Application."
        return label
    }()
    
    lazy var No6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "6. CONTRIBUTION LICENSE"
        return label
    }()
    lazy var No6p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "By posting your Contributions to any part of the Application or making Contributions accessible to the Application by linking your account from the Application to any of your social networking accounts, you automatically grant, and you represent and warrant that you have the right to grant, to us an unrestricted, unlimited, irrevocable, perpetual, non-exclusive, transferable, royalty-free, fully-paid, worldwide right, and license to host, use copy, reproduce, disclose, sell, resell, publish, broad cast, retitle, archive, store, cache, publicly display, reformat, translate, transmit, excerpt (in whole or in part), and distribute such Contributions (including, without limitation, your image and voice) for any purpose, commercial advertising, or otherwise, and to prepare derivative works of, or incorporate in other works, such as Contributions, and grant and authorize sublicenses of the foregoing. The use and distribution may occur in any media formats and through any media channels."
        return label
    }()
    lazy var No6p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "This license will apply to any form, media, or technology now known or hereafter developed, and includes our use of your name, company name, and franchise name, as applicable, and any of the trademarks, service marks, trade names, logos, and personal and commercial images you provide. You waive all moral rights in your Contributions, and you warrant that moral rights have not otherwise been asserted in your Contributions."
        return label
    }()
    lazy var No6p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We do not assert any ownership over your Contributions. You retain full ownership of all of your Contributions and any intellectual property rights or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your Contributions provided by you in any area in the Application. You are solely responsible for your Contributions to the Application and you expressly agree to exonerate us from any and all responsibility and to refrain from any legal action against us regarding your Contributions."
        return label
    }()
    lazy var No6p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We have the right, in our sole and absolute discretion, (1) to edit, redact, or otherwise change any Contributions; (2) to re-categorize any Contributions to place them in more appropriate locations in the Application; and (3) to pre-screen or delete any Contributions at any time and for any reason, without notice. We have no obligation to monitor your Contributions."
        return label
    }()
    
    lazy var No7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "7. LIABILITY"
        return label
    }()
    lazy var No7p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "7.1  Licensor's responsibility in the case of violation of obligations and tort shall be limited to intent and gross negligence. Only in case of a breach of essential contractual duties (cardinal obligations), Licensor shall also be liable in case of slight negligence. In any case, liability shall be limited to the foreseeable, contractually typical damages. The limitation mentioned above does not apply to injuries to life, limb, or health."
        return label
    }()
    lazy var No7p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "7.2  Licensor takes no accountability or responsibility for any damages caused due to a breach of duties according to Section 2 of this Agreement. To avoid data loss, You are required to make use of backup functions of the Application to the extent allowed by applicable third-party terms and conditions of use. You are aware that in case of alterations or manipulations of the Application, You will not have access to licensed Application."
        return label
    }()
    
    lazy var No8: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "8. WARRANTY"
        return label
    }()
    lazy var No8p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "8.1  Licensor warrants that the Application is free of spyware, trojan horses, viruses, or any other malware at the time of Your download. Licensor warrants that the Application works as described in the user documentation."
        return label
    }()
    lazy var No8p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "8.2  No warranty is provided for the Application that is not executable on the device, that has been unauthorizedly modified, handled inappropriately or culpably, combined or installed with inappropriate hardware or software, used with inappropriate accessories, regardless if by Yourself or by third parties, or if there are any other reasons outside of Necto's sphere of influence that affect the executability of the Application."
        return label
    }()
    lazy var No8p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "8.3  You are required to inspect the Application immediately after installing it and notify Necto about issues discovered without delay by e-mail provided in Product Claims. The defect report will be taken into consideration and further investigated if it has been mailed within a period of ninety (90) days after discovery."
        return label
    }()
    lazy var No8p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "8.4  If we confirm that the Application is defective, Necto reserves a choice to remedy the situation either by means of solving the defect or substitute delivery."
        return label
    }()
    lazy var No8p5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "8.5  In the event of any failure of the Application to conform to any applicable warranty, You may notify the App-Store-Operator, and Your Application purchase price will be refunded to You. To the maximum extent permitted by applicable law, the App-Store-Operator will have no other warranty obligation whatsoever with respect to the App, and any other losses, claims, damages, liabilities, expenses and costs attributable to any negligence to adhere to any warranty."
        return label
    }()
    lazy var No8p6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "8.6  If the user is an entrepreneur, any claim based on faults expires after a statutory period of limitation amounting to twelve (12) months after the Application was made available to the user. The statutory periods of limitation given by law apply for users who are consumers."
        return label
    }()
    
    lazy var No9: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "9. PRODUCT CLAIMS"
        return label
    }()
    lazy var No9p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Necto and the End-User acknowledge that Necto, and not Apple, is responsible for addressing any claims of the End-User or any third party relating to the licensed Application or the End-User’s possession and/or use of that licensed Application, including, but not limited to:"
        return label
    }()
    lazy var No9p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "(i) product liability claims;"
        return label
    }()
    lazy var No9p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "(ii) any claim that the licensed Application fails to conform to any applicable legal or regulatory requirement; and"
        return label
    }()
    lazy var No9p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "(iii) claims arising under consumer protection, privacy, or similar legislation, including in connection with Your Licensed Application’s use of the HealthKit and HomeKit."
        return label
    }()

    lazy var No10: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "10. LEGAL COMPLIANCE"
        return label
    }()
    lazy var No10p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "You represent and warrant that You are not located in a country that is subject to a U.S. Government embargo, or that has been designated by the U.S. Government as a 'terrorist supporting' country; and that You are not listed on any U.S. Government list of prohibited or restricted parties."
        return label
    }()

    lazy var No11: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "11. CONTACT INFORMATION"
        return label
    }()
    lazy var No11p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "For general inquiries, complaints, questions or claims concerning the licensed Application, please contact: appdevucsc2020@gmail.com"
        return label
    }()
   
    lazy var No12: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "12. TERMINATION"
        return label
    }()
    lazy var No12p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "The license is valid until terminated by Necto or by You. Your rights under this license will terminate automatically and without notice from Necto if You fail to adhere to any term(s) of this license. Upon License termination, You shall stop all use of the Application, and destroy all copies, full or partial, of the Application."
        return label
    }()
   
    lazy var No13: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "13. THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY"
        return label
    }()
    lazy var No13p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Necto represents and warrants that Necto will comply with applicable third-party terms of agreement when using licensed Application."
        return label
    }()
    lazy var No13p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In Accordance with Section 9 of the 'Instructions for Minimum Terms of Developer's End-User License Agreement,' Apple and Apple's subsidiaries shall be third-party beneficiaries of this End User License Agreement and - upon Your acceptance of the terms and conditions of this license agreement, Apple will have the right (and will be deemed to have accepted the right) to enforce this End User License Agreement against You as a third-party beneficiary thereof."
        return label
    }()
    
    lazy var No14: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "14. INTELLECTUAL PROPERTY RIGHTS"
        return label
    }()
    lazy var No14p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Necto and the End-User acknowledge that, in the event of any third-party claim that the licensed Application or the End-User's possession and use of that licensed Application infringes on the third party's intellectual property rights, Necto, and not Apple, will be solely responsible for the investigation, defense, settlement and discharge or any such intellectual property infringement claims"
        return label
    }()
    
    lazy var No15: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "15. APPLICABLE LAW"
        return label
    }()
    lazy var No15p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "This license agreement is governed by the laws of the State of California excluding its conflicts of law rules."
        return label
    }()
    
    lazy var No16: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "16. MISCELLANEOUS"
        return label
    }()
    lazy var No16p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "16.1  If any of the terms of this agreement should be or become invalid, the validity of the remaining provisions shall not be affected. Invalid terms will be replaced by valid ones formulated in a way that will achieve the primary purpose. "
        return label
    }()
    lazy var No16p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "16.2  Collateral agreements, changes and amendments are only valid if laid down in writing. The preceding clause can only be waived in writing."
        return label
    }()
    
    lazy var termly: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: bottomNoteFont, weight: bottomNoteType)
        label.tintColor = UIColor.black
        label.textAlignment = .left
        label.text = "Note: Terms and Services was created using Termly’s Generator"
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
        
        self.addSubview(No4)
        self.addSubview(No4p1)
        self.addSubview(No4p2)
        
        self.addSubview(No5)
        self.addSubview(No5p1)
        self.addSubview(No5p2)
        self.addSubview(No5p3)
        self.addSubview(No5p4)
        self.addSubview(No5p5)
        self.addSubview(No5p6)
        self.addSubview(No5p7)
        self.addSubview(No5p8)
        self.addSubview(No5p9)
        self.addSubview(No5p10)
        self.addSubview(No5p11)
        self.addSubview(No5p12)
        self.addSubview(No5p13)
        self.addSubview(No5p14)
        self.addSubview(No5p15)
        self.addSubview(No5p16)
        
        self.addSubview(No6)
        self.addSubview(No6p1)
        self.addSubview(No6p2)
        self.addSubview(No6p3)
        self.addSubview(No6p4)
        
        self.addSubview(No7)
        self.addSubview(No7p1)
        self.addSubview(No7p2)
        
        self.addSubview(No8)
        self.addSubview(No8p1)
        self.addSubview(No8p2)
        self.addSubview(No8p3)
        self.addSubview(No8p4)
        self.addSubview(No8p5)
        self.addSubview(No8p6)
        
        
        self.addSubview(No9)
        self.addSubview(No9p1)
        self.addSubview(No9p2)
        self.addSubview(No9p3)
        self.addSubview(No9p4)
        
        self.addSubview(No10)
        self.addSubview(No10p1)
        
        self.addSubview(No11)
        self.addSubview(No11p1)
        
        self.addSubview(No12)
        self.addSubview(No12p1)
        
        self.addSubview(No13)
        self.addSubview(No13p1)
        self.addSubview(No13p2)
        
        self.addSubview(No14)
        self.addSubview(No14p1)
        
        self.addSubview(No15)
        self.addSubview(No15p1)
        
        self.addSubview(No16)
        self.addSubview(No16p1)
        self.addSubview(No16p2)
      
        self.addSubview(termly)
        
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
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1.addAnchors(top: Intro.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p1.addAnchors(top: No1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2.addAnchors(top: No1p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2p1.addAnchors(top: No2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2p2.addAnchors(top: No2p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        No2p3.addAnchors(top: No2p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        No2p4.addAnchors(top: No2p3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        No2p5.addAnchors(top: No2p4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        No2p6.addAnchors(top: No2p5.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        No2p7.addAnchors(top: No2p6.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2p8.addAnchors(top: No2p7.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3.addAnchors(top: No2p8.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p1.addAnchors(top: No3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p2.addAnchors(top: No3p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p3.addAnchors(top: No3p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p4.addAnchors(top: No3p3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No4.addAnchors(top: No3p4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No4p1.addAnchors(top: No4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        
        No4p2.addAnchors(top: No4p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5.addAnchors(top: No4p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p1.addAnchors(top: No5.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p2.addAnchors(top: No5p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p3.addAnchors(top: No5p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p4.addAnchors(top: No5p3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p5.addAnchors(top: No5p4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p6.addAnchors(top: No5p5.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p7.addAnchors(top: No5p6.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p8.addAnchors(top: No5p7.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p9.addAnchors(top: No5p8.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p10.addAnchors(top: No5p9.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p11.addAnchors(top: No5p10.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p12.addAnchors(top: No5p11.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p13.addAnchors(top: No5p12.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p14.addAnchors(top: No5p13.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p15.addAnchors(top: No5p14.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5p16.addAnchors(top: No5p15.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No6.addAnchors(top: No5p16.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No6p1.addAnchors(top: No6.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No6p2.addAnchors(top: No6p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No6p3.addAnchors(top: No6p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No6p4.addAnchors(top: No6p3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No7.addAnchors(top: No6p4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No7p1.addAnchors(top: No7.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No7p2.addAnchors(top: No7p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No8.addAnchors(top: No7p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No8p1.addAnchors(top: No8.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No8p2.addAnchors(top: No8p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No8p3.addAnchors(top: No8p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No8p4.addAnchors(top: No8p3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No8p5.addAnchors(top: No8p4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No8p6.addAnchors(top: No8p5.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9.addAnchors(top: No8p6.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p1.addAnchors(top: No9.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p2.addAnchors(top: No9p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p3.addAnchors(top: No9p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p4.addAnchors(top: No9p3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: indent + 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No10.addAnchors(top: No9p4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No10p1.addAnchors(top: No10.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No11.addAnchors(top: No10p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No11p1.addAnchors(top: No11.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No12.addAnchors(top: No11p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No12p1.addAnchors(top: No12.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No13.addAnchors(top: No12p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No13p1.addAnchors(top: No13.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No13p2.addAnchors(top: No13p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No14.addAnchors(top: No13p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No14p1.addAnchors(top: No14.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No15.addAnchors(top: No14p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No15p1.addAnchors(top: No15.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No16.addAnchors(top: No15p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No16p1.addAnchors(top: No16.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No16p2.addAnchors(top: No16p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        termly.addAnchors(top: No16p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: self.bottomAnchor,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 20, right: 5),size: .init(width: 0, height: 0))
    }
}
