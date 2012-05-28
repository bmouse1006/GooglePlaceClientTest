//
//  GPSearchResult.m
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GPSearchResult.h"

@implementation GPSearchResult

@dynamic events, url, icon, coordinate, name, rating, reference, types, vicinity, ID;

+(id)searchResultWithResponseDictionary:(NSDictionary*)responseDictionary{
    return [super objWithProperties:responseDictionary];
}

-(NSArray*)events{
    NSArray* rawEvents = [self.properties objectForKey:@"events"];
    NSMutableArray* events = [NSMutableArray array];
    [rawEvents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop){
        [events addObject:[GPEvent objWithProperties:obj]];
    }];
    
    return events;
}

-(NSString*)url{
    return [self.properties objectForKey:@"url"];
}

-(NSString*)icon{
    return [self.properties objectForKey:@"icon"];
}

-(CLLocationCoordinate2D)coordinate{
    NSDictionary* location = [[self.properties objectForKey:@"geometry"] objectForKey:@"location"];
    return CLLocationCoordinate2DMake([[location objectForKey:@"lat"] doubleValue], [[location objectForKey:@"lng"] doubleValue]);
}

-(NSString*)name{
    return [self.properties objectForKey:@"name"];
}

-(double)rating{
    return [[self.properties objectForKey:@"rating"] doubleValue];
}

-(NSString*)reference{
    return [self.properties objectForKey:@"reference"];
}

-(NSArray*)types{
    return [self.properties objectForKey:@"types"];
}

-(NSString*)vicinity{
    return [self.properties objectForKey:@"vicinity"];
}

-(NSString*)ID{
    return [self.properties objectForKey:@"id"];
}

@end
