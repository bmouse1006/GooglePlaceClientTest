//
//  GPDetailResult.h
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GPObject.h"

@interface GPDetailResult : GPObject

@property (retain) NSArray* events;
@property (retain) NSString* formatted_address;
@property (retain) NSString* formatted_phone_number;
@property (assign) CLLocationCoordinate2D coordinate;
@property (retain) NSString* icon;
@property (retain) NSString* ID;
@property (retain) NSString* international_phone_number;
@property (retain) NSString* name;
@property (assign) double rating;
@property (retain) NSString* reference;
@property (retain) NSArray* types;
@property (retain) NSString* url;
@property (retain) NSString* vicinity;
@property (retain) NSString* website;

@end
