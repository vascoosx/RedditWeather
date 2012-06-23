//
//  SecondViewController.h
//  RedditWeather
//
//  Created by Mathieu Hendey on 22/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *temperatureControl; 
@property (nonatomic) NSUserDefaults *selectedSegment;

@end
