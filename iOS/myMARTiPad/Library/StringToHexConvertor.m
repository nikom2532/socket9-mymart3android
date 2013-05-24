//
//  StringToHexConvertor.m
//  myMARTiPad
//

#import "StringToHexConvertor.h"

@implementation StringToHexConvertor


/**
 * Method name: convertStringToHex :
 * Description: For converting string to Hex
 * Parameters: str
 * Return: hexString
 */

+ (NSMutableString *)convertStringToHex:(NSString *)str{
    
    if ([str length] != 0) {
        
        NSUInteger len = [str length];
        unichar *chars = malloc(len * sizeof(unichar));
        [str getCharacters:chars];
        
        NSMutableString *hexString = [[NSMutableString alloc] init];
        
        for(NSUInteger i = 0; i < len; i++ )
        {
            [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
        }
        free(chars);

        return hexString;
        
    }else{
        
        return nil;
    }
   
}

@end
