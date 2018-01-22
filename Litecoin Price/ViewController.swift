//
//  ViewController.swift
//  Litecoin Price
//
//  Created by Carter Belisle on 11/8/17.
//  Copyright © 2017 Carter B. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var PriceLabel: UILabel!
    @IBOutlet var HighPriceLabel: UILabel!
    
    @IBOutlet var priceChangeLabel: UILabel!
    
    @IBOutlet var FPODPriceLabel: UILabel!
    @IBOutlet var AveragePriceLabel: UILabel!
    @IBOutlet var LowPriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.priceChangeLabel.layer.cornerRadius = 8
        getStats()
        getChangeFrom1H()
        getPrice()
        
    }
    func getStats() {
        let jsonUrlString = "https://www.bitstamp.net/api/v2/ticker_hour/ltcusd/"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                //print(json)
                let priceOfLitecoin = json["last"]!
                let priceOfLitecoinUSD = "$" + "\(priceOfLitecoin)"
                let ltcHigh24h = json["high"]!
                let ltcHigh24hUSD = "$" + "\(ltcHigh24h)"
                let ltcLow24h = json["low"]!
                let ltcLow24hUSD = "$" + "\(ltcLow24h)"
                let ltcAveragePrice = json["vwap"]!
                let ltcAveragePriceUSD = "$" + "\(ltcAveragePrice)"
                let ltcVolume = json["volume"]!
                
                let ltcVolumeAsInt = (ltcVolume as! NSString).intValue
                let ltcVolumeUSD = "$" + "\(ltcVolumeAsInt)"
                
                DispatchQueue.main.async(execute: {
                    
                    self.HighPriceLabel.text = ltcHigh24hUSD
                    self.LowPriceLabel.text = ltcLow24hUSD
                    self.AveragePriceLabel.text = ltcAveragePriceUSD
                    self.FPODPriceLabel.text = ltcVolumeUSD
                    
                })
                
                
            }catch let jsonErr {
                print("Error Serializing.", jsonErr)
            }
            
            
            
            
            
            }.resume()
    }
    
    func getPrice() {
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
    
    func getChangeFrom1H () {
        
        let jsonUrlString = "https://api.cryptonator.com/api/ticker/LTC-usd"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                
                let ticker = json["ticker"] as! [String :Any]
                
                let change = ticker["change"]
                let changeInt = (change as! NSString).doubleValue
                let numberOfPlaces = 2.0
                let multiplier = pow(10.0, numberOfPlaces)
                let changeRounded = round(changeInt * multiplier) / multiplier
                let changeUSD = "$" + "\(changeRounded)"
                
                DispatchQueue.main.async(execute: {
                    if (changeInt > 0) {
                        self.priceChangeLabel.text = "▲ " + changeUSD
                        
                    } else {
                        self.priceChangeLabel.text = "▼ " + changeUSD
                        
                    }
                    
                    
                })
                
                
            }catch let jsonErr {
                print("Error Serializing.", jsonErr)
            }
            
            
            
            
            
            }.resume()
    
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func refreshClicked(_ sender: Any) {
        print("clicked")
        getChangeFrom1H()
        sleep(UInt32(0.5))
        getStats()
        sleep(UInt32(0.5))
        getPrice()
        sleep(UInt32(0.5))
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

