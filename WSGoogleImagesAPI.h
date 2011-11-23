//
//  WSGoogleImagesAPI.h
//  Test
//
//  Created by Fabio L Brandao FH on 07/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VOSearch.h"

@interface WSGoogleImagesAPI : NSObject <UIAlertViewDelegate>{    
    NSURLConnection *_connection;
    NSMutableData *receivedData;
    NSMutableArray *_imagemArray;
    NSMutableArray *_uRLNames;
    NSMutableArray *_uRLFonts;
    
    NSMutableArray *_vOSearchArray;
    VOSearch *_vOSearch;
}

@property (nonatomic, retain) NSMutableArray *vOSearchArray;

- (void)syncImagensDownload:(NSString *)texto;
- (NSString *)fixSearchKeyWhenItContainsSpaceChars:(NSString *)searchKey;

@end
