# did-motif-ios

# Usage

render DID Motif:

1. add view 

```
let motifView = DIDMotifView()
motifView.frame = CGRect(x: 0, y: 0, width: 40, height: 40) 
// recomend to set size as square.
// DIDMotif will render it as it real shape

```

2.  render

```
motifView.renderWith(address: "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3", shape: DIDMotifShage.square)
```
