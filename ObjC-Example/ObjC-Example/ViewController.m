//
//  ViewController.m
//  ObjC-Example
//
//  Created by Ovidiu Rotaru on 18.08.2022.
//

#import "ViewController.h"
#import <ClearentIdtechIOSFramework/ClearentIdtechIOSFramework.h>>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startTransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *showReaderDetailsButton;
@property (weak, nonatomic) IBOutlet UIButton *pairNewReaderButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[ClearentUIManager shared] updateWithBaseURL:@"https://gateway-sb.clearent.net"
                                           apiKey:@"27a419e3ecad4d58aa6009b65e66fd81"
                                        publicKey:@"307a301406072a8648ce3d020106092b240303020801010c036200041fcefcdf366991b57f0fccf9efd587d0eee8d8ef8e5c78c17c2766d17a3b44b52bd999da8873e4daa144d76159d98a7f0fd94b65c49580ce134899f3826cd98380927c42fceec6e183a5ed4a064b43fef8507984ac855ca92b0ce32c50264670"];
    
    [[ClearentUIManager shared] setSignatureEnabled:NO];
    
    [UIFont loadFontsWithFonts:[NSArray arrayWithObjects: @"SF-Pro-Display-Bold.otf", @"SF-Pro-Text-Bold.otf", @"SF-Pro-Text-Medium.otf", nil] bundle:ClearentConstants.bundle];
}

- (IBAction)showReaderDetails:(id)sender {
    UIViewController *vc = [[ClearentUIManager shared] readersViewControllerWithCompletion:^(enum ClearentResult result) {
        //do something that you want on dismiss
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)startPairing:(id)sender {
    UIViewController *vc = [[ClearentUIManager shared] pairingViewControllerWithCompletion:^(enum ClearentResult result) {
        //do omething that you want on dismiss
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)startTransaction:(id)sender {
    UIViewController *vc = [[ClearentUIManager shared] paymentViewControllerWithAmount:20.0 completion:^(enum ClearentResult result) {
        //do omething that you want on dismiss
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
