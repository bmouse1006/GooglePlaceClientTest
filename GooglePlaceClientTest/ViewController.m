//
//  ViewController.m
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "PlacesTableViewController.h"
#import "GooglePlaceClient.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize longitudeField = _longitudeField, latitudeField = _latitudeField;

-(void)dealloc{
    self.longitudeField = nil;
    self.latitudeField = nil;
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

-(void)search:(id)sender{
    __block typeof (self) blockSelf = self;

    [[GooglePlaceClient sharedClient] searchPlacesWithLocation:CLLocationCoordinate2DMake([self.latitudeField.text doubleValue], [self.longitudeField.text doubleValue]) keyword:nil name:nil types:[NSArray arrayWithObjects:@"food", nil] radius:10000 completionHandler:^(NSArray* results, NSError* error){
        if (error == nil){
            [blockSelf showSearchResults:results];
//            [self viewDidLoad];
        }else{
            
        }
    }];
}

-(void)showSearchResults:(NSArray*)results{
    PlacesTableViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PlacesTableViewController"];
    controller.places = results;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
