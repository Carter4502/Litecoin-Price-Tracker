//
//  ViewController3.swift
//  Litecoin Price
//
//  Created by Carter Belisle on 11/10/17.
//  Copyright © 2017 Carter B. All rights reserved.
//

import Foundation
import UIKit
class ViewController3: UIViewController {
    @IBAction func refreshClicked(_ sender: Any) {
        getPriceandGraph()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPriceandGraph()
        
    }
    func getPriceandGraph() {
        let Weburl = URL(string: "http://www.savage.ws/index3.html")
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
    @IBOutlet var myWebView2: UIWebView!
    @IBOutlet var PriceLabel: UILabel!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    
}
