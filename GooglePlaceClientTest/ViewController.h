//
//  ViewController.h
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField* longitudeField;
@property (nonatomic, retain) IBOutlet UITextField* latitudeField;

-(IBAction)search:(id)sender;

@end
