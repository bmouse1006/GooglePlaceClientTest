//
//  GPDetailResult.m
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GPDetailResult.h"
#import "GPEvent.h"

@implementation GPDetailResult

@dynamic events, formatted_address, formatted_phone_number, coordinate, icon, ID, international_phone_number, name, rating, reference, types, url, vicinity, website;

-(NSArray*)events{
    NSMutableArray* temp = [NSMutableArray array];
    [[self.properties objectForKey:@"events"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop){
        [temp addObject:[GPEvent objWithProperties:obj]];
    }];
    
    return temp;
}

-(NSString*)formatted_address{
    return [self.properties objectForKey:@"formatted_address"];
}

-(NSString*)formatted_phone_number{
    return [self.properties objectForKey:@"formatted_phone_number"];
}

-(CLLocationCoordinate2D)coordinate{
    NSDictionary* location = [[self.properties objectForKey:@"geometry"] objectForKey:@"location"];
    CLLocationDegrees latitude = [[location objectForKey:@"lat"] doubleValue];
    CLLocationDegrees longitude = [[location objectForKey:@"lng"] doubleValue];
    return CLLocationCoordinate2DMake(latitude, longitude);
}

-(NSString*)icon{
    return [self.properties objectForKey:@"icon"];
}

-(NSString*)international_phone_number{
    return [self.properties objectForKey:@"international_phone_number"];
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

-(NSString*)url{
    return [self.properties objectForKey:@"url"];
}

-(NSString*)vicinity{
    return [self.properties objectForKey:@"vicinity"];
}

-(NSString*)website{
    return [self.properties objectForKey:@"website"];
}

@end
