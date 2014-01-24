//
//  MZRSlideInMenu.m
//  MZRSlideInMenu
//
//  Created by Morita Naoki on 2014/01/21.
//  Copyright (c) 2014年 molabo. All rights reserved.
//

#import "MZRSlideInMenu.h"

static const CGFloat kMenuItemBarHeight = 60.0;
static const CGFloat kMenuItemBarGap = 20.0;
static const CGFloat kMenuItemMarginBottom = 30.0;
static const CGFloat kMenuItemLabelMarginTop = 4.0;
static const CGFloat kMenuItemLabelMarginBottom = 4.0;
static const CGFloat kMenuItemLabelMarginLeft = 14.0;
static const CGFloat kMenuItemLabelMarginRight = 14.0;
static const CGFloat kDelayInterval = 0.02;
static const CGFloat kAnimationDuration = 0.15;
static const CGFloat kBackgroundAlpha = 0.25;

static const NSUInteger kMenuItemTagBase = 100;

typedef NS_ENUM(NSUInteger, MenuDirection)
{
    MenuDirectionRight,
    MenuDirectionLeft
};

@interface MZRMenuItem : NSObject
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) UIColor *textColor;
@property (copy, nonatomic) UIColor *backgroundColor;
@end

@implementation MZRMenuItem


@end

@interface MZRSlideInMenu()
@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) NSMutableArray *menuItems;
@property (strong, nonatomic) NSMutableArray *menuButtons;
@property (assign, nonatomic) MenuDirection menuDirection;
@end

@implementation MZRSlideInMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = [UIApplication sharedApplication].keyWindow.frame;
        
        _menuItems = @[].mutableCopy;
        _menuButtons = @[].mutableCopy;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
        self.view.backgroundColor = [UIColor blackColor];
        self.view.alpha = 0.0;
        [self addSubview:self.view];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTouched)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)addMenuItemWithTitle:(NSString *)title
{
    [self addMenuItemWithTitle:title textColor:nil backgroundColor:nil];
}

- (void)addMenuItemWithTitle:(NSString *)title textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor
{
    MZRMenuItem *menuItem = [[MZRMenuItem alloc] init];
    menuItem.title = title;
    menuItem.textColor = textColor;
    menuItem.backgroundColor = backgroundColor;
    
    [self.menuItems addObject:menuItem];
}

- (void)showMenuFromRight
{
    self.menuDirection = MenuDirectionRight;
    [self showMenu];
}

- (void)showMenuFromLeft
{
    self.menuDirection = MenuDirectionLeft;
    [self showMenu];
}

