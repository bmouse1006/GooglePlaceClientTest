//
//  PlaceDetailsViewController.m
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlaceDetailsViewController.h"
#import "GooglePlaceClient.h"

@interface PlaceDetailsViewController ()

@end

@implementation PlaceDetailsViewController

@synthesize textView = _textView;
@synthesize reference = _reference;

-(void)dealloc{
    self.textView = nil;
    self.reference = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[GooglePlaceClient sharedClient] queryDetailsWithPlaceReferenceCode:self.reference completionHandler:^(GPDetailResult* result, NSError* error){
        if (error == nil){
            self.textView.text = [result.properties description];
        }
    } context:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
