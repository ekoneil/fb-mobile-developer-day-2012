MDD Basic Session app
============================
This repro includes:

1. the complete Xcode 4.5 project of the project built during the iOS basic session
2. a screenshot of the FB dev site settings for the app

To get started:

1. download and install the iOS SDK from: https://developers.facebook.com/ios/
  - in the Getting Started tutorial, follow setup #5 closely when:
  - adding equired frameworks including FacebookSDK and its dependencies (Accounts, AdSupport, Social, and libsqlite3)
  - setting the FacebookAppID in the plist
  - setting the URL Type => Item 0 => URL Schemes => Item 0 => fb{appId} in the plist
2. add the resource bundle:
  - FacebookSDKResources.bundle
3. create a Facebook app at: https://developers.facebook.com/apps
  - add the bundle ID com.facebook.mddbasicsession.MDDBasicSessionApp
  - add an iPhone App Store ID
  - enable Facebook Login
  - enable Deep Linking (not used in this example, but useful later)
4. build
5. run

Please let me know if there are any problems getting up and running.
