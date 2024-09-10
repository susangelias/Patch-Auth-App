# Patch_ios

## Build Steps on MacOS

1. Clone repo
2. Install dependency manager on laptop if not already installed
    * Open Terminal
    * Enter `sudo gem install cocoapods`  
    Note: this worked on Mac OS 11.5 Big Sur but with a later OS this maybe changed.  See cocoapods.org for latest install instructions.
3. Install dependencies
    * In Terminal navigate to patch/ios/patch_ios
    * Enter `pod install`
4. Install IDE
    * XCode from App Store - this is a big install (11.7 GB).  Make sure there is as least 25GB of free disk space and allow for 1 - 2 hours for install to complete.
5.  Build patch_ios from XCode
    * Launch XCode
    * Open `patch_ios.xcworkspace`
    * If running on a device, plug the device into your laptop.  It will showup in the list of Devices & Simulators.  If running in the simulator, select one from the list.
    * Tap the play button or from menu Product -> Run




