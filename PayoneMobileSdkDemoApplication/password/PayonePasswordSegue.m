//
//  POPasswordSegue.m
//  Payone App
//
//  Created by Rainer Grinninger on 08.04.13.
//
//

#import "PayonePasswordSegue.h"

@implementation PayonePasswordSegue

- (void)perform
{    
    // Add your own animation code here.    
    [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];    
}

@end
