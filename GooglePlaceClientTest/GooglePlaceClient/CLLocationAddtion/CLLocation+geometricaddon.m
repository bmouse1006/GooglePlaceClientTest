//
//  CLLocation+geometricaddon.m
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CLLocation+geometricaddon.h"
#import <math.h>

CLLocationDegrees deltaLongitude(CLLocationCoordinate2D p1, CLLocationCoordinate2D p2){
    
    CLLocationDegrees delta = p2.longitude - p1.longitude;
    
    if (delta > 180){
        delta -= 360;
    }
    
    if (delta < -180){
        delta += 360;
    }
    
    return delta;
}

@implementation CLLocation (geometricaddon)

-(CLLocationDirection)directionToLocation:(const CLLocation*)location{
    CLLocationCoordinate2D a = self.coordinate;
    CLLocationCoordinate2D b = location.coordinate;
    
    if (a.longitude == b.longitude){
        return (a.latitude >= b.latitude)?180:0;
    }
    
    if (a.latitude == b.latitude){
        return (deltaLongitude(a, b)>0)?90:270;
    }
    
    
    CLLocationCoordinate2D c = CLLocationCoordinate2DMake(a.longitude, b.latitude);
    CLLocation* locationC = [[[CLLocation alloc] initWithLatitude:c.longitude longitude:c.latitude] autorelease];
    
    CLLocationDistance bc = [location distanceFromLocation:locationC];
    CLLocationDistance ac = [self distanceFromLocation:locationC];
    CLLocationDirection direction = atan(bc/ac);
    
    direction *= 180/M_PI;
    
    if (deltaLongitude(a, b)>0){
        if (a.latitude > b.latitude){
            direction = 180 - direction;
        }
    }else{
        if (a.latitude > b.latitude){
            direction += 180;
        }else{
            direction = 360 - direction;
        }
    }
    
    return direction;
//    if (b.latitude > a.latitude && b.longitude > a.longitude
}

        

@end
