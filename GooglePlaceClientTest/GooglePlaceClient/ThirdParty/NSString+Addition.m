
//
//  NSString+Addition.m
//  BreezyReader2
//
//  Created by 金 津 on 12-3-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (addition)

-(NSString*)stringByAddingPercentEscapesAndReplacingHTTPCharacter{
    NSString* string = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableString* ms = [[string mutableCopy] autorelease];
    [ms replaceOccurrencesOfString:@"/" 
                          withString:@"%2F"
                             options:NSBackwardsSearch
                               range:NSMakeRange(0, [ms length])];
	[ms replaceOccurrencesOfString:@":" 
                          withString:@"%3A"
                             options:NSBackwardsSearch
                               range:NSMakeRange(0, [ms length])];
    [ms replaceOccurrencesOfString:@"?" 
                          withString:@"%3F"
                             options:NSBackwardsSearch
                               range:NSMakeRange(0, [ms length])];
    
    return ms;
}

@end
