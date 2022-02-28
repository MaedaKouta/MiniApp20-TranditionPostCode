//
//  ViewController.swift
//  MiniApp20-TranditionPostCode
//
//  Created by 前田航汰 on 2022/02/28.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var firsetCodeTextLabel: UITextField!
    @IBOutlet weak var secondCodeTextLabel: UITextField!
    @IBOutlet weak var textLabel: UILabel!

    @IBAction func didTapConvertButton(_ sender: Any) {
        let firstCodeString = firsetCodeTextLabel.text ?? ""
        let secondCodeString = secondCodeTextLabel.text ?? ""

        if firstCodeString.count == 3, secondCodeString.count == 4 {
            convert(firstCode: String(firstCodeString), SecondCode: String(secondCodeString))
        } else {
            self.textLabel.text = "郵便番号が正しく入力されていません。"
        }
    }

    func convert(firstCode: String, SecondCode: String){
        let geocoder = CLGeocoder()
        let postCode = firstCode + "-" + SecondCode
        print(postCode)
        geocoder.geocodeAddressString(postCode, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                self.textLabel.text = "郵便番号が正しく入力されていません。"
                print("Error", error ?? "エラー発生。原因不明")
            }
            if let placemark = placemarks?.first {
                self.textLabel.text = """
                    都道府県: \(placemark.administrativeArea ?? "検索不可")
                    市区町村: \(placemark.locality ?? "検索不可")
                    詳細地域: \(placemark.thoroughfare ?? "検索不可")
                    """
            }
        })
    }

}

