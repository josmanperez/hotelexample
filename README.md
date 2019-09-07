![HostelWorld](https://i.imgur.com/142YmBW.png)

HostelWord is a project to demonstrate the use of several components within iOS framework 

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](https://github.com/Alamofire/Alamofire/blob/master/Documentation/Usage.md#using-alamofire)
- [License](#license)

## Features

- [x] Retrieve real data from a server (powered by http://docs.practical3.apiary.io/.)
- [x] Converts JSON data into objects using Codable library.
- [x] Displays data on two differents screens (property list table view and a detail view controller).
- [x] Uses Apple MapKit to display the location of the property.

## Requirements

- iOS 11.0+
- Xcode 10.2+
- Swift 5+

## Installation

Download or clone the project and run.

```
pod install
```

## Usage

Once starting the app it will retrieve a fixed list of properties and will convert those properties into objects using `Decodable` library. 
If you click on one property it will retrieve detailed information about that property that will display it on screen. 
Uses `MapKit` to show the location of the property on a map.
Uses a `CollectionView` to show a list of images associated with that particular property.
Uses a dynamic `StackView` to show property amenities that are within that property.

## License

Open Source example project
