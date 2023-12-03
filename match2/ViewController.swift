//
//  ViewController.swift
//  match2
//
//  Created by Sanzhar Kiyassov on 27.11.2023.
//

import UIKit

// только у меня еще один баг появился, я когда допустим нажал на две кнопки, и они были неправильные, то при нажатий на последнюю повторно сендер не работает

class ViewController: UIViewController {
    var cards = ["1","3","8","6","7","2","4","5",
                 "4","2","3","8","5","6","7","1"]
    
    var isOpened = false
    var lastButtonTag = 0
    
    var matchButtons: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func game(_ sender: UIButton) {
    
        if matchButtons.contains(sender.tag) == false && lastButtonTag != sender.tag {
            let tag = sender.tag
            let image = cards[tag - 1]
            let lastButtonTag2 = lastButtonTag
           // print("last button2 = \(lastButtonTag2)")
            
            
            sender.setBackgroundImage(UIImage(named: image), for: UIControl.State.normal)
            
            if isOpened == true{
                let lastImage = cards[lastButtonTag2 - 1]
                
                if lastImage == image {
                    matchButtons.append(tag)
                    matchButtons.append(lastButtonTag2)
                    
                    
                    if matchButtons.count == 16 {
                        //print("game over")
                        let alert = UIAlertController(title: "Game over", message: "", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default,handler:{ UIAlertAction in self.printWinAlert()
                            }))
                        
                        
                        present(alert, animated: true, completion: nil)
                        
                        printWinAlert()
                        
                    }
                    
                    
                }else{
                    
                    view.isUserInteractionEnabled = false
                    
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                        sender.setBackgroundImage(nil, for: .normal)
                        let lastButton = self.view.viewWithTag(lastButtonTag2) as! UIButton
                        lastButton.setBackgroundImage(nil, for: .normal)
                        
                        self.view.isUserInteractionEnabled = true
                    }
                    
                }
                
            }
            
            lastButtonTag = tag
            isOpened.toggle()
            //print("lastButton = \(lastButtonTag)")
        }
        
    }
        
    func printWinAlert() {
        // сброс
        
       
        cards = ["1","3","8","6","7","2","4","5",
                 "4","2","3","8","5","6","7","1"]
        isOpened = false
        lastButtonTag = 0
        matchButtons = []

        
        for tag in 1...16 {
            let button = self.view.viewWithTag(tag) as! UIButton
            button.setBackgroundImage(nil, for: .normal)
        }
    }
    
    }
    



