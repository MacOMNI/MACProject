//
//  NSUserDefaults+SecureAdditions.m
//  SecureUserDefaults
//
//  Created by Niels Mouthaan on 31-05-13.
//  Copyright (c) 2013 Niels Mouthaan. All rights reserved.
//

#import "NSUserDefaults+SecureAdditions.h"
#import "CocoaSecurity.h"

#define kStoredObjectKey              @"storedObject"

@implementation NSUserDefaults (SecureAdditions)

static NSString *_secret = @"!@#WeSchoolTeacher123_";

#pragma mark - Getter methods

- (BOOL)secretBoolForKey:(NSString *)defaultName
{
    id object = [self secretObjectForKey:defaultName];
	if([object isKindOfClass:[NSNumber class]]) {
		return [object boolValue];
	} else {
		return NO;
	}
}

- (NSData*)secretDataForKey:(NSString *)defaultName
{
    id object = [self secretObjectForKey:defaultName];
	if([object isKindOfClass:[NSData class]]) {
		return object;
	} else {
		return nil;
	}
}

- (NSDictionary*)secretDictionaryForKey:(NSString *)defaultName
{
    id object = [self secretObjectForKey:defaultName];
	if([object isKindOfClass:[NSDictionary class]]) {
		return object;
	} else {
		return nil;
	}
}

- (float)secretFloatForKey:(NSString *)defaultName
{
    id object = [self secretObjectForKey:defaultName];
	if([object isKindOfClass:[NSNumber class]]) {
		return [object floatValue];
	} else {
		return 0.f;
	}
}

- (NSInteger)secretIntegerForKey:(NSString *)defaultName
{
    id object = [self secretObjectForKey:defaultName];
	if([object isKindOfClass:[NSNumber class]]) {
		return [object integerValue];
	} else {
		return 0;
	}
}

- (NSArray *)secretStringArrayForKey:(NSString *)defaultName
{
	id objects = [self secretObjectForKey:defaultName];
	if([objects isKindOfClass:[NSArray class]]) {
		for(id object in objects) {
			if(![object isKindOfClass:[NSString class]]) {
				return nil;
			}
		}
		return objects;
	} else {
		return nil;
	}
}

- (NSString *)secretStringForKey:(NSString *)defaultName
{
    id object = [self secretObjectForKey:defaultName];
	if([object isKindOfClass:[NSString class]]) {
		return object;
	} else {
		return nil;
	}
}

- (double)secretDoubleForKey:(NSString *)defaultName
{
    id object = [self secretObjectForKey:defaultName];
	if([object isKindOfClass:[NSNumber class]]) {
		return [object doubleValue];
	} else {
		return 0;
	}
}

- (NSURL*)secretURLForKey:(NSString *)defaultName
{
    id object = [self secretObjectForKey:defaultName];
	if([object isKindOfClass:[NSURL class]]) {
		return object;
	} else {
		return nil;
	}
}

- (id)secretObjectForKey:(NSString *)defaultName
{
    // Check if we have a (valid) key needed to decrypt
    NSAssert(_secret, @"Secret may not be nil when storing an object securely");
    
    // Fetch data from user defaults
    NSData *data = [self objectForKey:defaultName];
    
    // Check if we have some data to decrypt, return nil if no
    if(data == nil) {
        return nil;
    }
    
    // Try to decrypt data
    @try {
        
        // Generate key and IV
        CocoaSecurityResult *keyData = [CocoaSecurity sha384:_secret];
        NSData *aesKey = [keyData.data subdataWithRange:NSMakeRange(0, 32)];
        NSData *aesIv = [keyData.data subdataWithRange:NSMakeRange(32, 16)];
        
        // Decrypt data
        CocoaSecurityResult *result = [CocoaSecurity aesDecryptWithData:data key:aesKey iv:aesIv];
        
        // Turn data into object and return
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:result.data];
        id object = [unarchiver decodeObjectForKey:kStoredObjectKey];
        [unarchiver finishDecoding];
        return object;
    }
    @catch (NSException *exception) {
        
        // Whoops!
        DLog(@"Cannot receive object from encrypted data storage: %@", exception.reason);
        return nil;
        
    }
    @finally {}
}

#pragma mark - Setter methods

- (void)setSecret:(NSString*)secret
{
    _secret = secret;
}

- (void)setSecretBool:(BOOL)value forKey:(NSString *)defaultName
{
    [self setSecretObject:[NSNumber numberWithBool:value] forKey:defaultName];
}

- (void)setSecretFloat:(float)value forKey:(NSString *)defaultName
{
    [self setSecretObject:[NSNumber numberWithFloat:value] forKey:defaultName];
}

- (void)setSecretInteger:(NSInteger)value forKey:(NSString *)defaultName
{
    [self setSecretObject:[NSNumber numberWithInteger:value] forKey:defaultName];
}

- (void)setSecretDouble:(double)value forKey:(NSString *)defaultName
{
    [self setSecretObject:[NSNumber numberWithDouble:value] forKey:defaultName];
}

- (void)setSecretURL:(NSURL *)url forKey:(NSString *)defaultName
{
    [self setSecretObject:url forKey:defaultName];
}

- (void)setSecretObject:(id)value forKey:(NSString *)defaultName
{
    // Check if we have a (valid) key needed to encrypt
    NSAssert(_secret, @"Secret may not be nil when storing an object securely");
    
    @try {
        
        // Create data object from dictionary
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:value forKey:kStoredObjectKey];
        [archiver finishEncoding];
        
        // Generate key and IV
        CocoaSecurityResult *keyData = [CocoaSecurity sha384:_secret];
        NSData *aesKey = [keyData.data subdataWithRange:NSMakeRange(0, 32)];
        NSData *aesIv = [keyData.data subdataWithRange:NSMakeRange(32, 16)];
        
        // Encrypt data
        CocoaSecurityResult *result = [CocoaSecurity aesEncryptWithData:data key:aesKey iv:aesIv];
        
        // Save data in user defaults
        [self setObject:result.data forKey:defaultName];
    }
    @catch (NSException *exception) {
        
        // Whoops!
        DLog(@"Cannot store object securely: %@", exception.reason);
        
    }
    @finally {}
}

@end
