#import "QSHelper.h"

static NSString *HomePage = nil;
@implementation QSHelper
+ (void)setHomePage:(NSString *)homePage{
    HomePage = homePage;
}
+ (NSString *)getHomePage
{
    return HomePage;
}
@end