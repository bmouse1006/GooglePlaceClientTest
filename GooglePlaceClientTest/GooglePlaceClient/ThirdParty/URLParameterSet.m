//
//  URLParameterSet.m
//  BreezyReader
//
//  Created by Jin Jin on 10-6-7.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "URLParameterSet.h"
#import "NSString+Addition.h"

@implementation ParameterPair

@synthesize key = _key, value = _value;

-(void)dealloc{
    self.key = nil;
    self.value = nil;
    [super dealloc];
}

+(id)pairWithKey:(NSString *)key andValue:(id)value{
    ParameterPair* pair = [[[ParameterPair alloc] init] autorelease];
    
    pair.key = key;
    if ([value isKindOfClass:[NSString class]]){
        pair.value = value;
    }
    
    if ([value isKindOfClass:[NSDate class]]){
        NSTimeInterval secondes = [(NSDate*)value timeIntervalSince1970];
        pair.value = [NSString stringWithFormat:@"%d", secondes];
    }
    
    if ([value isKindOfClass:[NSNumber class]]){
        pair.value = [(NSNumber*)value stringValue];
    }		
    
    return pair;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"%@=%@", [self.key description], [self.value description]];
}

@end

@interface URLParameterSet()

@property (nonatomic, retain) NSMutableArray* parameters;

@end

@implementation URLParameterSet

@synthesize parameters = _parameters;

-(NSString*)parameterString{

    NSString* encodedString = [[self.parameters componentsJoinedByString:@"&"] stringByAddingPercentEscapesAndReplacingHTTPCharacter];
    
	NSLog(@"encoded parameter string is %@", encodedString);
	
	return [[[encodedString stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"] retain] autorelease];
}

-(NSString*)description{
    return [self parameterString];
}

-(void)setParameterForKey:(NSString*)key withValue:(NSObject*)value{
    
    if (key.length > 0 && value){
        ParameterPair* pair = [ParameterPair pairWithKey:key andValue:value];
        [self.parameters addObject:pair];
    }
}

-(NSArray*)allPairs{
    return [NSArray arrayWithArray:self.parameters];
}

-(id)init{
	if (self = [super init]){
        self.parameters = [NSMutableArray array];
		//default parameter for all request
	}
	return self;
}

-(void)dealloc{
    self.parameters = nil;
	[super dealloc];
}
				
										  

@end
