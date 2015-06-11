# CSPageControl
Simple swift page control with options for various drawn styles or user-supplied images. Usage is based on UIPageControl, but with more control over appearance.

## Enums
CSPageControlStyle defines the available styles for the dots. These styles can be used for either active or inactive states.
```
CSPageControlStyle.Filled     // filled dot
CSPageControlStyle.Outline    // outline dot
CSPageControlStyle.Image      // image-based dot
```

CSPageControlImage defines image names for the included images.
```
CSPageControlImage.StarFilled     // filled star image
CSPageControlImage.StarOutline    // outline star image
```

## Initializers
There are four custom initializers available.
```
CSPageControl(activeStyle: CSPageControlStyle, inactiveStyle: CSPageControlStyle)
CSPageControl(activeStyle: CSPageControlStyle, inactiveStyle: CSPageControlStyle, dotSize: CGFloat, dotSpacing: CGFloat)
CSPageControl(activeImage: UIImage, inactiveImage: UIImage)
CSPageControl(activeImage: UIImage, inactiveImage: UIImage, dotSpacing: CGFloat)
```
There are a few other properties that can be changed or accessed, but these are the basics that define the look of the page control.

## Properties
```
CSPageControl.numberOfPages   // max pages. control adjusts size based on this property
CSPageControl.currentPage     // the current page
CSPageControl.hidesForSinglePage        // carryover from UIPageControl
CSPageControl.defersCurrentPageDisplay  // carryover from UIPageControl

CSPageControl.dotSpacing      // space between the dots - calculated from edges of dots
CSPageControl.dotSize         // dot size
CSPageControl.lineWidth       // stroke width for outline style
CSPageControl.activeStyle     // style of active dot
CSPageControl.inactiveStyle   // style of inactive dot
CSPageControl.activeColor     // color of active dot
CSPageControl.inactiveColor   // color of inactive dots
CSPageControl.activeImage     // image for active dot
CSPageControl.inactiveImage   // image for inactive dots
```
