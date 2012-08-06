//
//  LocationDetailControllerViewController.m
//  MapPlugin
//
//  Created by Manav Kamboj on 06/08/12.
//  Copyright (c) 2012 mobile@letsgomo.com. All rights reserved.
//

#import "LocationDetailControllerViewController.h"

@interface LocationDetailControllerViewController ()

@end

@implementation LocationDetailControllerViewController
@synthesize titleLabel,subtitleLabel,imageView,titleString,subtitleString,webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleLabel setText:titleString];
    [subtitleLabel setText:subtitleString];
    UIImage* image = [UIImage imageNamed:@"building.jpg"];
    [imageView setImage:image];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)backButtonClicked:(id)sender{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


@end
