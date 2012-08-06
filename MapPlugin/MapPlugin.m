//
//  MapPlugin.m
//  

#import "MapPlugin.h"
#import "ViewController.h"


@implementation MapPlugin

@synthesize callbackID,pointsArray;


- (void)showMap:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSLog(@"inside MapPlugin");
    ViewController *mapViewController = [[ViewController alloc]initWithNibName:@"MapView" bundle:nil];
    [mapViewController setArray:arguments];
    [self.viewController.view addSubview:mapViewController.view];
}  




@end
