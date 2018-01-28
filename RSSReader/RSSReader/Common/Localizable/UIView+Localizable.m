//
//  Localizable.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 27.07.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "UIView+Localizable.h"
#import "AppDelegate.h"

@implementation UIView (Localizable)

- (void)setLocKey:(NSString *)locKey {
    if (locKey && locKey.length > 0) {
        NSString *locString = RRLocalize(locKey);
        // Button
        if ([self isKindOfClass:[UIButton class]]) {
            [((UIButton*)self) setTitle:locString forState:UIControlStateNormal];
        }
        // Label
        else if ([self isKindOfClass:[UILabel class]]) {
            [((UILabel*)self) setText:locString];
        }
        // Text View
        else if ([self isKindOfClass:[UITextView class]]) {
            [((UITextView*)self) setText:locString];
        }
        // Text Field
        else if ([self isKindOfClass:[UITextField class]]) {
            [((UITextField*)self) setText:locString];
        }
        // Image View
        else if ([self isKindOfClass:[UIImageView class]]) {
            [((UIImageView*)self) setImage:[UIImage imageNamed:locString
                                                      inBundle:[NSBundle bundleForClass:[AppDelegate class]]
                                 compatibleWithTraitCollection:nil]];
        }
    }
}

- (NSString *)locKey {
    return nil;
}

@end

@implementation UINavigationItem (Localizable)

- (void)setLocKey:(NSString *)locKey {
    if (locKey && locKey.length > 0) {
        NSString *locString = RRLocalize(locKey);
        
        [self setTitle:locString];
    }
}

- (NSString *)locKey {
    return nil;
}

@end
