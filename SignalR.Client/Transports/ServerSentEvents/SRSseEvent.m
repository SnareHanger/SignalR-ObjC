//
//  SRSseEvent.m
//  SignalR
//
//  Created by Alex Billingsley on 6/8/12.
//  Copyright (c) 2011 DyKnow LLC. (http://dyknow.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
//  to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of 
//  the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
//  THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
//  DEALINGS IN THE SOFTWARE.
//

#import "SRSseEvent.h"

@interface SRSseEvent ()

@end

@implementation SRSseEvent

- (instancetype)initWithType:(EventType)type data:(NSString *)data {
    if (self = [super init]) {
        _eventType = type;
        _data = data;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%d: %@",_eventType,_data];
}

+ (BOOL)tryParseEvent:(NSString *)line sseEvent:(SRSseEvent **)sseEvent {
    *sseEvent = nil;
    
    if (line == nil) {
        //TODO: Throw HERE
    }
    
    if([line hasPrefix:@"data:"]) {
        NSString *data = [[line substringFromIndex:@"data:".length] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        *sseEvent = [[SRSseEvent alloc] initWithType:Data data:data];
        return YES;
    } else if([line hasPrefix:@"id:"]) {
        NSString *data = [line substringFromIndex:@"id:".length];
        *sseEvent = [[SRSseEvent alloc] initWithType:Id data:data];
        return YES;
    }
    
    return NO;
}

@end
