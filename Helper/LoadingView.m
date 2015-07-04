//
//  LoadingView.m
//  JueWeiShop
//
//  Created by Allan.Chan on 13-3-26.
//
//

#import "LoadingView.h"
#import <QuartzCore/QuartzCore.h>
@implementation LoadingView
static LoadingView *_shareLoadingView = nil;
+(LoadingView *)shareLoadingView
{
    @synchronized([LoadingView class])
    {
        if (! _shareLoadingView)
        {
            _shareLoadingView = [[self alloc] init];
            _shareLoadingView.backgroundColor = [UIColor darkGrayColor];
            [_shareLoadingView setBackgroundColor:[[UIColor alloc] initWithRed:(64/255.0) green:(68/255.0) blue:(72/255.0) alpha:0.6]];
            UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(38, 27, 20, 20)];
            [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
            [activityIndicatorView startAnimating];
            UILabel *loadingLab = [[UILabel alloc]initWithFrame:CGRectMake(84, 25, 83, 21)];
            [loadingLab setText:@"请稍后.."];
            [loadingLab setFont:[UIFont systemFontOfSize:17.0]];
            [loadingLab setTextColor:[UIColor whiteColor]];
            [loadingLab setBackgroundColor:[UIColor clearColor]];
            [loadingLab setTag:9000];
            [_shareLoadingView addSubview:activityIndicatorView];
            [_shareLoadingView addSubview:loadingLab];
            _shareLoadingView.layer.cornerRadius = 6;
            _shareLoadingView.layer.masksToBounds = YES;
        }
		return _shareLoadingView;
    }
    return nil;
}

-(void)shareLoadingViewFrame
{
    _shareLoadingView.frame = CGRectMake(60, 205, 200, 70);
}

-(void)setMessage:(NSString *)message
{
    UILabel *messageLab = (UILabel *)[self viewWithTag:9000];
    [messageLab setText:message];
}

+(id)alloc
{
    @synchronized([LoadingView class])
	{
		if(_shareLoadingView == nil)
        {
            _shareLoadingView = [super alloc];
            return _shareLoadingView;
        }
	}
	return nil;
}


-(void)setLoadingViewAlpha:(CGFloat)alpha
{
    self.alpha = alpha;
}

-(void)setLoadingViewHidden
{
    self.hidden = YES;
}

-(void)removeAll
{
    [self removeFromSuperview];
}

@end
