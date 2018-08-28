//
//  CustomModalAnimator.m
//  ModalPresentationCustom
//
//  Created by nagado-kazumasa on 2018/08/28.
//  Copyright © 2018年 nagado-kazumasa. All rights reserved.
//

#import "CustomModalAnimator.h"

@implementation CustomModalAnimator
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        [self presentingAnimatedTransition:transitionContext];
    } else {
        [self dismissingAnimatedTransition:transitionContext];
    }
}

- (void)presentingAnimatedTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    NSParameterAssert(transitionContext);
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSAssert(toViewController != nil, @"toViewController must be non nil");
    UIView *toView = toViewController.view;
    NSAssert(toView != nil, @"toView must be non nil");
    UIView *containerView = transitionContext.containerView;
    NSAssert(containerView != nil, @"containerView must be non nil");
    
    UIEdgeInsets inset = self.needSetInset ? UIEdgeInsetsMake(64, 0, 0, 0) : UIEdgeInsetsZero;
    CGRect toViewInitialFrame = UIEdgeInsetsInsetRect(CGRectMake(0,
                                                                 containerView.bounds.size.height,
                                                                 containerView.bounds.size.width,
                                                                 containerView.bounds.size.height),
                                                      inset);
    toView.frame = toViewInitialFrame;
    CGRect toViewFinalFrame = UIEdgeInsetsInsetRect([transitionContext finalFrameForViewController:toViewController],
                                                    inset);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toView.frame = toViewFinalFrame;
                     } completion:^(BOOL finished) {
                         if ([transitionContext transitionWasCancelled]) {
                             [transitionContext completeTransition:NO];
                         } else {
                             [transitionContext completeTransition:YES];
                         }
                     }];
}

- (void)dismissingAnimatedTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    NSParameterAssert(transitionContext);
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NSAssert(fromViewController != nil, @"fromViewController must be non nil");
    UIView *fromView = fromViewController.view;
    NSAssert(fromView != nil, @"fromView must be non nil");
    UIView *containerView = transitionContext.containerView;
    NSAssert(containerView != nil, @"containerView must be non nil");
    
    CGRect fromViewOffScreenFrame = fromView.frame;
    fromViewOffScreenFrame.origin.y = containerView.bounds.size.height;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         fromView.frame = fromViewOffScreenFrame;
                     } completion:^(BOOL finished) {
                         if ([transitionContext transitionWasCancelled]) {
                             [transitionContext completeTransition:NO];
                         } else {
                             [transitionContext completeTransition:YES];
                         }
                     }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return [transitionContext isAnimated] ? 0.35 : 0;
}

@end
