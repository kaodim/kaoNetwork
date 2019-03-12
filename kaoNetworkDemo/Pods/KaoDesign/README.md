<p align="center">
  <img src="https://github.com/kaodim/kaodimDesignIos/blob/documentation/Screenshot/kaodim-logo.png" width=400 />
</p>

----------------
## iOS Design Library
#### Inspired by the Design Components 

|  | Design Components  |
---|-----------------
🐶 | KaoBarPagerTabStripViewController
🐱 | KaoBaseViewController
🐭 | KaoNavigationController
🐹 | KaoNotificationBanner
🐰 | KaoLabel
🦊 | KaoButton
🐻 | KaoLineView
🐼 | KaoLinkButton
🐨 | KaoRatingView
🐯 | KaoSpinningView
🦁 | KaoDateTimePicker
🐮 | KaoModalDialogView
🐸 | KaoInfoView
🐵 | KaoNoSearchFound
🐔 | KaoNotificationBannerView
🐧 | Tool Tips

Kaodim iOS Design Library is a library that contains most of the design components of Kaodim.

## Installation

Add the following line of code inside your **Podfile** and `pod install`.

```bash
// top of the file
source 'https://auyotoc@bitbucket.org/kaodim/kaococoapods.git'
source 'git@github.com:kaodim/KaoCocoaPods.git'

// inside def default_pods
pod 'KaoNotification'
```


## Usage

```swift
import KaoDesign
```

## KaoLabel
You can configure the **font**, **size** and **color** using KaoLabel.
```swift
@IBOutlet private weak var title: KaoLabel!

title.font = .kaoFont(style: .regular, size: .small)
title.textColor = .kaoColor(.jellyBean)
```

## KaoButton
You can configure to show the standardized button based with the type of **primary(Default)**, **secondary**, **text only** or **link button**.

![](https://github.com/kaodim/kaodimDesignIos/blob/documentation/Screenshot/KaoButton.png)

## KaoInfoView
You can configure to show the standardized info with the type of **standard**, **only icon**, **only icon and one button** or **only icon and two buttons**.

![](https://github.com/kaodim/kaodimDesignIos/blob/documentation/Screenshot/KaoInfoView.png)

## KaoNotificationBanner

![](https://github.com/kaodim/kaodimDesignIos/blob/documentation/Screenshot/KaoNotificationBanner.png)

You can configure the message
```swift
KaoNotificationBanner.shared.dropNotification(message: "Receipt generated and sent to customer successfully. Job moved to Request history.")
```

![](https://github.com/kaodim/kaodimDesignIos/blob/documentation/Screenshot/KaoNotificationBanner%20-%20Success.png)


You can configure the success message or error message.

```swift
dropSuccessMessage("Receipt generated and sent to customer successfully. Job moved to Request history.")
```
![](https://github.com/kaodim/kaodimDesignIos/blob/documentation/Screenshot/KaoNotificationBanner%20-%20Error.png)

```swift
dropErrorMessage("This is an error message")
```

## Tool Tips
You can configure the message for tool tips.

![](https://github.com/kaodim/kaodimDesignIos/blob/documentation/Screenshot/ToolTip.png)

## KaoModalDialogView

You can configure the **image**, **title**, **message**, **first button** or **second button**.

![](https://github.com/kaodim/kaodimDesignIos/blob/documentation/Screenshot/KaoModalDialogView.png)

## KaoSpinningView

![](https://github.com/kaodim/kaodimDesignIos/blob/documentation/Screenshot/Spinner.gif)

You can show the animation of spinner and configure the color.

```swift
private lazy var spinner: UIView = {
  let spinningView = KaoSpinningView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
  spinningView.tintColor = UIColor.kaoColor(.crimson, alpha: 0.5)
  spinningView.show()
  return spinningView
}()
```


## Contributing
### KaoDesign Step by Step

1. Make sure all changes is done and committed
2. Bump `s.version` under **kaoDesign.podspec** file, then commit push
3. Go to kaoDesign github repo and create release note with the same version number as the previous s.version under podspec file
4. Publish the release note
5. Execute `pod repo push kaococoapods --swift-version=4.0 --allow-warnings KaoDesign.podspec` on terminal

### KaoNotification Step by Step

1. Switch to `kaoNotification` repo and bump `s.version` under **kaoNotification.podspec** file and bump `s.dependency` for **kaoDesign** to be equals to the latest version
2. Commit and push
3. Go to **kaoNotification** github repo and create release note with the same version number as the previous `s.version` under **podspec** file
4. Publish the release note
5. Execute `pod repo push kaococoapods --swift-version=4.0 --allow-warnings KaoNotification.podspec`

## License
[MIT](https://choosealicense.com/licenses/mit/)
