//
//  FirstTabViewController.h
//  Test
//
//  Created by Fabio L Brandao FH on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/iAd.h"

@interface FirstTabViewController : UIViewController <ADBannerViewDelegate> {
    ADBannerView *adView;
    
    IBOutlet UITextView *brief;
}

@property(nonatomic, retain) IBOutlet ADBannerView *adView;

@end
