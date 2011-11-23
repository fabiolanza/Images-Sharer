//
//  DatabaseAPI.h
//  Test
//
//  Created by Fabio L Brandao FH on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "/usr/include/sqlite3.h"

@interface DatabaseAPI : NSObject{
    NSString *_databasePath;
    NSString *_plist;
    sqlite3 *_imagesDB;
}

- (void)createDatabase;

@end
