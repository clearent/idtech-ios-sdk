Try to build a pod containing our framework and the idtech framework.


# Release Notes

2.0.27 - Fix an issue with BITCODE_ENABLED usage. Remove the logic to retry the bluetooth search when
a condition idtech warned us about happens. Instead, just force the disconnect and have the client try the search again.

2.0.25 - trapping more potential exceptions in remote logging to avoid crashes. (framework version 2.0.8)

2.0.24 - improved retry when retrieving the device serial number and firmware version from reader.
started trapping exceptions in remote logging.

2.0.13 - Fixed an issue with our bad swipe solution. IDTech sends back an incomplete card object sometimes on a bad swipe. We already monitor for certain failures so just adding another one. If the framework sees this scenario it will
cancel the transaction and restart a transaction in 2 in 1 mode.

2.0.12 - Fix beep issue.

2.0.11 - Removed extraneous LCD event message callback.

2.0.10 - Use new idtech framework to callback with messages related to audio events.

2.0.9 - Has Clearent IDTech framework 2.0.0. Included simulator architecture for 64 bit

2.0.7 - Has Clearent IDTech framework 2.0.0. Included simulator architecture

2.0.2 - Has Clearent IDTech framework 2.0.0

1.0.100 - Has Clearent IDTech framework 1.1.13

1.0.98 - Code Signing issue fix

1.0.96 - Added Simulator architecture support

1.0.95 - Has clearent idtech framework 1.1.12

1.0.84 - Fixed an issue where the framework was not handling the card data correctly when the user has been presented with the 'USE MAGSTRIPE' message after an invalid insert. The result was an NSInvalidArgumentException being thrown.

1.0.83 - Upgraded pod to use clearent framework release 1.0.26.3. This release has another fix for ios13. It is recommended you upgrade if you are using either audio jack readers or bluetooth readers (VP3300).
