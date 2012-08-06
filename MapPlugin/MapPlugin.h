//
//  Map PLugin
//  LetsGoMo Labs


#ifdef CORDOVA_FRAMEWORK
#import <CORDOVA/CDVPlugin.h>
#else
#import "CDVPlugin.h"
#endif

@interface MapPlugin : CDVPlugin {
NSString* callbackID;
    NSMutableArray *pointsArray;
}
@property (nonatomic, retain) NSMutableArray *pointsArray;
@property (nonatomic, copy) NSString* callbackID;
- (void)showMap:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
@end