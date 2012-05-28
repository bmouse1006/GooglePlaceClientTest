//
//  GooglePlaceClient.m
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GooglePlaceClient.h"
#import "GPSearchResult.h"
#import "SBJson.h"
#import "URLParameterSet.h"

#define GooglePlace_API_KEY @"AIzaSyBvmZwGwDvTmChQqTSplIjy3CDbf2icZhM" //place your key here

#define GP_URLString @"https://maps.googleapis.com/maps/api/place/search/json"
#define GP_Param_Location @"location"
#define GP_Param_Radius @"radius"
#define GP_Param_Types @"types"
#define GP_Param_Language @"language"
#define GP_Param_Name @"name"
#define GP_Param_Sensor @"sensor"
#define GP_Param_Key @"key"
#define GP_Param_Sensor @"sensor"
#define GP_Param_Keyword @"Keyword"
#define GP_Param_Rankby @"rankby"
#define GP_Param_Rankby_Prominence @"Prominence"
#define GP_Param_Rankby_Distance @"Distance"

#define GP_ReturnStatus_OK @"OK"
#define GP_ReturnStatus_ZERO_RESULTS @"ZERO_RESULTS"
#define GP_ReturnStatus_OVER_QUERY_LIMIT @"OVER_QUERY_LIMIT"
#define GP_ReturnStatus_REQUEST_DENIED @"REQUEST_DENIED"
#define GP_ReturnStatus_INVALID_REQUEST @"INVALID_REQUEST"

#define APP_Domin @"GooglePlace" //modify if necessary

typedef enum{
    GooglePlaceReturnErrorCodeZeroResults,
    GooglePlaceReturnErrorCodeOverQueryLimit,
    GooglePlaceReturnErrorCodeRequestDenied,
    GooglePlaceReturnErrorCodeInvalidRequest
} GooglePlaceReturnErrorCode;

/*
 The "status" field within the Place Search response object contains the status of the request, and may contain debugging information to help you track down why the Place Search request failed. The "status" field may contain the following values:
 
 OK indicates that no errors occurred; the place was successfully detected and at least one result was returned.
 ZERO_RESULTS indicates that the search was successful but returned no results. This may occur if the search was passed a latlng in a remote location.
 OVER_QUERY_LIMIT indicates that you are over your quota.
 REQUEST_DENIED indicates that your request was denied, generally because of lack of a sensor parameter.
 INVALID_REQUEST generally indicates that a required query parameter (location or radius) is missing.
 */

@interface GooglePlaceClient ()

@property (nonatomic, retain) NSMutableDictionary* completionHandlers;
@property (nonatomic, retain) NSOperationQueue* requestQueue;

+(NSString*)currentLanguage;

@end 

@implementation GooglePlaceClient

@synthesize completionHandlers = _completionHandlers;
@synthesize requestQueue = _requestQueue;

-(void)dealloc{
    [self.requestQueue.operations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop){
        ASIHTTPRequest* request = obj;
        [request clearDelegatesAndCancel];
    }];
    [self.requestQueue cancelAllOperations];
    self.requestQueue = nil;
    self.completionHandlers = nil;
    [super dealloc];
}

-(id)init{
    self = [super init];
    if (self){
        self.completionHandlers = [NSMutableDictionary dictionary];
        self.requestQueue = [[[NSOperationQueue alloc] init] autorelease];
    }
    
    return self;
}

+(NSString*)currentLanguage{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];  
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];  
    NSString* language = [languages objectAtIndex:0];
    if ([language isEqualToString:@"zh-Hans"]){
        language = @"zh-CN";
    }
    
    if ([language isEqualToString:@"zh-Hant"]){
        language = @"zh-TW";
    }
    
    return language;
}

+(id)sharedClient{
    static dispatch_once_t onceToken;
    static GooglePlaceClient* _shared;
    dispatch_once(&onceToken, ^{
        _shared  = [[GooglePlaceClient alloc] init];
    });
    
    return _shared;
}

