//
//  ViewController.swift
//  weatherCoordinates
//
//  Created by Кирилл Крамар on 19.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import CoreLocation
class SearchWeatherViewController: UIViewController {
    
    //MARK : - IB Outlets
    @IBOutlet var coordinatesPadStackView: UIStackView!
    
    @IBOutlet var searchByCoordinatesButton: UIButton!
    @IBOutlet var searchByGeolocationButton: UIButton!
    
    @IBOutlet var latTextField: UITextField!
    @IBOutlet var lonTextField: UITextField!
    
    
    //MARK : - Private Property
    private var coordinates: Coordinate?
    
    //MARK : - Life cycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTypeTextFields(latTextField,lonTextField)
    }
    
    //MARK : - Override Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeather" {
            guard let coordinates = coordinates,
                let weatherShowVC = segue.destination as? WeatherShowTableViewController else {return}
            weatherShowVC.makeRequest(urlString: UrlString.fetchUrlString(lat: coordinates.lat,
                                                                          lon: coordinates.lon))
        }
    }
    
    //MARK : - IB Action
    
    @IBAction func searchByCoordinate() {
        view.endEditing(true)
        guard let lat = double(from: latTextField),
            let lon = double(from: lonTextField) else {return}
        if (0.0...50.0).contains(lat) && (0.0...50.0).contains(lon) {
            coordinates = Coordinate(lat: lat, lon: lon)
            performSegue(withIdentifier: "showWeather", sender: nil)
        } else {
            showAlert(with: "Wrong Coordinates", and: "lat (0-10) ; lon(0-10) ")
            latTextField.text = nil
            lonTextField.text = nil
        }
    }
    
    //MARK : Private Methods
    private func setupTypeTextFields(_ textFields: UITextField...) {
        for var textField in textFields {
            textField.keyboardType = .decimalPad
            setToolBar(textField: &textField)
        }
    }
    private func setToolBar(textField: inout UITextField) {
        let bar = UIToolbar()
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneCoordinates))
        bar.items = [flexible,done]
        bar.sizeToFit()
        textField.inputAccessoryView = bar
    }
    private func double(from textField: UITextField) -> Double? {
        guard let text = textField.text else {return nil}
        return Double(text)
    }
    private func showAlert(with title: String, and message: String){
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert,animated: true)
    }
    //MARK : - Selectors
    @objc func doneCoordinates() {
        view.endEditing(true)
    }
}


//MARK : - TextFieldDelegate

