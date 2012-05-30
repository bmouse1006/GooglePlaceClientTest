//
//  GPEvent.h
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPObject.h"

@interface GPEvent : GPObject

@property (retain) NSString* event_id;
@property (retain) NSString* summary;
@property (retain) NSString* url;
@property (retain) NSDate* startTime;

@end
