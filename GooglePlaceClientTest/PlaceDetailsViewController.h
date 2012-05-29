//
//  PlaceDetailsViewController.h
//  GooglePlaceClientTest
//
//  Created by Jin Jin on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceDetailsViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextView* textView;

@property (nonatomic, copy) NSString* reference;

@end
