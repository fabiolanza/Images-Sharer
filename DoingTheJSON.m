//
//  DoingTheJSON.m
//  Test
//
//  Created by Fabio L Brandao FH on 08/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DoingTheJSON.h"

@implementation DoingTheJSON

+ (NSDictionary *) readingJSON:(NSMutableData *)jsonData {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                          options:kNilOptions error:&error];
    
    
    return json;
}

@end
