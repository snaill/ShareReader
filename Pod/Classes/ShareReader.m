//
//  ShareReader.m
//  ShareReader
//
//  Created by Snaill on 15/9/19.
//  Copyright © 2015年 sharepai. All rights reserved.
//

#import "ShareReader.h"
#import "ReaderViewController.h"

@implementation ShareReader

+ (id)readerWithID:(NSString *)ID {
    ReaderViewController * vc = [ReaderViewController new];
    [vc readerWithPostID:ID];
    return vc;
}

+ (id)readerWithURL:(NSURL *)url {
    ReaderViewController * vc = [ReaderViewController new];
    [vc readerWithURL:url];
    return vc;
}

@end
