//
//  ViewController.m
//  ObjC-Example
//
//  Created by Ovidiu Rotaru on 18.08.2022.
//

#import "ViewController.h"
#import <ClearentIdtechIOSFramework/ClearentIdtechIOSFramework.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initalize the SDK UI with needed info to work properly
    // ! Make sure you update the baseURL and apiKey with the correct values in order to test the SDK !
    NSString* baseURL = @"test_baseurl";
    NSString* apiKey = nil;
    
    NSData* encryptedKey = [Crypto SHA256hashWithData:[@"some_secret_here" dataUsingEncoding: NSUTF8StringEncoding]];
    ClearentUIManagerConfiguration* uiManagerConfig = [[ClearentUIManagerConfiguration alloc]
                                                       initWithBaseURL:baseURL
                                                       apiKey:apiKey
                                                       publicKey:nil
                                                       offlineModeEncryptionKeyData:encryptedKey
                                                       enableEnhancedMessaging:false
                                                       tipAmounts:@[@15, @18, @20]
                                                       signatureEnabled:true];
    [[ClearentUIManager shared] initializeWith:uiManagerConfig];

    [UIFont loadFontsWithFonts:[NSArray arrayWithObjects: @"SF-Pro-Display-Bold.otf", @"SF-Pro-Text-Bold.otf", @"SF-Pro-Text-Medium.otf", nil] bundle:ClearentConstants.bundle];
}

- (IBAction)showSettings:(id)sender {
    UIViewController *vc = [[ClearentUIManager shared] settingsViewControllerWithCompletion:^(ClearentError* error) {
        //do something that you want on dismiss
        if (error != nil) {
            NSLog(@"❗️Something went wrong");
        }
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)startPairing:(id)sender {
    UIViewController *vc = [[ClearentUIManager shared] pairingViewControllerWithCompletion:^(ClearentError* error) {
        //do something that you want on dismiss
        if (error != nil) {
            NSLog(@"❗️Something went wrong");
        }
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)startCardReaderTransaction:(id)sender {
    [ClearentUIManager shared].cardReaderPaymentIsPreferred = true;
    PaymentInfo *paymentInfo = [[PaymentInfo alloc] initWithAmount:20.00 customerID:nil invoice:nil orderID:nil billing:nil shipping:nil softwareType:nil webAuth:nil];
    UIViewController *vc = [[ClearentUIManager shared] paymentViewControllerWithPaymentInfo:paymentInfo completion:^(ClearentError* error) {
        //do something that you want on dismiss
        if (error != nil) {
            NSLog(@"❗️Something went wrong");
        }
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)startManualTransaction:(id)sender {
    [ClearentUIManager shared].cardReaderPaymentIsPreferred = false;
    PaymentInfo *paymentInfo = [[PaymentInfo alloc] initWithAmount:30.00 customerID:nil invoice:nil orderID:nil billing:nil shipping:nil softwareType:nil webAuth:nil];
    UIViewController *vc = [[ClearentUIManager shared] paymentViewControllerWithPaymentInfo:paymentInfo completion:^(ClearentError* error) {
        //do something that you want on dismiss
        if (error != nil) {
            NSLog(@"❗️Something went wrong");
        }
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
