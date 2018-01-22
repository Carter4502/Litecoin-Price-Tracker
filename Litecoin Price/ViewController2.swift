//
//  ViewController2.swift
//  Litecoin Price
//
//  Created by Carter Belisle on 11/10/17.
//  Copyright © 2017 Carter B. All rights reserved.
//

import Foundation
import UIKit
class ViewController2: UIViewController {
    @IBOutlet var PriceLabel: UILabel!
    @IBOutlet var myWebView2: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPriceandURL()
    }
    func getPriceandURL() {
        let Weburl = URL(string: "http://www.savage.ws/index2.html")
        myWebView2.loadRequest(URLRequest(url: Weburl!))
        
        let jsonUrlString = "https://min-api.cryptocompare.com/data/price?fsym=LTC&tsyms=USD"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                //print(json)
                let priceOfLitecoin = json["USD"]!
                let priceOfLitecoinUSD = "$" + "\(priceOfLitecoin)"
                
                
                
                DispatchQueue.main.async(execute: {
                    self.PriceLabel.text = priceOfLitecoinUSD
                    
                })
                
                
            }catch let jsonErr {
                print("Error Serializing.", jsonErr)
            }
            
            
            
            
            
            }.resume()
        
    }
    
    @IBAction func refreshClicked(_ sender: Any) {
        getPriceandURL()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
}
