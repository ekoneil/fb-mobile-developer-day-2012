MDD Basic Session app
============================
This repro includes:

1. the complete Xcode 4.5 project of the project built during the iOS basic session
2. a screenshot of the FB dev site settings for the app

To get started:

1. download and install the iOS SDK from: https://developers.facebook.com/ios/
2. add the following to the project:
  - FacebookSDK framework
  - FacebookSDKResources.bundle
  - FBUserSettingsViewResources.bundle
3. create a Facebook app at: https://developers.facebook.com/apps
  - add the bundle ID com.facebook.mddbasicsession.MDDBasicSessionApp
  - add an iPhone App Store ID
  - enable Facebook Login
  - enable Deep Linking (not used in this example, but useful later)
4. build
5. run

Please let me know if there are any problems getting up and running.
