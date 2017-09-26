# SamsClubHW

**SamsClubHW** is a part of the WalmartLabs job interview phone screen.

Task:  Create a new application with WalmartLabs Code Test API integrated. The application should have the following screens.

Time spent: **10** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] First screen should contain a List of all the products returned by the Service call.
- [X] The list should support Lazy Loading. When scrolled to the bottom of the list, start lazy loading next page of products and append it to the list.

The following **optional** features are implemented:
- [X] Second screen should display details of the product.
- [X] Ability to swipe to view next/previous item ( Eg: Gmail App)


The following **Highlights** features are implemented:

ARCHITECTURE
- [X] Employing **MVVM** architecture which off loads UIKit agnostic code from View Controllers.
- [X] Using property observer patters like REACT without subclassing NSObject for KVO.
- [X] **Unit-testing** coverage of Network, Model, and even business logic layer thanks to MVVM.
- [X] Use of Swift Protocols as type to enable mock data during testing also inheritance.
- [X] The TableViewCell and Product Detail View Controller actually use the same View Model!
- [X] A singleton to host all networking code, but is **dependency injected** instead of simply called.
- [X] **No Cocoapod** or 3rd party framework to demenstrate knowledge.

VIEW
- [X] View building with autolayout using storyboard, xib, and programmatically.
- [X] Self sizing dynamic height in UITableView.
- [X] UIStackView.
- [X] Custom UIAnimation
- [X] Gesture Recognizers

NETWORKING
- [X] Use of **URLSession and lazy image downloading**.
- [X] 100% **Unit-Test coverage**.


## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://user-images.githubusercontent.com/5937001/30877940-2eb482c2-a2b0-11e7-9e2c-cc7b4c194367.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

Becuase this is an interview, I try to demenstrate as much raw knowledge as possible.  I'm all for having help from reputable pods and 3rd party framework but here I try to make as many thing manually as possible.  I also make sure I challenge myself in everyone of these interview homework and do something I'm unfamiliar with.  

For this assignment I choose to continue developing my skills to architecture apps to improve testability and reuseable code.  I recently fell in love with MVVM even though it has it's downside of 2x amount of files and a observer plus reaction block patter that can be unconventional.  While it can be an overkill this particular assignment and I've be critizied as such.  User isn't really mutating data so there isn't much the app needs to "REACT." However if one look into the Unit-Test file it should be obvious the benifit of breaking business logic code out of the ViewController and now it can be covered by Unit-Test.  With this inmind I choose to take it easy on the design and Animation part of the app, but still demenstrating baseline knowledge.

Autolayout within a UIStackView can be very tricky and easy to create conflicting constraints that only show up at runtime. 


## License

    Copyright [2016] [Chi Hwa Ting]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

