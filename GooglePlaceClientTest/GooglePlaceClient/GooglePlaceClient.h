//
//  GooglePlaceClient.h
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ASIHTTPRequest.h"
#import "GPDetailResult.h"

typedef void(^GooglePlaceSearchHandler)(NSArray* places, NSError* error);
typedef void(^GooglePlaceDetailsHandler)(GPDetailResult* detail, NSError* error);

@interface GooglePlaceClient : NSObject<ASIHTTPRequestDelegate>

+(id)sharedClient;

-(void)searchPlacesWithLocation:(CLLocationCoordinate2D)location keyword:(NSString*)keyword name:(NSString*)name types:(NSArray*)types radius:(NSUInteger)radius completionHandler:(GooglePlaceSearchHandler)completionHandler;

-(void)queryDetailsWithPlaceReferenceCode:(NSString*)referenceCode completionHandler:(GooglePlaceDetailsHandler)completionHandler;

@end
