# CallingCodesKit

[![CI Status](https://img.shields.io/travis/imranrasheeddeveloper/CallingCodesKit.svg?style=flat)](https://travis-ci.org/imranrasheeddeveloper/CallingCodesKit)
[![Version](https://img.shields.io/cocoapods/v/CallingCodesKit.svg?style=flat)](https://cocoapods.org/pods/CallingCodesKit)
[![License](https://img.shields.io/cocoapods/l/CallingCodesKit.svg?style=flat)](https://cocoapods.org/pods/CallingCodesKit)
[![Platform](https://img.shields.io/cocoapods/p/CallingCodesKit.svg?style=flat)](https://cocoapods.org/pods/CallingCodesKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. The country code data is bundled with the framework so no additional setup is required.

## Installation

CallingCodesKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CallingCodesKit'
```

## Usage

![Setup](https://user-images.githubusercontent.com/51517176/101093513-b4f58a80-35dc-11eb-82db-156949edb28f.gif)


```
import CallingCodesKit

class ViewController: UIViewController, callingCodeData
   
  {
    @IBOutlet weak var textLabel : UILabel!
    func countryCodeAndFlag(name: String, flag: String, code: String, dialCode: String) {
        textLabel.text = "\(flag) \(name) \(dialCode)"
    }
    @objc func callingCodeVC(){
        let vc = CallingCodesVC()
        vc.defaultCountryISOCode = "US" // show United States first
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(callingCodeVC))
        textLabel.addGestureRecognizer(tap)    
    }
 }
```

### SwiftUI

```swift
import SwiftUI
import CallingCodesKit

struct ContentView: View {
    @State private var selected: CountryCallingCode_Data?

    var body: some View {
        NavigationView {
            VStack {
                if let value = selected {
                    Text("\(value.flag ?? "") \(value.name ?? "") \(value.dialCode ?? "")")
                }
                NavigationLink("Select Country") {
                    CallingCodesListView(defaultCountryISOCode: "US") { country in
                        selected = country
                    }
                }
            }
            .navigationTitle("Example")
        }
    }
}
```


### Programmatic Utilities

You can fetch calling code information without presenting any UI:

```swift
// Get all available countries
let allCountries = ContryJsonData.allCountries()

// Lookup by ISO code or dial code
let us = ContryJsonData.country(forISOCode: "US")
let plusOne = ContryJsonData.country(forDialCode: "+1")

// Country for the current device locale
let current = ContryJsonData.currentCountry()
```

### Default Country

Both the view controller and the SwiftUI list let you specify a country that
should appear at the top when presented. Simply set the `defaultCountryISOCode`
property (or initializer parameter) to the desired ISO code.


## Screenshot

![IMG_9763](https://user-images.githubusercontent.com/51517176/101086856-465fff00-35d3-11eb-82a1-c8f0aa7a944c.PNG)

## Author

imranrasheeddeveloper, imranrasheed.developer@outlook.com

## License

CallingCodesKit is available under the MIT license. See the LICENSE file for more info.
