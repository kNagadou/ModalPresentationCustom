//
//  DraggablePercentDrivenInteractiveTransition.m
//  ModalPresentationCustom
//
//  Created by nagado-kazumasa on 2018/08/28.
//  Copyright © 2018年 nagado-kazumasa. All rights reserved.
//

#import "DraggablePercentDrivenInteractiveTransition.h"

@interface DraggablePercentDrivenInteractiveTransition()
@property (nonatomic, weak, nullable) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong, nonnull) UIViewController *viewController;
@property (nonatomic, strong, nonnull) UIView *targetView;
@property (nonatomic, strong, nullable) UIViewController *presentedViewController;
@property (nonatomic, readwrite) BOOL disableInteractiveTransition;
@end

@implementation DraggablePercentDrivenInteractiveTransition


- (nullable instancetype)initWithAttachToViewController:(nonnull UIViewController *)viewController
                                             targetView:(nonnull UIView *)targetView
                                presentedViewController:(nullable UIViewController *)presentedViewController
{
    NSParameterAssert(viewController);
    NSParameterAssert(targetView);
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.targetView = targetView;
        self.presentedViewController = presentedViewController;
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(handlePanGesture:)];
        self.panGestureRecognizer = panGestureRecognizer;
        self.panGestureRecognizer.maximumNumberOfTouches = 1;
        self.panGestureRecognizer.cancelsTouchesInView = NO;
        [self.targetView addGestureRecognizer:self.panGestureRecognizer];
        self.disableInteractiveTransition = YES;
    }
    return self;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    NSAssert(self.targetView.superview != nil, @"self.targetView.superview must be non nil");
    CGPoint translation = [gestureRecognizer translationInView:self.targetView.superview];
    CGFloat threshold = MAX((translation.y / self.targetView.superview.bounds.size.height) , 0);
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.disableInteractiveTransition = NO;
        if (self.presentedViewController) {
            [self.viewController presentViewController:self.presentedViewController animated:YES completion:nil];
        } else {
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
        }
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        // percentage の値をそのまま使うとアニメーションが速すぎるため、微調整
        [self updateInteractiveTransition:(threshold / 5.0)];
    } else if (gestureRecognizer.state >= UIGestureRecognizerStateEnded) {
        if (threshold > 0.3) {
            [self finishInteractiveTransition];
        } else {
            [self cancelInteractiveTransition];
        }
        self.disableInteractiveTransition = YES;
    }
}

@end
