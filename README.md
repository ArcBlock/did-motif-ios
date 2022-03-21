# did-motif-ios

[![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](https://github.com/apple/swift-package-manager)

## Install

#### Swift Package Manager

You can use [Swift Package Manager](https://swift.org/package-manager/) and specify dependency in `Package.swift` by adding this:

```swift
.package(url: "https://github.com/ArcBlock/did-motif-ios.git", .upToNextMajor(from: "1.0.0"))
```

See: [Package.swift - manual](http://blog.krzyzanowskim.com/2016/08/09/package-swift-manual/)

## Usage

Render DID Motif:

1. Add view 

```
let motifView = DIDMotifView()

// recomend to set size as square.
// DIDMotif will render it as it real shape
motifView.frame = CGRect(x: 0, y: 0, width: 40, height: 40) 
```

2. Render

```
motifView.renderWith(address: "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3", shape: DIDMotifShage.square)
```


## License

Copyright 2018-2019 ArcBlock

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
