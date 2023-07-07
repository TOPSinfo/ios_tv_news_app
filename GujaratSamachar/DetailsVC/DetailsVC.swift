//
//  DetailsVC.swift
//  GujaratSamachar
//
//  Created by iMac on 23/06/23.
//

import TVMLKit
import UIKit


class DetailsVC: UIViewController, TVApplicationControllerDelegate {
    
    @IBOutlet weak var txtViewDescription: UITextView!
    var selectedNews: Article?
    var selectedGplusNews: GplusStoryDocument?
    var selectedCityNews: Article?
    var selectedMumbaiNews: Article?
    var selectedWorldNews: Article?
    
    
    
    var strHeading : String = ""
    var strHeadingOne : String = ""
    var strHeadingTwo : String = ""
    var strContent : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
       
        if selectedNews != nil{
            strHeading = selectedNews?.heading ?? ""
            strHeadingOne = selectedNews?.subHeadingOne ?? ""
            strHeadingTwo = selectedNews?.subHeadingTwo ?? ""
            strContent = selectedNews?.content ?? ""
        }else if selectedGplusNews != nil {
            strHeading = selectedGplusNews?.heading ?? ""
            strHeadingOne = selectedGplusNews?.subHeadingOne ?? ""
            strHeadingTwo = selectedGplusNews?.subHeadingTwo ?? ""
            strContent = selectedGplusNews?.content ?? ""
        }else if selectedCityNews != nil {
            strHeading = selectedCityNews?.heading ?? ""
            strHeadingOne = selectedCityNews?.subHeadingOne ?? ""
            strHeadingTwo = selectedCityNews?.subHeadingTwo ?? ""
            strContent = selectedCityNews?.content ?? ""
        }else if selectedMumbaiNews != nil {
            strHeading = selectedMumbaiNews?.heading ?? ""
            strHeadingOne = selectedMumbaiNews?.subHeadingOne ?? ""
            strHeadingTwo = selectedMumbaiNews?.subHeadingTwo ?? ""
            strContent = selectedMumbaiNews?.content ?? ""
        }else if selectedWorldNews != nil {
            strHeading = selectedWorldNews?.heading ?? ""
            strHeadingOne = selectedWorldNews?.subHeadingOne ?? ""
            strHeadingTwo = selectedWorldNews?.subHeadingTwo ?? ""
            strContent = selectedWorldNews?.content ?? ""
        }
       
        //MARK: SET TEXTVIEW SCRO
        txtViewDescription.isSelectable = true
        txtViewDescription.isUserInteractionEnabled = true
        txtViewDescription.backgroundColor = UIColor(hex: "#1A1A1A")
        txtViewDescription.panGestureRecognizer.allowedTouchTypes = [NSNumber(value: UITouch.TouchType.indirect.rawValue)]
        
        let htmlContent = """
                                         <!doctype html>
                                         <meta charset="utf-8"/>
                                         <meta name="viewport" content="width=device-width, initial-scale=1">
                                         <html>
                                             <head>
                                                 <style>
                                         
                                         .container {
                                           position: relative;
                                         }
                                         
                                                                     blockquote.twitter-tweet { width:100% !important; margin: 5px 10px !important; position: relative !important; left:15px !important; float: right !important;} blockquote.twitter-tweet a { width:100% !important;}
                                         
                                                    
                                         @font-face {
                                                                font-family: 'Hind Vadodara';
                                                                src: url("HindVadodara-Regular.ttf") format('truetype');
                                                            }
                                                            body {
                                                                font-size: 23px;
                                                                font-family: "Hind Vadodara"
                                                            }

                                         
                                         
                                                   img { width: 100% !important; height: auto !important; margin: 5px 10px !important; position: relative !important; left:10px !important; float: right !important;}
                                         
                                                   iframe {position: relative;top: 0;left: 0;max-width: 100%;border: 0;}
                                         
                                                  
                                                              .custom-table table {
                                                                  width: 100% !important;
                                                                  float: none !important;
                                                              }
                                         .custom-table p:empty {
                                                     display: none !important;
                                                 }
                                         
                                         

                                         .custom-table p>br:first-child {
                                         display: none !important}
                                         
                                         .custom-table p:empty {
                                                     display: none !important;
                                                 }

                                         .custom-table p br {
                                         display: none !important}
                                         
                                         .element p {margin-top: 0px;}
                                         .element br {display: none;}

                                                          
                                                 </style>
                                             </head>
                                                  <body>
                                                        <div class="container">
                                                            <div class="element">
                                         
                                            <span class="custom custom-table"><h3><h4 style="color:#FFFFFF;">\(strHeading)</h3></h4>
                                                                                  <h4 style="color:#A94442;">\(strHeadingOne)</h4>
                                                                                <h4 style="color:#A94442;">\(strHeadingTwo)</h4>
                                                                                <h4 style="color:#FFFFFF;">\(strContent)</h4></span>
                                                            </div>
                                                        </div>
                                                    </body>
                                         
                                         
                                         
                                         </html>
                                         """
    
        if let attributedString = htmlContent.htmlToAttributedString {
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: mutableAttributedString.length))
            txtViewDescription.attributedText = attributedString
        } else {
            txtViewDescription.text = htmlContent
        }
        txtViewDescription.panGestureRecognizer.allowedTouchTypes = [NSNumber(value: UITouch.TouchType.indirect.rawValue)]


    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        return try? NSAttributedString(data: data, options: options, documentAttributes: nil)
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
