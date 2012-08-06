//
//  Waypoint.h
//  MapTest
//
//  Created by Manav Kamboj on 02/08/12.
//  Copyright (c) 2012 LetsGomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Waypoint : NSObject{
    float lat;
    float lng;
    NSString* title;
    NSString* subtitle;
}
@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) NSString* subtitle;
-(void)setlatlong:(float) latitude:(float) longitude;
-(float)getLat;
-(float)getLong;
@end
