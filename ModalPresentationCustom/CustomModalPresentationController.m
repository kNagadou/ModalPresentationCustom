//
//  CustomModalPresentationController.m
//  ModalPresentationCustom
//
//  Created by nagado-kazumasa on 2018/08/28.
//  Copyright © 2018年 nagado-kazumasa. All rights reserved.
//

#import "CustomModalPresentationController.h"

@interface CustomModalPresentationController ()
@property (nonatomic, weak, nullable) UIView *dimmingView;
@end

@implementation CustomModalPresentationController

- (void)presentationTransitionWillBegin
{
    [self.containerView addSubview:self.presentedView];
    
    UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    dimmingView.backgroundColor = UIColor.blackColor;
    dimmingView.opaque = NO;
    self.dimmingView = dimmingView;
    [self.containerView insertSubview:dimmingView belowSubview:self.presentedView];
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    self.dimmingView.alpha = 0.f;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        self.dimmingView.alpha = 0.5f;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.f;
    } completion:nil];
}

@end
