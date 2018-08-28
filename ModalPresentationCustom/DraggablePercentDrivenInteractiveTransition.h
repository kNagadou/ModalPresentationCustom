//
//  DraggablePercentDrivenInteractiveTransition.h
//  ModalPresentationCustom
//
//  Created by nagado-kazumasa on 2018/08/28.
//  Copyright © 2018年 nagado-kazumasa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DraggablePercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition

/** インタラクティブトランジションの無効フラグ。
 このクラスで定義したジェスチャーを認識した時のみ、インタラクティブトランジションが有効（NO）になる。
 default = YES
 */
@property (nonatomic, readonly) BOOL disableInteractiveTransition;

/** パラメータで渡された UIViewController にインタラクティブトランジション効果を付ける。
 presentedViewController が nil なら、 viewController が dismiss するだけ。
 presentedViewController を渡せば、 viewController の上に presentedViewController をモーダル表示する。
 @param viewController トランジションする UIViewController。
 @param targetView パンジェスチャーを add する View
 @param presentedViewController トランジションで表示する UIViewController。
 */
- (nullable instancetype)initWithAttachToViewController:(nonnull UIViewController *)viewController
                                             targetView:(nonnull UIView *)targetView
                                presentedViewController:(nullable UIViewController *)presentedViewController;
- (nullable instancetype)init NS_UNAVAILABLE;


@end
