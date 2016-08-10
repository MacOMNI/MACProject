//
//  NSUserDefaults+SecureAdditions.h
//  SecureUserDefaults
//
//  Created by Niels Mouthaan on 31-05-13.
//  Copyright (c) 2013 Niels Mouthaan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (SecureAdditions)

- (void)setSecret:(NSString*)secret;

- (BOOL)secretBoolForKey:(NSString *)defaultName;
- (NSData*)secretDataForKey:(NSString *)defaultName;
- (NSDictionary*)secretDictionaryForKey:(NSString *)defaultName;
- (float)secretFloatForKey:(NSString *)defaultName;
- (NSInteger)secretIntegerForKey:(NSString *)defaultName;
- (NSArray *)secretStringArrayForKey:(NSString *)defaultName;
- (NSString *)secretStringForKey:(NSString *)defaultName;
- (double)secretDoubleForKey:(NSString *)defaultName;
- (NSURL*)secretURLForKey:(NSString *)defaultName;
- (id)secretObjectForKey:(NSString *)defaultName;

- (void)setSecretBool:(BOOL)value forKey:(NSString *)defaultName;
- (void)setSecretFloat:(float)value forKey:(NSString *)defaultName;
- (void)setSecretInteger:(NSInteger)value forKey:(NSString *)defaultName;
- (void)setSecretDouble:(double)value forKey:(NSString *)defaultName;
- (void)setSecretURL:(NSURL *)url forKey:(NSString *)defaultName;
- (void)setSecretObject:(id)value forKey:(NSString *)defaultName;

@end
