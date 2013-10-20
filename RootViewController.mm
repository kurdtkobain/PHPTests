#import "RootViewController.h"

@implementation RootViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    webview=[[UIWebView alloc]initWithFrame:self.view.bounds];
	
    [self.view addSubview:webview];
	webview.delegate = self;
	NSString* output = [ self getPHPOutput:@"index.php" ];
	[webview loadHTMLString:output baseURL:nil];
	
}

- (NSString *)getPHPOutput:(NSString *)file
{
	NSString *finalCommand = [NSString stringWithFormat:@"%@%@/%@",@"php -n -f ",[[NSBundle mainBundle] bundlePath],file];
	NSString *output = [NSString string];
    FILE *pipe = popen([finalCommand cStringUsingEncoding: NSASCIIStringEncoding], "r");
    if (!pipe) return nil;

    char buf[1024];
    while(fgets(buf, 1024, pipe)) {
        output = [output stringByAppendingFormat: @"%s", buf];
    }
    pclose(pipe);
    return output;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
  	NSString *requestString = [[request URL] absoluteString];
  
  if ([requestString hasPrefix:@"kamy:"]) {
    
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    
    NSString *function = (NSString*)[components objectAtIndex:1];
    NSString *args = (NSString*)[components objectAtIndex:2];
    
    [self handleCall:function args:args];
    
    return NO;
  }
  
  return YES;
}
  
- (void)handleCall:(NSString*)functionName args:(NSString*)args
{
  if ([functionName isEqualToString:@"getPHPOutput"]) {
    
    NSString *output = [self getPHPOutput:args];
	[webview loadHTMLString:output baseURL:nil];
    
  }else {
    NSLog(@"Unimplemented method '%@'",functionName);
  }
}

@end
