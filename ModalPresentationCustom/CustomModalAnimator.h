//
//  CustomModalAnimator.h
//  ModalPresentationCustom
//
//  Created by nagado-kazumasa on 2018/08/28.
//  Copyright © 2018年 nagado-kazumasa. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface CustomModalAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic) BOOL isPresenting;
@property (nonatomic) BOOL needSetInset;
@end
