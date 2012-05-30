//
//  CLLocation+geometricaddon.h
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (geometricaddon)

-(CLLocationDirection)directionToLocation:(const CLLocation*)location;

@end
