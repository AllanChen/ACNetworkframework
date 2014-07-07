ACNetworkframework
==================
##Why ACNetworkframework

###### Keep http request simpleness


###How to install
######Installation is made simple with [Cocoapods](http://cocoapods.org/)

	platform :ios, '6.0'
    pod 'ACNetworkframework', :git => 'https://github.com/AllanChen/ACNetworkframework'


###How to use

###DemoViewController.h 

	#import "InterfaceDelegate.h"
    #import "TableDataHelper.h"
    @interface DemoViewController : UIViewController<InterfaceDelegate,RegisterDelegate>
    @property (nonatomic,retain) TableDataHelper *tableDataHelper;


###DemoViewController.m     


    -(void)viewDidLoad
    {
    	[self initView];
    }
    
    -(void)initView
    {
    	self.tableDataHelper = [[TableDataHelper alloc] init];
    	[self.tableDataHelper setInterfaceDelegate:self];
    	[self downloadDataFromServer];
    }
    
    -(void)downloadDataFromServer
    {
		NSMutableDictionary *postMessageDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    [postMessageDic setObject:self.usernameTxt.text forKey:@"login"];
    [postMessageDic setObject:self.passwordTxt.text forKey:@"password"];
    NSString *downloadDataURLString = [NSString stringWithFormat:@"%@%@",DomainName,YOURURLSTRING];
    [self.tableDataHelper downloadDataURLString andParameter:postMessageDic andMethod:@"POST"];
    }
    
    -(void)uploadDataReturnDic:(NSDictionary *)returnDic
    {
    	/*
    		RESULT SUCCESS HERE !!
    	*/
    }
    
    -(void)uploadDataFail:(NSDictionary *)returnDic andError:(NSError *)error
    {
    	/*
    		RESULT ERROR HERE !!
    	*/
    }
    
    
    
    





