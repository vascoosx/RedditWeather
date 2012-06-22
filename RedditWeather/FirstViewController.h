//
//  FirstViewController.h
//  RedditWeather
//
//  Created by Mathieu Hendey on 22/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UIViewController <CLLocationManagerDelegate> {
    CLGeocoder *_geocoder; //Reverse geocoder, gives us information from coordinates.
    
    __weak UILabel *_townLabel;
}

@property (strong, nonatomic) CLLocationManager *locationManager; // The location manager code.
@property (strong, nonatomic) CLLocation *currentLocation; // The location data.
@property (weak, nonatomic) IBOutlet UILabel *townLabel;

- (IBAction) getCoordinates:(id)sender;  //Method we want to be called when update button is tapped.

@end