-(void)searchPlacesWithLocation:(CLLocationCoordinate2D)location keyword:(NSString*)keyword name:(NSString*)name types:(NSArray*)types radius:(NSUInteger)radius completionHandler:(GooglePlaceSearchHandler)completionHandler{
    URLParameterSet* parameterSet = [[[URLParameterSet alloc] init] autorelease];
    [parameterSet setParameterForKey:GP_Param_Key withValue:GooglePlace_API_KEY];
    [parameterSet setParameterForKey:GP_Param_Sensor withValue:@"true"];
    [parameterSet setParameterForKey:GP_Param_Language withValue:[[self class] currentLanguage]];
    [parameterSet setParameterForKey:GP_Param_Location withValue:[NSString stringWithFormat:@"%f,%f", location.latitude, location.longitude]];
    [parameterSet setParameterForKey:GP_Param_Keyword withValue:keyword];
    [parameterSet setParameterForKey:GP_Param_Name withValue:name];
    [parameterSet setParameterForKey:GP_Param_Types withValue:[types componentsJoinedByString:@"|"]];
    [parameterSet setParameterForKey:GP_Param_Radius withValue:[NSString stringWithFormat:@"%d", radius]];
    
    NSString* fullURLString = [NSString stringWithFormat:@"%@?%@", GP_URLString, [parameterSet description]];
    NSLog(@"%@", fullURLString);
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURLString]];
    request.delegate = self;
    request.didFailSelector = @selector(searchRequestFailed:);
    request.didFinishSelector = @selector(searchRequestFinished:);
    
    if (completionHandler){
        [self.completionHandlers setObject:completionHandler forKey:[NSValue valueWithNonretainedObject:request]];
    }
    
    [self.requestQueue addOperation:request];
}

-(void)queryDetailsWithPlaceReferenceCode:(NSString*)referenceCode completionHandler:(GooglePlaceDetailsHandler)completionHandler{
    ASIHTTPRequest* request = nil;
    
    [self.completionHandlers setObject:completionHandler forKey:[NSValue valueWithNonretainedObject:request]];
}

-(void)searchRequestFinished:(ASIHTTPRequest *)request{
    NSDictionary* responseObj = [request.responseString JSONValue];
    NSString* returnStatus = [responseObj objectForKey:@"status"];
    id completionHandler = [self.completionHandlers objectForKey:[NSValue valueWithNonretainedObject:request]];
    
    if ([returnStatus isEqualToString:GP_ReturnStatus_OK]){
        NSArray* results = [responseObj objectForKey:@"results"];
        
        NSMutableArray* searchResults = [NSMutableArray array];
        [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop){
            GPSearchResult* result = [GPSearchResult searchResultWithResponseDictionary:obj];
            [searchResults addObject:result];
        }];
        
        if (completionHandler){
            GooglePlaceSearchHandler handler = completionHandler;
            handler(searchResults, nil);
        }
    }else{
        NSError* error = [NSError errorWithDomain:APP_Domin code:-1 userInfo:[NSDictionary dictionaryWithObject:returnStatus forKey:NSLocalizedDescriptionKey]];
        if (completionHandler){
            GooglePlaceSearchHandler handler = completionHandler;
            handler(nil, error);
        }
    }
    
    [self.completionHandlers removeObjectForKey:[NSValue valueWithNonretainedObject:request]];
}

-(void)searchRequestFailed:(ASIHTTPRequest *)request{
    id completionHandler = [self.completionHandlers objectForKey:[NSValue valueWithNonretainedObject:request]];
    if (completionHandler){
        GooglePlaceSearchHandler handler = completionHandler;
        handler(nil, request.error);
    }
    
    [self.completionHandlers removeObjectForKey:[NSValue valueWithNonretainedObject:request]];
}

-(void)detailRequestFinished:(ASIHTTPRequest*)request{
    
}

-(void)detailRequestFailed:(ASIHTTPRequest*)request{
    id completionHandler = [self.completionHandlers objectForKey:[NSValue valueWithNonretainedObject:request]];
    
    if (completionHandler){
        GooglePlaceDetailsHandler handler = completionHandler;
        handler(nil, request.error);
    }
    
    [self.completionHandlers removeObjectForKey:[NSValue valueWithNonretainedObject:request]];
}

@end