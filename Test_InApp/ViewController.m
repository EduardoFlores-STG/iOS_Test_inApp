//
//  ViewController.m
//  Test_InApp
//
//  Created by Eduardo Flores on 3/17/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize label_status, button_level2;

/*
 * App requirements:
 * - In iTunesConnect, create a new sandbox user
 * - A new app must first be created on iTunes connect with the bundle id of this app
 * - Inside the new app on iTunesConnect, you must create a new in-app purchase item. Keep the product id
 * - This app will reference the product id of the in-app purchase to be purchased
 * - Log into a physical device with the sandbox user created to test this application
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    defaultQueue = [SKPaymentQueue defaultQueue];
    [defaultQueue addTransactionObserver:self];
    
    button_level2.enabled = NO;
    button_level2.hidden = YES;
    
    [self getProductInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) getProductInfo
{
    if ([SKPaymentQueue canMakePayments])
    {
        // This object comes from iTunesConnect
        // This is the in-app purchase item created
        NSSet *productID = [NSSet setWithObject:@"com.eduardo.TestInApp.level2"];   // From iTunesConnect in-app product
        SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:productID];
        request.delegate = self;
        [request start];
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self openLevel2];
                [defaultQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [defaultQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [defaultQueue restoreCompletedTransactions];
                [self openLevel2];
                break;
            default:
                break;
        }
    }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    if ([products count] != 0)
    {
        product = [products objectAtIndex:0];
        NSLog(@"product Title = %@", product.localizedTitle);
        NSLog(@"product Description = %@", product.localizedDescription);

        label_status.text = [NSString stringWithFormat:@"%@\n%@", product.localizedTitle, product.localizedDescription];
    }
    
}

- (void) openLevel2
{
    NSLog(@"in openLevel2");
    
    button_level2.enabled = YES;
    button_level2.hidden = NO;
}

- (IBAction)button_buyLevel2:(id)sender
{
    NSLog(@"in button_buyLevel2" );
    
    if (product)
    {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [defaultQueue addPayment:payment];
    }
    else
        NSLog(@"Can't handle payment. Product is null");
    
}

- (IBAction)button_useLevel2:(id)sender
{
    NSLog(@"button_useLevel2 called!");
}
@end















