- (void)showMenu
{
    [UIView animateWithDuration:kAnimationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
     {
         self.view.alpha = kBackgroundAlpha;
     } completion:^(BOOL finished)
     {
         
     }];
    
    if (self.menuItems.count==0)
    {
        return;
    }
    
    for (int i=0; i < self.menuItems.count; i++)
    {
        CGFloat itemBarHeight = kMenuItemBarHeight;
        if (self.itemBarHeight)
        {
            itemBarHeight = self.itemBarHeight;
        }
        
        CGFloat itemBarGap = kMenuItemBarGap;
        if (self.itemBarGap)
        {
            itemBarGap = self.itemBarGap;
        }
        
        CGFloat y = CGRectGetHeight(self.frame) - kMenuItemMarginBottom - itemBarHeight * (i + 1) - itemBarGap * i;
        
        MZRMenuItem *menuItem = self.menuItems[self.menuItems.count-i-1];
        NSString *title = menuItem.title;
        UIColor *itemTextColor = menuItem.textColor;
        UIColor *itemBackgroundColor = menuItem.backgroundColor;
        
        UIFont *labelFont = [UIFont fontWithName:@"HelveticaNeue" size:30.0];
        if (self.font)
        {
            labelFont = self.font;
        }
        
        UIColor *textColor = [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/25.0 alpha:1.0];
        if (itemTextColor)
        {
            textColor = itemTextColor;
        }
        else if (self.textColor)
        {
            textColor = self.textColor;
        }
        
        UIColor *buttonBackgroundColor = [UIColor whiteColor];
        if (itemBackgroundColor)
        {
            buttonBackgroundColor = itemBackgroundColor;
        }
        else if (self.buttonBackgroundColor)
        {
            buttonBackgroundColor = self.buttonBackgroundColor;
        }
        
        CGSize labelSize = [title sizeWithAttributes:@{NSFontAttributeName:labelFont}];
        CGSize menuSize = CGSizeMake(labelSize.width + kMenuItemLabelMarginLeft + kMenuItemLabelMarginRight,
                                     labelSize.height + kMenuItemLabelMarginTop + kMenuItemLabelMarginBottom);
        
        CGFloat x = 0.0;
        if (self.menuDirection==MenuDirectionRight)
        {
            x = CGRectGetWidth(self.frame);
        }
        else if (self.menuDirection==MenuDirectionLeft)
        {
            x = -menuSize.width;
        }
        
        CGRect labelRect = CGRectMake(0.0, 0.0, labelSize.width, labelSize.height);
        CGRect menuRect = CGRectMake(x, y, menuSize.width, itemBarHeight);
        
        UILabel *menuLabel = [[UILabel alloc] initWithFrame:labelRect];
        [menuLabel setBackgroundColor:[UIColor clearColor]];
        [menuLabel setFont:labelFont];
        [menuLabel setTextColor:textColor];
        [menuLabel setText:title];
        
        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuButton setFrame:menuRect];
        [menuButton setTag:kMenuItemTagBase + self.menuItems.count-i-1];
        [menuButton setBackgroundColor:buttonBackgroundColor];
        [menuButton addTarget:self action:@selector(menuButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:menuButton];
        
        menuLabel.center = CGPointMake(CGRectGetWidth(menuButton.frame)/2, CGRectGetHeight(menuButton.frame)/2);
        [menuButton addSubview:menuLabel];
        
        [self.menuButtons addObject:menuButton];
        
        CGFloat delay = kDelayInterval * i;
        
        CGFloat newX = 0.0;
        if (self.menuDirection==MenuDirectionRight)
        {
            newX = CGRectGetWidth(self.frame) - CGRectGetWidth(menuButton.frame);
        }
        else if (self.menuDirection==MenuDirectionLeft)
        {
            newX = 0.0;
        }
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        [UIView animateWithDuration:kAnimationDuration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^
         {
             CGRect newFrame = CGRectMake(newX,
                                          CGRectGetMinY(menuButton.frame),
                                          CGRectGetWidth(menuButton.frame),
                                          CGRectGetHeight(menuButton.frame));
             [menuButton setFrame:newFrame];
         } completion:^(BOOL finished) {
             
        }];
    }
}

- (void)menuButtonTapped:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideInMenu:didSelectAtIndex:)])
    {
        [self.delegate slideInMenu:self didSelectAtIndex:button.tag-kMenuItemTagBase];
    }
}

- (void)closeMenu
{
    [UIView animateWithDuration:kAnimationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         self.view.alpha = 0.0;
     } completion:^(BOOL finished)
     {
         
     }];
    
    if (self.menuButtons.count==0)
    {
        return;
    }
    
    for (int i=0; i < self.menuButtons.count; i++)
    {
        UIButton *menuButton = self.menuButtons[i];
        
        CGFloat delay = kDelayInterval * i;
        
        CGFloat newX = 0.0;
        if (self.menuDirection==MenuDirectionRight)
        {
            newX = CGRectGetWidth(self.frame);
        }
        else if (self.menuDirection==MenuDirectionLeft)
        {
            newX = - CGRectGetWidth(menuButton.frame);
        }
        
        [UIView animateWithDuration:kAnimationDuration delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^
         {
             CGRect newFrame = CGRectMake(newX,
                                          CGRectGetMinY(menuButton.frame),
                                          CGRectGetWidth(menuButton.frame),
                                          CGRectGetHeight(menuButton.frame));
             [menuButton setFrame:newFrame];
         } completion:^(BOOL finished)
         {
             if (i==self.menuButtons.count-1)
             {
                 [self removeFromSuperview];
             }
         }];
    }
}

- (void)viewTouched
{
    [self closeMenu];
}

- (NSString *)buttonTitleAtIndex:(NSInteger)index
{
    if (index>=self.menuItems.count) {
        return nil;
    }
    
    MZRMenuItem *menuItem = self.menuItems[index];
    return menuItem.title;
}

@end
