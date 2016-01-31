//
//  ViewController.swift
//  konachan_client
//
//  Created by 徐晓伟 on 1/29/16.
//  Copyright © 2016 徐晓伟. All rights reserved.
//

import UIKit
import Alamofire

struct Image {
    let url:String
    let id:String

}
class ViewController: UIViewController {
    
    var imag = [Image]()
    var init_num = 0
    @IBOutlet weak var konachanimage: UIImageView!
    @IBOutlet weak var konachanid: UILabel!
    //var imageurlstringarray:NSMutableArray = NSMutableArray()
    //var imageidstringarray:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imag.removeAll()
        let request_server=Alamofire.request(.GET, "http://127.0.0.1:5000/kona/?offset=0&lim=3")
        request_server.responseJSON { (response) -> Void in
            let stringarray:NSArray = response.result.value as! NSArray
            for item in stringarray{
                self.imag.append(Image(url: item["datasrc"] as! String, id: item["dataid"] as! String))
               // self.imageurlstringarray.addObject(item["datasrc"] as! String)
                //self.imageidstringarray.addObject(item["dataid"] as! String)
              //  print(self.imageurlstringarray)

            }
            let url = NSURL(string: self.imag[self.init_num].url)
            let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            self.konachanid.text = self.imag[self.init_num].id
            self.konachanimage.image = UIImage(data: data!)
            print(self.imag.count)
        }
        
        //print(self.imageurlstringarray)
        //print(self.imageidstringarray)
        
       

        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func show(sender: AnyObject) {
        if self.init_num < self.imag.count-1{
            
            print(self.init_num)
            self.init_num = self.init_num + 1
            let url = NSURL(string: self.imag[self.init_num].url)
            let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            self.konachanid.text = self.imag[self.init_num].id
            self.konachanimage.image = UIImage(data: data!)

    
        }
    }
    @IBAction func decrease(sender: AnyObject) {
        if self.init_num > 0 {
            
            print(self.init_num)
            self.init_num = self.init_num-1
            let url = NSURL(string: self.imag[self.init_num].url)
            let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            self.konachanid.text = self.imag[self.init_num].id
            self.konachanimage.image = UIImage(data: data!)
            
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



