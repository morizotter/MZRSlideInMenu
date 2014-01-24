MZRSlideInMenu
==============

MZRSlideInMenu is a simple slide-in menu for iOS. When a button is tapped, the menu comes from left/right with animation. Easy installation and use. Add your app an additional flavour with MZRSlideInMenu.

![MZRSlideInMenu](https://raw.github.com/morizotter/MZRSlideInMenu/assets/sample.png)

Installation
------------

### From CocoaPods

```
pod 'MZRSlideInMenu'
```

### Manually

Add MZRSlideInMenu.h/.m into your project. And then, `#import MZRSlideInMenu.h` where you want to use. That's all.

Usage
-----

### Simple

Just code below where you want to show menu.

```
MZRSlideInMenu *menu = [[MZRSlideInMenu alloc] init];
[menu setDelegate:self];
[menu addMenuItemWithTitle:@"buttonTitle1"];
[menu addMenuItemWithTitle:@"buttonTitle1"];
[menu addMenuItemWithTitle:@"buttonTitle2"];
[menu addMenuItemWithTitle:@"buttonTitle3"];
[menu addMenuItemWithTitle:@"buttonTitle4"];
[menu showMenuFromLeft];
```

And, when the menu button tapped, the delegate below will be called.

```
- (void)slideInMenu:(MZRSlideInMenu *)menuView didSelectAtIndex:(NSUInteger)index
{
    NSString *buttonTitle = [menuView buttonTitleAtIndex:index];
    
    NSLog(@"%@(%ld) tapped",buttonTitle, (long)index);
   
    [menuView closeMenu];
}
```

Done! This is a basic implementation.

### Customize

And you can change settings by accessing MZRSlideInMenu's properties. 

Menu item has another method below. With this, you can change an individual button color and background color.

```
- (void)addMenuItemWithTitle:(NSString *)title textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor;
```

About other customization, please see Demo or MZRSlideInMenu.h file.

LISENSE
-------

The MIT License (MIT)

Author
-------

Morita Naoki / [Twitter](http://twitter.com/morizotter) / [Facebook](http://facebook.com/morizotter) / [HP](http://moritanaoki.org)
