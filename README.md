# CallingCodesKit

[![CI Status](https://img.shields.io/travis/imranrasheeddeveloper/CallingCodesKit.svg?style=flat)](https://travis-ci.org/imranrasheeddeveloper/CallingCodesKit)
[![Version](https://img.shields.io/cocoapods/v/CallingCodesKit.svg?style=flat)](https://cocoapods.org/pods/CallingCodesKit)
[![License](https://img.shields.io/cocoapods/l/CallingCodesKit.svg?style=flat)](https://cocoapods.org/pods/CallingCodesKit)
[![Platform](https://img.shields.io/cocoapods/p/CallingCodesKit.svg?style=flat)](https://cocoapods.org/pods/CallingCodesKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
1-Go to Pods 
2-Select Target CallingCodesKit
3-Click on build Phase
4-Click on Copy Bundel Resources
5-click on + Button
6- In CallingCodesKit Section You can find out Resources folder
7- Select CountryCallingCode.json
8-click add
for more Details please See the video in Usage Section 
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


## Screenshot

![IMG_9763](https://user-images.githubusercontent.com/51517176/101086856-465fff00-35d3-11eb-82a1-c8f0aa7a944c.PNG)

## Author

imranrasheeddeveloper, imranrasheed.developer@outlook.com

## License

CallingCodesKit is available under the MIT license. See the LICENSE file for more info.
