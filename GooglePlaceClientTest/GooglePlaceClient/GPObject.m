//
//  GPObject.m
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GPObject.h"

@implementation GPObject

@synthesize properties = _properties;

-(void)dealloc{
    self.properties = nil;
    [super dealloc];
}

+(id)objWithProperties:(NSDictionary *)properties{
    id obj = [[[self alloc] init] autorelease];
    ((GPObject*)obj).properties = properties;
    
    return obj;
}

@end
