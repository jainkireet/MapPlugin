//
//  Waypoint.m
//  MapTest
//
//  Created by Manav Kamboj on 02/08/12.
//  Copyright (c) 2012 LetsGomo. All rights reserved.
//

#import "Waypoint.h"

@implementation Waypoint
@synthesize title,subtitle;

-(void)setlatlong:(float) latitude:(float) longitude{
    lat = latitude;
    lng = longitude;
}

-(void)setTitles:(NSString*) Title:(NSString*) subTitle{
    self.title = Title;
    self.subtitle = subTitle;
}

-(float)getLat{
    return lat;
}

-(float)getLong{
    return lng;
}

-(NSString*)getTitle{
    return title;
}

-(NSString*)getSubtitle{
    return subtitle;
}

@end
