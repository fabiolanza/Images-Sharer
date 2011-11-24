//
//  FirstTabViewController.m
//  Test
//
//  Created by Fabio L Brandao FH on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstTabViewController.h"

@implementation FirstTabViewController
@synthesize adView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    adView.delegate = self;
    
    adView.hidden = true;
    
    brief.text = @"\n\nWelcome to Images Sharer!\n\n1 - Find your images\n\n2 - Select favorite ones\n\n3 - Share with your friends\n\n\n\n\n\nRate us on App Store!";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    self.adView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma
#pragma mark - AdBannerView methods

//- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
//    adView.hidden = true;
//    NSLog(@"Escondendo bannerView");
//}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    adView.hidden = false;
    NSLog(@"Showing bannerView at FirstTab");
}



@end
