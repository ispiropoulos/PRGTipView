# PRGTipView

[![Version](https://img.shields.io/cocoapods/v/PRGTipView.svg?style=flat)](https://cocoapods.org/pods/PRGTipView)
[![License](https://img.shields.io/cocoapods/l/PRGTipView.svg?style=flat)](https://cocoapods.org/pods/PRGTipView)
[![Platform](https://img.shields.io/cocoapods/p/PRGTipView.svg?style=flat)](https://cocoapods.org/pods/PRGTipView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 10+
- Swift 5

## Installation

PRGTipView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PRGTipView'
```

## Usage

```swift
let config = PRGTipViewConfiguration()
       config.titleText = "This is a title"
       config.detailText = "This is the detail text, that adds more information to your tip."
       config.buttonText = "OK"
       config.focusView = button
       config.focusInsets = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
       config.focusDistance = 50
       config.circularFocus = false
       config.animateIn = true
       config.animateOut = true

       TipView.show(fromViewController: self, withConfiguration: config, completion: nil)
```

## Author

John Spiropoulos, jspiropoulos@programize.com

## License

PRGTipViewis made for [Programize LLC](https://www.programize.com) by John Spiropoulos and it is available under the MIT license.
