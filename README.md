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

2. Render with specific shape

```
motifView.renderWith(address: "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3", shape: .square)

motifView.renderWith(address: "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3", shape: .circle)
        
motifView.renderWith(address: "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3", shape: .rectangle)
        
motifView.renderWith(address: "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3", shape: .hexagon)
```
![image](https://user-images.githubusercontent.com/13864988/159204677-43d31052-84d4-47e1-9e88-380de56643ab.png)
![image](https://user-images.githubusercontent.com/13864988/159204740-6a8d90d9-bd51-4763-8a54-befc14bd7553.png)
![image](https://user-images.githubusercontent.com/13864988/159204697-e93fcb40-4699-4ba0-a412-5d6f012b5ba5.png)
![image](https://user-images.githubusercontent.com/13864988/159204706-417383eb-551a-4c23-b14d-3157830fd829.png)


3. Render with origin shape by DID

```
// DApp
motifView.renderWith(address: "zNKeLKixvCM32TkVM1zmRDdAU3bvm3dTtAcM", shape: nil)

// TOKEN: PLAY 3
motifView.renderWith(address: "z35n3kwEXMakjzfaf24DLd67dTJRByTf8y1FN", shape: nil)
        
// Account
motifView.renderWith(address: "z1imdeFgjsR7n1PhBpyW7uu1zr617sCN64x", shape: nil)
        
// NFT
motifView.renderWith(address: "zjdov4taExQmjyFV4Jt5YPGF5yVUg57pPtQY", shape: nil)
```
![image](https://user-images.githubusercontent.com/13864988/159204842-6ca5e443-8786-4bee-9f2c-3f9a510e298b.png)
![image](https://user-images.githubusercontent.com/13864988/159204780-b929e0e1-96a4-43a5-8450-4d30c66194b0.png)
![image](https://user-images.githubusercontent.com/13864988/159204868-f221845a-6ff3-4f76-ba69-a23c943883c5.png)
![image](https://user-images.githubusercontent.com/13864988/159204795-07f7d4b3-142f-44f1-b905-c3d2f19a01be.png)


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
