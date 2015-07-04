//
//  LoadingView.h
//  JueWeiShop
//
//  Created by Allan.Chan on 13-3-26.
//
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
+(LoadingView *)shareLoadingView;
-(void)setMessage:(NSString *)message;
-(void)shareLoadingViewFrame;
-(void)setLoadingViewAlpha:(CGFloat)alpha;
-(void)setLoadingViewHidden;
-(void)removeAll;
@end
