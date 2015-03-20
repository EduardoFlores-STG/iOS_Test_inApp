//
//  ViewController.h
//  Test_InApp
//
//  Created by Eduardo Flores on 3/17/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface ViewController : UIViewController <SKPaymentTransactionObserver, SKProductsRequestDelegate>
{
    SKPaymentQueue *defaultQueue;
    SKProduct *product;
}

@property (weak, nonatomic) IBOutlet UILabel *label_status;
@property (weak, nonatomic) IBOutlet UIButton *button_level2;

- (IBAction)button_buyLevel2:(id)sender;
- (IBAction)button_useLevel2:(id)sender;
@end