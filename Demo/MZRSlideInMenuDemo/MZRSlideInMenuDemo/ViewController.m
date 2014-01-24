//
//  ViewController.m
//  MZRSlideInMenuDemo
//
//  Created by Morita Naoki on 2014/01/25.
//  Copyright (c) 2014年 molabo. All rights reserved.
//

#import "ViewController.h"

#import "MZRSlideInMenu.h"

static NSString *const kButtonTitle0 = @"Profile";
static NSString *const kButtonTitle1 = @"Friends";
static NSString *const kButtonTitle2 = @"Events";
static NSString *const kButtonTitle3 = @"Settings";
static NSString *const kButtonTitle4 = @"Cancel";

@interface ViewController ()<MZRSlideInMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)fromLeftButtonTapped:(UIButton *)sender
{
    MZRSlideInMenu *menu = [[MZRSlideInMenu alloc] init];
    [menu setDelegate:self];
    [menu addMenuItemWithTitle:kButtonTitle0];
    [menu addMenuItemWithTitle:kButtonTitle1];
    [menu addMenuItemWithTitle:kButtonTitle2];
    [menu addMenuItemWithTitle:kButtonTitle3];
    [menu addMenuItemWithTitle:kButtonTitle4];
    [menu showMenuFromLeft];
}

- (IBAction)fromRightButtonTapped:(UIButton *)sender
{
    MZRSlideInMenu *menu = [[MZRSlideInMenu alloc] init];
    [menu setDelegate:self];
    [menu addMenuItemWithTitle:kButtonTitle0];
    [menu addMenuItemWithTitle:kButtonTitle1];
    [menu addMenuItemWithTitle:kButtonTitle2];
    [menu addMenuItemWithTitle:kButtonTitle3];
    [menu addMenuItemWithTitle:kButtonTitle4];
    [menu showMenuFromRight];
}

- (IBAction)fromLeftColorfulButtonTapped:(UIButton *)sender
{
    MZRSlideInMenu *menu = [[MZRSlideInMenu alloc] init];
    [menu setDelegate:self];
    [menu addMenuItemWithTitle:kButtonTitle0 textColor:[UIColor whiteColor] backgroundColor:[UIColor orangeColor]];
    [menu addMenuItemWithTitle:kButtonTitle1 textColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithWhite:0.7 alpha:1.0]];
    [menu addMenuItemWithTitle:kButtonTitle2 textColor:[UIColor colorWithWhite:0.7 alpha:1.0] backgroundColor:[UIColor yellowColor]];
    [menu addMenuItemWithTitle:kButtonTitle3 textColor:[UIColor whiteColor] backgroundColor:[UIColor purpleColor]];
    [menu addMenuItemWithTitle:kButtonTitle4 textColor:[UIColor whiteColor] backgroundColor:[UIColor redColor]];
    [menu showMenuFromLeft];
}

- (IBAction)fromRightColorfulButtonTapped:(UIButton *)sender
{
    MZRSlideInMenu *menu = [[MZRSlideInMenu alloc] init];
    [menu setDelegate:self];
    [menu addMenuItemWithTitle:kButtonTitle0 textColor:[UIColor whiteColor] backgroundColor:[UIColor orangeColor]];
    [menu addMenuItemWithTitle:kButtonTitle1 textColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithWhite:0.7 alpha:1.0]];
    [menu addMenuItemWithTitle:kButtonTitle2 textColor:[UIColor colorWithWhite:0.7 alpha:1.0] backgroundColor:[UIColor yellowColor]];
    [menu addMenuItemWithTitle:kButtonTitle3 textColor:[UIColor whiteColor] backgroundColor:[UIColor purpleColor]];
    [menu addMenuItemWithTitle:kButtonTitle4 textColor:[UIColor whiteColor] backgroundColor:[UIColor redColor]];
    [menu showMenuFromRight];
}

- (void)slideInMenu:(MZRSlideInMenu *)menuView didSelectAtIndex:(NSUInteger)index
{
    NSString *buttonTitle = [menuView buttonTitleAtIndex:index];
    
    NSLog(@"%@(%ld) tapped",buttonTitle, (long)index);
}

@end
