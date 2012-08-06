//
//  LocationDetailControllerViewController.h
//  MapPlugin
//
//  Created by Manav Kamboj on 06/08/12.
//  Copyright (c) 2012 mobile@letsgomo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationDetailControllerViewController : UIViewController{
    UILabel* titleLabel;
    UILabel* subtitleLabel;
    UIImageView* imageView;
    NSString *titleString;
    NSString *subtitleString;
    UIWebView *webView;
}
@property(nonatomic, retain) IBOutlet UIWebView *webView;
@property(nonatomic, retain) NSString *titleString;
@property(nonatomic, retain) NSString *subtitleString;
@property(nonatomic, retain) IBOutlet UILabel* titleLabel;
@property(nonatomic, retain) IBOutlet UILabel* subtitleLabel;
@property(nonatomic, retain) IBOutlet UIImageView* imageView;

@end
