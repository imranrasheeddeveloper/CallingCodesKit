//
//  CallingCodesVC.swift
//
//  Created by Muhammad Imran on 02/12/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

public protocol callingCodeData : class{
    func countryCodeAndFlag(name : String , flag : String, code : String, dialCode :String)
}

final public class CallingCodesVC: UIViewController,UISearchResultsUpdating {

    public var  name, flag, code, dialCode: String?
    /// ISO code of the country that should appear first in the list.
    public var defaultCountryISOCode: String?
    public weak var delegate : callingCodeData?
    let tableview  = UITableView()
    var countriesCallingCodeArray = [CountryCallingCode_Data]()
    var filteredTableData = [CountryCallingCode_Data]()
    var resultSearchController = UISearchController()
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        self.definesPresentationContext = true
        contreisCallingCodes()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(CountryCallingCodeCell.self, forCellReuseIdentifier: "CountryCallingCodeCell")
    }
    func setupView() {
        self.view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.dimsBackgroundDuringPresentation = false
            tableview.tableHeaderView = controller.searchBar
            return controller
        })()
        
    }
    
    func contreisCallingCodes() {
        ContryJsonData.loadData { [self] (data) in
            countriesCallingCodeArray = data.countries!

            // Move the default country to the top if provided
            if let iso = defaultCountryISOCode?.lowercased(),
               let index = countriesCallingCodeArray.firstIndex(where: { $0.code?.lowercased() == iso }) {
                let value = countriesCallingCodeArray.remove(at: index)
                countriesCallingCodeArray.insert(value, at: 0)
            }

            DispatchQueue.main.async {
                tableview.reloadData()
            }
        }
    }
}

extension CallingCodesVC  : UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.isActive{
            return filteredTableData.count
        }
        else{
            return countriesCallingCodeArray.count
        }
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CountryCallingCodeCell", for: indexPath) as! CountryCallingCodeCell
        if resultSearchController.isActive{
            cell.flag.text = filteredTableData[indexPath.row].flag
            cell.CountryName.text = filteredTableData[indexPath.row].name
            cell.CountryCallingCode.text = filteredTableData[indexPath.row].dialCode!
        }
        else{
            cell.flag.text = countriesCallingCodeArray[indexPath.row].flag
            cell.CountryName.text = countriesCallingCodeArray[indexPath.row].name
            cell.CountryCallingCode.text = countriesCallingCodeArray[indexPath.row].dialCode!
        }
        
        
        return cell
        
        
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if resultSearchController.isActive{
            delegate?.countryCodeAndFlag(name: filteredTableData[indexPath.row].name!, flag: filteredTableData[indexPath.row].flag!, code: filteredTableData[indexPath.row].code!, dialCode: filteredTableData[indexPath.row].dialCode!)
        }
        else{
            
            delegate?.countryCodeAndFlag(name: countriesCallingCodeArray[indexPath.row].name!, flag: countriesCallingCodeArray[indexPath.row].flag!, code: countriesCallingCodeArray[indexPath.row].code!, dialCode: countriesCallingCodeArray[indexPath.row].dialCode!)
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        if let searchText = searchController.searchBar.text?.lowercased() {
            if searchText.count == 0 {
                filteredTableData = countriesCallingCodeArray
            }
            else {
                filteredTableData = countriesCallingCodeArray.filter {
                    ($0.name?.lowercased().contains(searchText) ?? false) ||
                    ($0.dialCode?.lowercased().contains(searchText) ?? false) ||
                    ($0.code?.lowercased().contains(searchText) ?? false)
                }
            }
        }
        DispatchQueue.main.async { [self] in
            tableview.reloadData()
        }
        
    }
    
}

open class ContryJsonData{
    static func loadData(compltionalHandler : @escaping(CountryCallingCodeModel)->()) {
        var bundles: [Bundle] = []

        #if SWIFT_PACKAGE
        bundles.append(Bundle.module)
        #endif

        let myBundle = Bundle(for: Self.self)
        bundles.append(myBundle)

        if let bundleURL = myBundle.url(forResource: "CallingCodesKit", withExtension: "bundle"),
           let resourceBundle = Bundle(url: bundleURL) {
            bundles.append(resourceBundle)
        }

        bundles.append(Bundle.main)

        for bundle in bundles {
            if let jsonURL = bundle.url(forResource: "CountryCallingCode", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: jsonURL)
                    let callingCodes = try JSONDecoder().decode(CountryCallingCodeModel.self, from: data)
                    compltionalHandler(callingCodes)
                    return
                } catch {
                    continue
                }
            }
        }

        // In case of failure return an empty model to avoid crashing.
        print("Failed to load CountryCallingCode.json")
        compltionalHandler(CountryCallingCodeModel(countries: []))
    }

    /// Returns all countries synchronously.
    public static func allCountries() -> [CountryCallingCode_Data] {
        var result: [CountryCallingCode_Data] = []
        loadData { model in
            result = model.countries ?? []
        }
        return result
    }

    /// Finds a country using its ISO code.
    public static func country(forISOCode code: String) -> CountryCallingCode_Data? {
        allCountries().first { $0.code?.lowercased() == code.lowercased() }
    }

    /// Finds a country using its dial code (e.g. "+1").
    public static func country(forDialCode dialCode: String) -> CountryCallingCode_Data? {
        allCountries().first { $0.dialCode == dialCode }
    }

    /// Returns the country matching the current device locale.
    public static func currentCountry() -> CountryCallingCode_Data? {
        guard let region = Locale.current.regionCode else { return nil }
        return country(forISOCode: region)
    }

    /// Returns the default country. If an ISO code is provided, it is used,
    /// otherwise the device locale is consulted.
    public static func defaultCountry(isoCode: String? = nil) -> CountryCallingCode_Data? {
        if let code = isoCode {
            return country(forISOCode: code)
        }
        return currentCountry()
    }

    /// Convenience: returns the dial code for the specified ISO code.
    public static func dialCode(forISOCode code: String) -> String? {
        country(forISOCode: code)?.dialCode
    }
}

// MARK: - CountryCallingCodeModel
public struct CountryCallingCodeModel: Codable {
    let countries: [CountryCallingCode_Data]?
}

// MARK: - CountryCallingCode_Data
public struct CountryCallingCode_Data: Codable {
    let name, flag, code, dialCode: String?
    
    enum CodingKeys: String, CodingKey {
        case name, flag, code
        case dialCode = "dial_code"
    }
}

extension CountryCallingCode_Data: Identifiable {
    public var id: String { code ?? UUID().uuidString }
}

