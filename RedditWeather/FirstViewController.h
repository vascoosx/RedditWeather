//
//  FirstViewController.h
//  RedditWeather
//
//  Created by Mathieu Hendey on 22/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UIViewController <CLLocationManagerDelegate> 
{
    CLGeocoder *_geocoder; //Reverse geocoder, gives us information from coordinates.
    __weak UILabel *_townLabel;
    __weak UILabel *_textLabel;
    __weak UILabel *_temperatureLabel;
    __weak UIImageView *__imageView;
}

@property (strong, nonatomic) CLLocationManager *locationManager; // The location manager code.
@property (strong, nonatomic) CLLocation *currentLocation; // The location data.
@property (nonatomic) float longitude;
@property (nonatomic) float latitude;
@property (nonatomic) NSDictionary *conditions; 
@property (nonatomic) NSInteger temperatureSetting;
@property (weak, nonatomic) IBOutlet UILabel *townLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)getWeather:(id)sender; //Method we want to be called when get weather button is tapped.

@end
