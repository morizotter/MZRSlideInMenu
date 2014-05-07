//
//  MZRSlideInMenu.h
//  MZRSlideInMenu
//
//  Created by Morita Naoki on 2014/01/21.
//  Copyright (c) 2014年 molabo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MZRSlideInMenuDelegate;
@interface MZRSlideInMenu : UIControl

@property (weak, nonatomic) id<MZRSlideInMenuDelegate> delegate;

/* button title font */
@property (strong, nonatomic) UIFont *font;

/* button title color */
@property (strong, nonatomic) UIColor *textColor;

/* button background color */
@property (strong, nonatomic) UIColor *buttonBackgroundColor;

/* item bar height */
@property (assign, nonatomic) CGFloat itemBarHeight;

/* item bar gap */
@property (assign, nonatomic) CGFloat itemBarGap;

/* allow to dismiss on background touched by user */
@property (assign, nonatomic) BOOL dismissOnBackgroundTouch;

/* close menu on selection, Default YES */
@property (assign, nonatomic) BOOL closeMenuOnSelection;

/* add horizontal effect */
@property (assign, nonatomic) CGFloat horizontalTransitionEffect;

/* delay inserting of each button on view */
@property (assign, nonatomic) CGFloat buttonInsertDelay;


/* show menu from right */
- (void)showMenuFromRight;

/* show menu from left */
- (void)showMenuFromLeft;

/* close menu */
- (void)closeMenu;

/* add menu item with title */
- (void)addMenuItemWithTitle:(NSString *)title;

/* add menu item with title & textColor & backgroundColor */
- (void)addMenuItemWithTitle:(NSString *)title textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor;

/* add menu background color */
- (void)setMenuBackgroundColor:(UIColor *)color;

/* get button name */
- (NSString *)buttonTitleAtIndex:(NSInteger)index;

@end

@protocol MZRSlideInMenuDelegate <NSObject>

/* this is called when the button tapped. */
- (void)slideInMenu:(MZRSlideInMenu *)menuView didSelectAtIndex:(NSUInteger)index;

@end