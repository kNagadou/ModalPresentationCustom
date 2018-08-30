//
//  ViewController.m
//  ModalPresentationCustom
//
//  Created by nagado-kazumasa on 2018/08/28.
//  Copyright © 2018年 nagado-kazumasa. All rights reserved.
//

#import "ViewController.h"
#import "BadCase1UISCVC.h"
#import "BadCase2UISCVC.h"
#import "SBModalViewController.h"
#import "CustomModalPresentationController.h"
#import "CustomModalAnimator.h"
#import "DraggablePercentDrivenInteractiveTransition.h"

@interface ViewController ()
<
UIViewControllerTransitioningDelegate
>

typedef NS_ENUM(NSInteger, VCType){
    VCTypeBadCase1,
    VCTypeBadCase2,
    VCTypeBadCase3,
    VCTypeGoodCase
};
@property (nonatomic) VCType type;
@property (nonatomic, strong, nullable) DraggablePercentDrivenInteractiveTransition *interactiveAnimator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handleTouchGoodCaseButton:(id)sender {
    UIViewController *vc = [[SBModalViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    self.interactiveAnimator = [[DraggablePercentDrivenInteractiveTransition alloc] initWithAttachToViewController:vc
                                                                                                        targetView:vc.view
                                                                                           presentedViewController:nil];
    self.type = VCTypeGoodCase;
    [self presentViewController:vc animated:YES completion:^{
        // do not
    }];
}

- (IBAction)handleTouchButton:(id)sender {
    UIViewController *vc = [[BadCase1UISCVC alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    self.interactiveAnimator = [[DraggablePercentDrivenInteractiveTransition alloc] initWithAttachToViewController:vc
                                                                                                        targetView:vc.view
                                                                                           presentedViewController:nil];
    self.type = VCTypeBadCase1;
    [self presentViewController:vc animated:YES completion:^{
        // do not
    }];
}
- (IBAction)handleTouchBadCase2Button:(id)sender {
    UIViewController *vc = [[BadCase2UISCVC alloc] initWithConstraintTop:0];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    self.interactiveAnimator = [[DraggablePercentDrivenInteractiveTransition alloc] initWithAttachToViewController:vc
                                                                                                        targetView:vc.view
                                                                                           presentedViewController:nil];
    self.type = VCTypeBadCase2;
    [self presentViewController:vc animated:YES completion:^{
        // do not
    }];
}
- (IBAction)handleTouchBadCase3Button:(id)sender {
    UIViewController *vc = [[BadCase2UISCVC alloc] initWithConstraintTop:44];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    self.interactiveAnimator = [[DraggablePercentDrivenInteractiveTransition alloc] initWithAttachToViewController:vc
                                                                                                        targetView:vc.view
                                                                                           presentedViewController:nil];
    self.type = VCTypeBadCase3;
    [self presentViewController:vc animated:YES completion:^{
        // do not
    }];
}

# pragma mark - UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source
{
    // カスタムした UIPresentationController を使う場合
    // CustomModalPresentationController を使うと、モーダルビュー背面に影を付ける
//    UIPresentationController *pc = [[CustomModalPresentationController alloc] initWithPresentedViewController:presented
//                                                                                     presentingViewController:presenting];
//    return pc;
    // 標準の UIPresentationController を使う場合
     return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source
{
    switch (self.type) {
        case VCTypeBadCase1:{
            return nil;
        }
        case VCTypeBadCase2:{
            CustomModalAnimator *animator = [[CustomModalAnimator alloc] init];
            animator.isPresenting = YES;
            animator.needSetInset = YES;
            return animator;
        }
        case VCTypeBadCase3: {
            CustomModalAnimator *animator = [[CustomModalAnimator alloc] init];
            animator.isPresenting = YES;
            animator.needSetInset = NO;
            return animator;
        }
        case VCTypeGoodCase: {
            CustomModalAnimator *animator = [[CustomModalAnimator alloc] init];
            animator.isPresenting = YES;
            animator.needSetInset = NO;
            return animator;
        }
    }
}

- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    switch (self.type) {
        case VCTypeBadCase1:{
            return nil;
        }
        case VCTypeBadCase2:{
            CustomModalAnimator *animator = [[CustomModalAnimator alloc] init];
            animator.isPresenting = NO;
            animator.needSetInset = YES;
            return animator;
        }
        case VCTypeBadCase3: {
            CustomModalAnimator *animator = [[CustomModalAnimator alloc] init];
            animator.isPresenting = NO;
            animator.needSetInset = NO;
            return animator;
        }
        case VCTypeGoodCase: {
            CustomModalAnimator *animator = [[CustomModalAnimator alloc] init];
            animator.isPresenting = NO;
            animator.needSetInset = NO;
            return animator;
        }
    }
}

- (nullable id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactiveAnimator.disableInteractiveTransition ? nil : self.interactiveAnimator;
}

@end
