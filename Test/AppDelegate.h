//
//  AppDelegate.h
//  Test
//
//  Created by Fabio L Brandao FH on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface AppDelegate : NSObject <UIApplicationDelegate, FBSessionDelegate, FBDialogDelegate>{
    UIWindow *window;
    UITabBarController *rootController;
    Facebook *facebook;
}

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;

@end
