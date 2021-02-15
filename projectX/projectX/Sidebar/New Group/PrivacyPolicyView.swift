//
//  PrivacyPolicyView.swift
//  projectX
//
//  Created by Gurpreet Dhillon on 1/26/21.
//  Copyright © 2021 Radomyr Bezghin. All rights reserved.
//

import Foundation
import UIKit


class PrivacyPolicyView: UIView {
    
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
    
    let subHeaderFont:CGFloat = 12
    let subHeaderType:UIFont.Weight = .bold
    
    
    let bottomNoteFont:CGFloat = 12
    let bottomNoteType:UIFont.Weight = .heavy
    
    let headerSpacing:CGFloat = 15
    let paragraphSpacing:CGFloat = 7
    
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    lazy var Necto: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: title,weight: titleType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .center
        label.text = "Necto Privacy Policy"
        return label
    }()
    lazy var effectiveDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: date, weight: dateType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .center
        label.text = "Effective: January 24, 2021"
        return label
    }()
    lazy var Intro: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Thank you for choosing to be part of our community at Necto ('Company', 'we', 'us', 'our'). We are committed to protecting your personal information and your right to privacy. If you have any questions or concerns about this privacy notice, or our practices with regards to your personal information, please contact us at appdevucsc2020@gmail.com."
        return label
    }()
    lazy var Intro2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "When you use our mobile application, as the case may be (the 'App') and more generally, use any of our services (the 'Services', which include the App), we appreciate that you are trusting us with your personal information. We take your privacy very seriously. In this privacy notice, we seek to explain to you in the clearest way possible what information we collect, how we use it and what rights you have in relation to it. We hope you take some time to read through it carefully, as it is important. If there are any terms in this privacy notice that you do not agree with, please discontinue use of our Services immediately."
        return label
    }()
    lazy var Intro3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "This privacy notice applies to all information collected through our Services (which, as described above, includes our App), as well as, any related services, sales, marketing or events."
        return label
    }()
    lazy var Intro4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: subHeaderFont, weight: subHeaderType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Please read this privacy notice carefully as it will help you understand what we do with the information that we collect."
        return label
    }()
    
    lazy var No1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "1. WHAT INFORMATION DO WE COLLECT?"
        return label
    }()
    lazy var No1p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: subHeaderFont, weight: subHeaderType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Personal information you disclose to us"
        return label
    }()
    
    lazy var No1p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: paragraphFont)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In Short:  We collect personal information that you provide to us."
        return label
    }()
    lazy var No1p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We collect personal information that you voluntarily provide to us when you register on the App, express an interest in obtaining information about us or our products and Services, when you participate in activities on the App (such as by posting messages in our online forums or entering competitions, contests or giveaways) or otherwise when you contact us."
        return label
    }()
    lazy var No1p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "The personal information that we collect depends on the context of your interactions with us and the App, the choices you make and the products and features you use. The personal information we collect may include the following:"
        return label
    }()
    lazy var No1p5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: subHeaderFont, weight: subHeaderType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Personal Information Provided by You."
        return label
    }()
    lazy var No1p6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We collect email addresses; usernames; passwords; names; contact or authentication data; and other similar information. All personal information that you provide to us must be true, complete and accurate, and you must notify us of any changes to such personal information."
        return label
    }()
    lazy var No1p7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: subHeaderFont, weight: subHeaderType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Information automatically collected"
        return label
    }()
    lazy var No1p8: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: paragraphFont)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In Short:  Some information — such as your Internet Protocol (IP) address and/or browser and device characteristics — is collected automatically when you visit our App."
        return label
    }()
    lazy var No1p9: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We automatically collect certain information when you visit, use or navigate the App. This information does not reveal your specific identity (like your name or contact information) but may include device and usage information, such as your IP address, browser and device characteristics, operating system, language preferences, referring URLs, device name, country, location, information about how and when you use our App and other technical information. This information is primarily needed to maintain the security and operation of our App, and for our internal analytics and reporting purposes."
        return label
    }()
    lazy var No1p10: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "The information we collect includes:"
        return label
    }()
    lazy var No1p11: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Log and Usage Data. Log and usage data is service-related, diagnostic, usage and performance information our servers automatically collect when you access or use our App and which we record in log files. Depending on how you interact with us, this log data may include your IP address, device information, browser type and settings and information about your activity in the App (such as the date/time stamps associated with your usage, pages and files viewed, searches and other actions you take such as which features you use), device event information (such as system activity, error reports (sometimes called 'crash dumps') and hardware settings)."
        return label
    }()
    lazy var No1p12: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Device Data. We collect device data such as information about your computer, phone, tablet or other device you use to access the App. Depending on the device used, this device data may include information such as your IP address (or proxy server), device and application identification numbers, location, browser type, hardware model Internet service provider and/or mobile carrier, operating system and system configuration information."
        return label
    }()
    lazy var No1p13: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: subHeaderFont, weight: subHeaderType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Information collected through our App"
        return label
    }()
    lazy var No1p14: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: paragraphFont)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In Short:  We collect information regarding your  mobile device, push notifications, when you use our App."
        return label
    }()
    lazy var No1p15: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "If you use our App, we also collect the following information:"
        return label
    }()
    lazy var No1p16: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Mobile Device Access. We may request access or permission to certain features from your mobile device, including your mobile device's storage, reminders,  and other features. If you wish to change our access or permissions, you may do so in your device's settings."
        return label
    }()
    lazy var No1p17: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Mobile Device Data. We automatically collect device information (such as your mobile device ID, model and manufacturer), operating system, version information and system configuration information, device and application identification numbers, browser type and version, hardware model Internet service provider and/or mobile carrier, and Internet Protocol (IP) address (or proxy server). If you are using our App, we may also collect information about the phone network associated with your mobile device, your mobile device’s operating system or platform, the type of mobile device you use, your mobile device’s unique device ID and information about the features of our App you accessed."
        return label
    }()
    lazy var No1p18: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Push Notifications. We may request to send you push notifications regarding your account or certain features of the App. If you wish to opt-out from receiving these types of communications, you may turn them off in your device's settings."
        return label
    }()
    lazy var No1p19: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "This information is primarily needed to maintain the security and operation of our App, for troubleshooting and for our internal analytics and reporting purposes."
        return label
    }()
    lazy var No2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "2. HOW DO WE USE YOUR INFORMATION?"
        return label
    }()
    lazy var No2p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: paragraphFont)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In Short:  We process your information for purposes based on legitimate business interests, the fulfillment of our contract with you, compliance with our legal obligations, and/or your consent."
        return label
    }()
    lazy var No2p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We use personal information collected via our App for a variety of business purposes described below. We process your personal information for these purposes in reliance on our legitimate business interests, in order to enter into or perform a contract with you, with your consent, and/or for compliance with our legal obligations. We indicate the specific processing grounds we rely on next to each purpose listed below."
        return label
    }()
    lazy var No2p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We use the information we collect or receive:"
        return label
    }()
    lazy var No2p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• To facilitate account creation and logon process. If you choose to link your account with us to a third-party account (such as your Google or Facebook account), we use the information you allowed us to collect from those third parties to facilitate account creation and logon process for the performance of the contract."
        return label
    }()
    lazy var No2p5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• To post testimonials. We post testimonials on our App that may contain personal information. Prior to posting a testimonial, we will obtain your consent to use your name and the content of the testimonial. If you wish to update, or delete your testimonial, please contact us at appdevucsc2020@gmail.com and be sure to include your name, testimonial location, and contact information."
        return label
    }()
    lazy var No2p6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Request feedback. We may use your information to request feedback and to contact you about your use of our App."
        return label
    }()
    lazy var No2p7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• To enable user-to-user communications. We may use your information in order to enable user-to-user communications with each user's consent."
        return label
    }()
    lazy var No2p8: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• To manage user accounts. We may use your information for the purposes of managing our account and keeping it in working order."
        return label
    }()
    lazy var No2p9: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• To send administrative information to you. We may use your personal information to send you product, service and new feature information and/or information about changes to our terms, conditions, and policies."
        return label
    }()
    lazy var No2p10: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• To protect our Services. We may use your information as part of our efforts to keep our App safe and secure (for example, for fraud monitoring and prevention)."
        return label
    }()
    lazy var No2p11: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• To enforce our terms, conditions and policies for business purposes, to comply with legal and regulatory requirements or in connection with our contract."
        return label
    }()
    lazy var No2p12: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• To respond to legal requests and prevent harm. If we receive a subpoena or other legal request, we may need to inspect the data we hold to determine how to respond."
        return label
    }()
    lazy var No2p13: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• For other business purposes. We may use your information for other business purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our App, products, marketing and your experience. We may use and store this information in aggregated and anonymized form so that it is not associated with individual end users and does not include personal information. We will not use identifiable personal information without your consent."
        return label
    }()
    lazy var No3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "3. WILL YOUR INFORMATION BE SHARED WITH ANYONE?"
        return label
    }()
    lazy var No3p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: paragraphFont)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In Short:  We only share information with your consent, to comply with laws, to provide you with services, to protect your rights, or to fulfill business obligations."
        return label
    }()
    lazy var No3p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We may process or share your data that we hold based on the following legal basis:"
        return label
    }()
    lazy var No3p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Consent: We may process your data if you have given us specific consent to use your personal information for a specific purpose."
        return label
    }()
    lazy var No3p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Legitimate Interests: We may process your data when it is reasonably necessary to achieve our legitimate business interests."
        return label
    }()
    lazy var No3p5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Performance of a Contract: Where we have entered into a contract with you, we may process your personal information to fulfill the terms of our contract"
        return label
    }()
    lazy var No3p6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Legal Obligations: We may disclose your information where we are legally required to do so in order to comply with applicable law, governmental requests, a judicial proceeding, court order, or legal process, such as in response to a court order or a subpoena (including in response to public authorities to meet national security or law enforcement requirements)."
        return label
    }()
    lazy var No3p7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Vital Interests: We may disclose your information where we believe it is necessary to investigate, prevent, or take action regarding potential violations of our policies, suspected fraud, situations involving potential threats to the safety of any person and illegal activities, or as evidence in litigation in which we are involved."
        return label
    }()
    lazy var No3p8: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "More specifically, we may need to process your data or share your personal information in the following situations:"
        return label
    }()
    lazy var No3p9: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Business Transfers. We may share or transfer your information in connection with, or during negotiations of, any merger, sale of company assets, financing, or acquisition of all or a portion of our business to another company."
        return label
    }()
    lazy var No3p10: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Offer Wall. Our App may display a third-party hosted 'offer wall.' Such an offer wall allows third-party advertisers to offer virtual currency, gifts, or other items to users in return for the acceptance and completion of an advertisement offer. Such an offer wall may appear in our App and be displayed to you based on certain data, such as your geographic area or demographic information. When you click on an offer wall, you will be brought to an external website belonging to other persons and will leave our App. A unique identifier, such as your user ID, will be shared with the offer wall provider in order to prevent fraud and properly credit your account with the relevant reward. Please note that we do not control third-party websites and have no responsibility in relation to the content of such websites. The inclusion of a link towards a third-party website does not imply an endorsement by us of such website. Accordingly, we do not make any warranty regarding such third-party websites and we will not be liable for any loss or damage caused by the use of such websites. In addition, when you access any third-party website, please understand that your rights while accessing and using those websites will be governed by the privacy notice and terms of service relating to the use of those websites."
        return label
    }()
    lazy var No4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "4. HOW LONG DO WE KEEP YOUR INFORMATION?"
        return label
    }()
    lazy var No4p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: paragraphFont)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In Short:  We keep your information for as long as necessary to fulfill the purposes outlined in this privacy notice unless otherwise required by law."
        return label
    }()
    lazy var No4p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We will only keep your personal information for as long as it is necessary for the purposes set out in this privacy notice, unless a longer retention period is required or permitted by law (such as tax, accounting or other legal requirements). No purpose in this notice will require us keeping your personal information for longer than the period of time in which users have an account with us."
        return label
    }()
    lazy var No4p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "When we have no ongoing legitimate business need to process your personal information, we will either delete or anonymize such information, or, if this is not possible (for example, because your personal information has been stored in backup archives), then we will securely store your personal information and isolate it from any further processing until deletion is possible."
        return label
    }()
    lazy var No5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "5. HOW DO WE KEEP YOUR INFORMATION SAFE?"
        return label
    }()
    lazy var No5p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: paragraphFont)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In Short:  We aim to protect your personal information through a system of organizational and technical security measures."
        return label
    }()
    lazy var No5p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We have implemented appropriate technical and organizational security measures designed to protect the security of any personal information we process. However, despite our safeguards and efforts to secure your information, no electronic transmission over the Internet or information storage technology can be guaranteed to be 100% secure, so we cannot promise or guarantee that hackers, cybercriminals, or other unauthorized third parties will not be able to defeat our security, and improperly collect, access, steal, or modify your information. Although we will do our best to protect your personal information, transmission of personal information to and from our App is at your own risk. You should only access the App within a secure environment."
        return label
    }()
    lazy var No6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "6. DO WE COLLECT INFORMATION FROM MINORS?"
        return label
    }()
    lazy var No6p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: paragraphFont)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In Short: We do not knowingly collect data from or market to children under 18 years of age."
        return label
    }()
    lazy var No6p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We do not knowingly solicit data from or market to children under 18 years of age. By using the App, you represent that you are at least 18 or that you are the parent or guardian of such a minor and consent to such minor dependent’s use of the App. If we learn that personal information from users less than 18 years of age has been collected, we will deactivate the account and take reasonable measures to promptly delete such data from our records. If you become aware of any data we may have collected from children under age 18, please contact us at appdevucsc2020@gmail.com."
        return label
    }()
    lazy var No7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "7. WHAT ARE YOUR PRIVACY RIGHTS?"
        return label
    }()
    lazy var No7p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: paragraphFont)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In Short:  You may review, change, or terminate your account at any time."
        return label
    }()
    lazy var No7p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "If you are a resident in the European Economic Area and you believe we are unlawfully processing your personal information, you also have the right to complain to your local data protection supervisory authority. You can find their contact details here: http://ec.europa.eu/justice/data-protection/bodies/authorities/index_en.htm."
        return label
    }()
    lazy var No7p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "If you are a resident in Switzerland, the contact details for the data protection authorities are available here: https://www.edoeb.admin.ch/edoeb/en/home.html."
        return label
    }()
    lazy var No7p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "If you have questions or comments about your privacy rights, you may email us at appdevucsc2020@gmail.com."
        return label
    }()
    lazy var No7p5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: subHeaderFont, weight: subHeaderType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Account Information"
        return label
    }()
    lazy var No7p6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "If you would at any time like to review or change the information in your account or terminate your account, you can:"
        return label
    }()
    lazy var No7p7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Log in to your account settings and update your user account."
        return label
    }()
    lazy var No7p8: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Contact us using the contact information provided."
        return label
    }()
    lazy var No7p9: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Upon your request to terminate your account, we will deactivate or delete your account and information from our active databases. However, we may retain some information in our files to prevent fraud, troubleshoot problems, assist with any investigations, enforce our Terms of Use and/or comply with applicable legal requirements."
        return label
    }()
    lazy var No7p10: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Opting out of email marketing: You can unsubscribe from our marketing email list at any time by clicking on the unsubscribe link in the emails that we send or by contacting us using the details provided below. You will then be removed from the marketing email list — however, we may still communicate with you, for example to send you service-related emails that are necessary for the administration and use of your account, to respond to service requests, or for other non-marketing purposes. To otherwise opt-out, you may:"
        return label
    }()
    lazy var No7p11: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Contact us using the contact information provided."
        return label
    }()
    lazy var No7p12: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Access your account settings and update your preferences."
        return label
    }()
    lazy var No8: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "8. CONTROLS FOR DO-NOT-TRACK FEATURES"
        return label
    }()
    lazy var No8p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Most web browsers and some mobile operating systems and mobile applications include a Do-Not-Track ('DNT') feature or setting you can activate to signal your privacy preference not to have data about your online browsing activities monitored and collected. At this stage no uniform technology standard for recognizing and implementing DNT signals has been finalized. As such, we do not currently respond to DNT browser signals or any other mechanism that automatically communicates your choice not to be tracked online. If a standard for online tracking is adopted that we must follow in the future, we will inform you about that practice in a revised version of this privacy notice. "
        return label
    }()
    lazy var No9: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "9. DO CALIFORNIA RESIDENTS HAVE SPECIFIC PRIVACY RIGHTS?"
        return label
    }()
    lazy var No9p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: paragraphFont)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In Short:  Yes, if you are a resident of California, you are granted specific rights regarding access to your personal information."
        return label
    }()
    lazy var No9p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "California Civil Code Section 1798.83, also known as the 'Shine The Light' law, permits our users who are California residents to request and obtain from us, once a year and free of charge, information about categories of personal information (if any) we disclosed to third parties for direct marketing purposes and the names and addresses of all third parties with which we shared personal information in the immediately preceding calendar year. If you are a California resident and would like to make such a request, please submit your request in writing to us using the contact information provided below."
        return label
    }()
    lazy var No9p3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "If you are under 18 years of age, reside in California, and have a registered account with the App, you have the right to request removal of unwanted data that you publicly post on the App. To request removal of such data, please contact us using the contact information provided below, and include the email address associated with your account and a statement that you reside in California. We will make sure the data is not publicly displayed on the App, but please be aware that the data may not be completely or comprehensively removed from all our systems (e.g. backups, etc.)."
        return label
    }()
    lazy var No9p4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: subHeaderFont, weight: subHeaderType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "CCPA Privacy Notice"
        return label
    }()
    lazy var No9p5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "The California Code of Regulations defines a 'resident' as:"
        return label
    }()
    lazy var No9p6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "(1) every individual who is in the State of California for other than a temporary or transitory purpose and"
        return label
    }()
    lazy var No9p7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "(2) every individual who is domiciled in the State of California who is outside the State of California for a temporary or transitory purpose"
        return label
    }()
    lazy var No9p8: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "All other individuals are defined as 'non-residents.'"
        return label
    }()
    lazy var No9p9: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "If this definition of 'resident' applies to you, we must adhere to certain rights and obligations regarding your personal information."
        return label
    }()
    lazy var No9p10: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "What categories of personal information do we collect?"
        return label
    }()
    lazy var No9p11: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Possible categories of personal information collected:"
        return label
    }()
    lazy var No9p12: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Category / Examples / Collected"
        return label
    }()
    lazy var No9p13: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "A. Identifiers / Contact details, such as real name, alias, postal address, telephone or mobile contact number, unique personal identifier, online identifier, Internet Protocol address, email address and account name / NO"
        return label
    }()
    lazy var No9p14: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "B. Personal information categories listed in the California Customer Records statute / Name, contact information, education, employment, employment history and financial information / NO"
        return label
    }()
    lazy var No9p15: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "C. Protected classification characteristics under California or federal law / Gender and date of birth / NO"
        return label
    }()
    lazy var No9p16: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "D. Commercial information / Transaction information, purchase history, financial details and payment information / NO"
        return label
    }()
    lazy var No9p17: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "E. Biometric information / Fingerprints and voiceprints / NO"
        return label
    }()
    lazy var No9p18: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "F. Internet or other similar network activity / Browsing history, search history, online behavior, interest data, and interactions with our and other websites, applications, systems and advertisements / NO"
        return label
    }()
    lazy var No9p19: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "G. Geolocation data / Device location / NO"
        return label
    }()
    lazy var No9p20: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "H. Audio, electronic, visual, thermal, olfactory, or similar information / Images and audio, video or call recordings created in connection with our business activities / NO"
        return label
    }()
    lazy var No9p21: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "I. Professional or employment-related information / Business contact details in order to provide you our services at a business level, job title as well as work history and professional qualifications if you apply for a job with us / NO"
        return label
    }()
    lazy var No9p22: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "J. Education Information / Student records and directory information / NO"
        return label
    }()
    lazy var No9p23: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "K. Inferences drawn from other personal information / Inferences drawn from any of the collected personal information listed above to create a profile or summary about, for example, an individual’s preferences and characteristics / NO"
        return label
    }()
    lazy var No9p24: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We may also collect other personal information outside of these categories instances where you interact with us in-person, online, or by phone or mail in the context of:"
        return label
    }()
    lazy var No9p25: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Receiving help through our customer support channels;"
        return label
    }()
    lazy var No9p26: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Participation in customer surveys or contests; and"
        return label
    }()
    lazy var No9p27: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• Facilitation in the delivery of our Services and to respond to your inquiries."
        return label
    }()
    lazy var No9p28: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: subHeaderFont, weight: subHeaderType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "How do we use and share your personal information?"
        return label
    }()
    lazy var No9p29: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "More information about our data collection and sharing practices can be found in this privacy notice."
        return label
    }()
    lazy var No9p30: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "You may contact us by email at appdevucsc2020@gmail.com, or by referring to the contact details at the bottom of this document."
        return label
    }()
    lazy var No9p31: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "If you are using an authorized agent to exercise your right to opt-out we may deny a request if the authorized agent does not submit proof that they have been validly authorized to act on your behalf."
        return label
    }()
    lazy var No9p32: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: subHeaderFont, weight: subHeaderType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Will your information be shared with anyone else?"
        return label
    }()
    lazy var No9p33: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We may disclose your personal information with our service providers pursuant to a written contract between us and each service provider. Each service provider is a for-profit entity that processes the information on our behalf."
        return label
    }()
    lazy var No9p34: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We may use your personal information for our own business purposes, such as for undertaking internal research for technological development and demonstration. This is not considered to be 'selling' of your personal data."
        return label
    }()
    lazy var No9p35: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Necto has not disclosed or sold any personal information to third parties for a business or commercial purpose in the preceding 12 months. Necto will not sell personal information in the future belonging to website visitors, users and other consumers."
        return label
    }()
    lazy var No9p36: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: subHeaderFont, weight: subHeaderType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Your rights with respect to your personal data"
        return label
    }()
    lazy var No9p37: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Right to request deletion of the data - Request to delete"
        return label
    }()
    lazy var No9p38: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "You can ask for the deletion of your personal information. If you ask us to delete your personal information, we will respect your request and delete your personal information, subject to certain exceptions provided by law, such as (but not limited to) the exercise by another consumer of his or her right to free speech, our compliance requirements resulting from a legal obligation or any processing that may be required to protect against illegal activities."
        return label
    }()
    lazy var No9p39: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Right to be informed - Request to know"
        return label
    }()
    lazy var No9p40: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Depending on the circumstances, you have a right to know:"
        return label
    }()
    lazy var No9p41: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• whether we collect and use your personal information;"
        return label
    }()
    lazy var No9p42: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• the categories of personal information that we collect;"
        return label
    }()
    lazy var No9p43: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• the purposes for which the collected personal information is used;"
        return label
    }()
    lazy var No9p44: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• whether we sell your personal information to third parties;"
        return label
    }()
    lazy var No9p45: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• the categories of personal information that we sold or disclosed for a business purpose;"
        return label
    }()
    lazy var No9p46: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• the categories of third parties to whom the personal information was sold or disclosed for a business purpose; and"
        return label
    }()
    lazy var No9p47: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• the business or commercial purpose for collecting or selling personal information."
        return label
    }()
    lazy var No9p48: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In accordance with applicable law, we are not obligated to provide or delete consumer information that is de-identified in response to a consumer request or to re-identify individual data to verify a consumer request."
        return label
    }()
    lazy var No9p49: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Right to Non-Discrimination for the Exercise of a Consumer’s Privacy Rights"
        return label
    }()
    lazy var No9p50: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We will not discriminate against you if you exercise your privacy rights."
        return label
    }()
    lazy var No9p51: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Verification process"
        return label
    }()
    lazy var No9p52: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Upon receiving your request, we will need to verify your identity to determine you are the same person about whom we have the information in our system. These verification efforts require us to ask you to provide information so that we can match it with information you have previously provided us. For instance, depending on the type of request you submit, we may ask you to provide certain information so that we can match the information you provide with the information we already have on file, or we may contact you through a communication method (e.g. phone or email) that you have previously provided to us. We may also use other verification methods as the circumstances dictate."
        return label
    }()
    lazy var No9p53: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We will only use personal information provided in your request to verify your identity or authority to make the request. To the extent possible, we will avoid requesting additional information from you for the purposes of verification. If, however, if we cannot verify your identity from the information already maintained by us, we may request that you provide additional information for the purposes of verifying your identity, and for security or fraud-prevention purposes. We will delete such additionally provided information as soon as we finish verifying you."
        return label
    }()
    lazy var No9p54: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "Other privacy rights"
        return label
    }()
    lazy var No9p55: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• you may object to the processing of your personal data"
        return label
    }()
    lazy var No9p56: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• you may request correction of your personal data if it is incorrect or no longer relevant, or ask to restrict the processing of the data"
        return label
    }()
    lazy var No9p57: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• you can designate an authorized agent to make a request under the CCPA on your behalf. We may deny a request from an authorized agent that does not submit proof that they have been validly authorized to act on your behalf in accordance with the CCPA."
        return label
    }()
    lazy var No9p58: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "• you may request to opt-out from future selling of your personal information to third parties. Upon receiving a request to opt-out, we will act upon the request as soon as feasibly possible, but no later than 15 days from the date of the request submission."
        return label
    }()
    lazy var No9p59: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "To exercise these rights, you can contact us by email at appdevucsc2020@gmail.com, or by referring to the contact details at the bottom of this document. If you have a complaint about how we handle your data, we would like to hear from you."
        return label
    }()
    lazy var No10: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "10. DO WE MAKE UPDATES TO THIS NOTICE?"
        return label
    }()
    lazy var No10p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: paragraphFont)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "In Short:  Yes, we will update this notice as necessary to stay compliant with relevant laws."
        return label
    }()
    lazy var No10p2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "We may update this privacy notice from time to time. The updated version will be indicated by an updated 'Revised' date and the updated version will be effective as soon as it is accessible. If we make material changes to this privacy notice, we may notify you either by prominently posting a notice of such changes or by directly sending you a notification. We encourage you to review this privacy notice frequently to be informed of how we are protecting your information."
        return label
    }()
    lazy var No11: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "11. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?"
        return label
    }()
    lazy var No11p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "If you have questions or comments about this notice, you may email us at appdevucsc2020@gmail.com"
        return label
    }()
    
    lazy var No12: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: headerFont, weight: headerType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = "12. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?  "
        return label
    }()
    lazy var No12p1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: paragraphFont, weight: paragraphType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.numberOfLines = 0;
        label.text = " Based on the applicable laws of your country, you may have the right to request access to the personal information we collect from you, change that information, or delete it in some circumstances. To request to review, update, or delete your personal information, please email us. We will respond to your request within 30 days."
        return label
    }()
    
    lazy var termly: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: bottomNoteFont, weight: bottomNoteType)
        label.tintColor = Constants.Colors.mainText
        label.textAlignment = .left
        label.text = "Note: Terms and Services was created using Termly’s Generator"
        return label
    }()
    private func setupViews(){
        self.backgroundColor = Constants.Colors.mainBackground
        
        self.addSubview(cancelButton)
        self.addSubview(Necto)
        self.addSubview(effectiveDate)
        self.addSubview(Intro)
        self.addSubview(Intro2)
        self.addSubview(Intro3)
        self.addSubview(Intro4)
        
        self.addSubview(No1)
        self.addSubview(No1p1)
        self.addSubview(No1p2)
        self.addSubview(No1p3)
        self.addSubview(No1p4)
        self.addSubview(No1p5)
        self.addSubview(No1p6)
        self.addSubview(No1p7)
        self.addSubview(No1p8)
        self.addSubview(No1p9)
        self.addSubview(No1p10)
        self.addSubview(No1p11)
        self.addSubview(No1p12)
        self.addSubview(No1p13)
        self.addSubview(No1p14)
        self.addSubview(No1p15)
        self.addSubview(No1p16)
        self.addSubview(No1p17)
        self.addSubview(No1p18)
        self.addSubview(No1p19)

        self.addSubview(No2)
        self.addSubview(No2p1)
        self.addSubview(No2p2)
        self.addSubview(No2p3)
        self.addSubview(No2p4)
        self.addSubview(No2p5)
        self.addSubview(No2p6)
        self.addSubview(No2p7)
        self.addSubview(No2p8)
        self.addSubview(No2p9)
        self.addSubview(No2p10)
        self.addSubview(No2p11)
        self.addSubview(No2p12)
        self.addSubview(No2p13)
        
        self.addSubview(No3)
        self.addSubview(No3p1)
        self.addSubview(No3p2)
        self.addSubview(No3p3)
        self.addSubview(No3p4)
        self.addSubview(No3p5)
        self.addSubview(No3p6)
        self.addSubview(No3p7)
        self.addSubview(No3p8)
        self.addSubview(No3p9)
        self.addSubview(No3p10)
        
        self.addSubview(No4)
        self.addSubview(No4p1)
        self.addSubview(No4p2)
        self.addSubview(No4p3)
       
        self.addSubview(No5)
        self.addSubview(No5p1)
        self.addSubview(No5p2)
      
        self.addSubview(No6)
        self.addSubview(No6p1)
        self.addSubview(No6p2)
       
        self.addSubview(No7)
        self.addSubview(No7p1)
        self.addSubview(No7p2)
        self.addSubview(No7p3)
        self.addSubview(No7p4)
        self.addSubview(No7p5)
        self.addSubview(No7p6)
        self.addSubview(No7p7)
        self.addSubview(No7p8)
        self.addSubview(No7p9)
        self.addSubview(No7p10)
        self.addSubview(No7p11)
        self.addSubview(No7p12)
     
        self.addSubview(No8)
        self.addSubview(No8p1)
        
        self.addSubview(No9)
        self.addSubview(No9p1)
        self.addSubview(No9p2)
        self.addSubview(No9p3)
        self.addSubview(No9p4)
        self.addSubview(No9p5)
        self.addSubview(No9p6)
        self.addSubview(No9p7)
        self.addSubview(No9p8)
        self.addSubview(No9p9)
        self.addSubview(No9p10)
        self.addSubview(No9p11)
        self.addSubview(No9p12)
        self.addSubview(No9p13)
        self.addSubview(No9p14)
        self.addSubview(No9p15)
        self.addSubview(No9p16)
        self.addSubview(No9p17)
        self.addSubview(No9p18)
        self.addSubview(No9p19)
        self.addSubview(No9p20)
        self.addSubview(No9p21)
        self.addSubview(No9p22)
        self.addSubview(No9p23)
        self.addSubview(No9p24)
        self.addSubview(No9p25)
        self.addSubview(No9p26)
        self.addSubview(No9p27)
        self.addSubview(No9p28)
        self.addSubview(No9p29)
        self.addSubview(No9p30)
        self.addSubview(No9p31)
        self.addSubview(No9p32)
        self.addSubview(No9p33)
        self.addSubview(No9p34)
        self.addSubview(No9p35)
        self.addSubview(No9p36)
        self.addSubview(No9p37)
        self.addSubview(No9p38)
        self.addSubview(No9p39)
        self.addSubview(No9p40)
        self.addSubview(No9p41)
        self.addSubview(No9p42)
        self.addSubview(No9p43)
        self.addSubview(No9p44)
        self.addSubview(No9p45)
        self.addSubview(No9p46)
        self.addSubview(No9p47)
        self.addSubview(No9p48)
        self.addSubview(No9p49)
        self.addSubview(No9p50)
        self.addSubview(No9p51)
        self.addSubview(No9p52)
        self.addSubview(No9p53)
        self.addSubview(No9p54)
        self.addSubview(No9p55)
        self.addSubview(No9p56)
        self.addSubview(No9p57)
        self.addSubview(No9p58)
        self.addSubview(No9p59)
        
        self.addSubview(No10)
        self.addSubview(No10p1)
        self.addSubview(No10p2)
       
        self.addSubview(No11)
        self.addSubview(No11p1)
      
        self.addSubview(No12)
        self.addSubview(No12p1)
        
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
        
        Intro.addAnchors(top: effectiveDate.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 20, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        Intro2.addAnchors(top: Intro.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        Intro3.addAnchors(top: Intro2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        Intro4.addAnchors(top: Intro3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1.addAnchors(top: Intro4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p1.addAnchors(top: No1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p2.addAnchors(top: No1p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p3.addAnchors(top: No1p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p4.addAnchors(top: No1p3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p5.addAnchors(top: No1p4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p6.addAnchors(top: No1p5.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p7.addAnchors(top: No1p6.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p8.addAnchors(top: No1p7.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p9.addAnchors(top: No1p8.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p10.addAnchors(top: No1p9.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p11.addAnchors(top: No1p10.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p12.addAnchors(top: No1p11.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p13.addAnchors(top: No1p12.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p14.addAnchors(top: No1p13.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p15.addAnchors(top: No1p14.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p16.addAnchors(top: No1p15.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p17.addAnchors(top: No1p16.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p18.addAnchors(top: No1p17.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No1p19.addAnchors(top: No1p18.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2.addAnchors(top: No1p19.bottomAnchor,
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
        No2p9.addAnchors(top: No2p8.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2p10.addAnchors(top: No2p9.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2p11.addAnchors(top: No2p10.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2p12.addAnchors(top: No2p11.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No2p13.addAnchors(top: No2p12.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3.addAnchors(top: No2p13.bottomAnchor,
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
        No3p5.addAnchors(top: No3p4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p6.addAnchors(top: No3p5.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p7.addAnchors(top: No3p6.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p8.addAnchors(top: No3p7.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p9.addAnchors(top: No3p8.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No3p10.addAnchors(top: No3p9.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No4.addAnchors(top: No3p10.bottomAnchor,
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
        No4p3.addAnchors(top: No4p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No5.addAnchors(top: No4p3.bottomAnchor,
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
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No6.addAnchors(top: No5p2.bottomAnchor,
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
        No7.addAnchors(top: No6p2.bottomAnchor,
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
        No7p3.addAnchors(top: No7p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No7p4.addAnchors(top: No7p3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No7p5.addAnchors(top: No7p4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No7p6.addAnchors(top: No7p5.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No7p7.addAnchors(top: No7p6.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No7p8.addAnchors(top: No7p7.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No7p9.addAnchors(top: No7p8.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No7p10.addAnchors(top: No7p9.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No7p11.addAnchors(top: No7p10.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No7p12.addAnchors(top: No7p11.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No8.addAnchors(top: No7p12.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No8p1.addAnchors(top: No8.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9.addAnchors(top: No8p1.bottomAnchor,
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
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p3.addAnchors(top: No9p2.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p4.addAnchors(top: No9p3.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p5.addAnchors(top: No9p4.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p6.addAnchors(top: No9p5.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p7.addAnchors(top: No9p6.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 0, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p8.addAnchors(top: No9p7.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p9.addAnchors(top: No9p8.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p10.addAnchors(top: No9p9.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p11.addAnchors(top: No9p10.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p12.addAnchors(top: No9p11.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p13.addAnchors(top: No9p12.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p14.addAnchors(top: No9p13.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p15.addAnchors(top: No9p14.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p16.addAnchors(top: No9p15.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p17.addAnchors(top: No9p16.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p18.addAnchors(top: No9p17.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p19.addAnchors(top: No9p18.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p20.addAnchors(top: No9p19.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p21.addAnchors(top: No9p20.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p22.addAnchors(top: No9p21.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p23.addAnchors(top: No9p22.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p24.addAnchors(top: No9p23.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p25.addAnchors(top: No9p24.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p26.addAnchors(top: No9p25.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 0, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p27.addAnchors(top: No9p26.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: 0, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p28.addAnchors(top: No9p27.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p29.addAnchors(top: No9p28.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p30.addAnchors(top: No9p29.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p31.addAnchors(top: No9p30.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p32.addAnchors(top: No9p31.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p33.addAnchors(top: No9p32.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p34.addAnchors(top: No9p33.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p35.addAnchors(top: No9p34.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p36.addAnchors(top: No9p35.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p37.addAnchors(top: No9p36.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p38.addAnchors(top: No9p37.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p39.addAnchors(top: No9p38.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p40.addAnchors(top: No9p39.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p41.addAnchors(top: No9p40.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p42.addAnchors(top: No9p41.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p43.addAnchors(top: No9p42.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p44.addAnchors(top: No9p43.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p45.addAnchors(top: No9p44.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p46.addAnchors(top: No9p45.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p47.addAnchors(top: No9p46.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p48.addAnchors(top: No9p47.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p49.addAnchors(top: No9p48.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p50.addAnchors(top: No9p49.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p51.addAnchors(top: No9p50.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p52.addAnchors(top: No9p51.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p53.addAnchors(top: No9p52.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p54.addAnchors(top: No9p53.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p55.addAnchors(top: No9p54.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p56.addAnchors(top: No9p55.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p57.addAnchors(top: No9p56.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p58.addAnchors(top: No9p57.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No9p59.addAnchors(top: No9p58.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No10.addAnchors(top: No9p59.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No10p1.addAnchors(top: No10.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No10p2.addAnchors(top: No10p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: nil,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: paragraphSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        No11.addAnchors(top: No10p2.bottomAnchor,
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
        termly.addAnchors(top: No12p1.bottomAnchor,
                                    leading: self.leadingAnchor,
                                    bottom: self.bottomAnchor,
                                    trailing: self.trailingAnchor,
                                    padding: .init(top: headerSpacing, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 0))
        
        
        
        
        
    }
    
    
}
