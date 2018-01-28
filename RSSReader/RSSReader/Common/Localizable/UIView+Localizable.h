//
//  Localizable.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 27.07.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Localizable)
@property (nonatomic, copy) IBInspectable NSString *locKey;
@end

@interface UINavigationItem (Localizable)
@property (nonatomic, copy) IBInspectable NSString *locKey;
@end
