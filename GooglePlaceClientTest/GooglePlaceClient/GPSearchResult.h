//
//  GPSearchResult.h
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GPObject.h"
#import "GPEvent.h"

@interface GPSearchResult : GPObject

@property (retain) NSArray* events;
@property (retain) NSString* url;
@property (retain) NSString* icon;
@property (assign) CLLocationCoordinate2D coordinate;
@property (retain) NSString* name;
@property (assign) double rating;
@property (retain) NSString* reference;
@property (retain) NSArray* types;
@property (retain) NSString* vicinity;
@property (retain) NSString* ID;

/*
 An events[] array or one or more <event> elements provide information about current events happening at this Place. Up to three events are returned for each place, ordered by start time. For information about events, please read Events in the Places API. Each event contains:
 event_id: The unique ID of this event.
 summary: A textual description of the event. This property contains a string, the contents of which are not sanitized by the server. Your application should be prepared to prevent or deal with attempted exploits, if necessary.
 url: A URL pointing to details about the event. This property will not be returned if no URL was specified for the event.
 icon contains the URL of a recommended icon which may be displayed to the user when indicating this result.
 id contains a unique stable identifier denoting this place. This identifier may not be used to retrieve information about this place, but is guaranteed to be valid across sessions. It can be used to consolidate data about this Place, and to verify the identity of a Place across separate searches.
 geometry contains geometry information about the result, generally including the location (geocode) of the Place and (optionally) the viewport identifying its general area of coverage.
 name contains the human-readable name for the returned result. For establishment results, this is usually the business name.
 rating contains the Place's rating, from 0.0 to 5.0, based on user reviews.
 reference contains a unique token that you can use to retrieve additional information about this place in a Place Details request. You can store this token and use it at any time in future to refresh cached data about this Place, but the same token is not guaranteed to be returned for any given Place across different searches.
 types[] contains an array of feature types describing the given result. See the list of supported types for more information. XML responses include multiple <type> elements if more than one type is assigned to the result.
 vicinity contains a feature name of a nearby location. Often this feature refers to a street or neighborhood within the given results.
 */

+(id)searchResultWithResponseDictionary:(NSDictionary*)responseDictionary;

@end
