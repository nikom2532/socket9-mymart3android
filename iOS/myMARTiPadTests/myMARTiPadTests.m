//
//  myMARTiPadTests.m
//  myMARTiPadTests
//

#import "myMARTiPadTests.h"

@implementation myMARTiPadTests

- (void)setUp{[super setUp];} //Setup

- (void)tearDown{[super tearDown];} //Teardown

//Test01_Class=RandomGenerator#Function=GetNewRandomKey
- (void)testGetNewRandomKey_Nominal
{
    //Get a new random key
    NSString *newRandomString= [RandomGenerator getNewRandomKey];
    
    //Assert#Generated random key must be of length 16
    STAssertTrue([newRandomString length]==16,@"Random key must be of length 16");
}

// Test02_Class=StringToHexConvertor#Function=convertStringToHex
- (void)testConvertStringToHex_Nominal
{
    //Input variable
    NSString *input=@"stirling.admin";
    
    //Expected output
    NSString *expectedOutput = @"737469726c696e672e61646d696e";
    
    //Convert input string to hex
    NSString *output=[StringToHexConvertor convertStringToHex:input];
    
    //Assert#Comparing output and expectedOutput,
    STAssertEqualObjects(output,expectedOutput,nil);
}

//Test03_Class=StringToHexConvertor#Function=convertStringToHex
- (void)testConvertStringToHex_Errorneous_WithEmptyInputString
{
    //Input variable
    NSString *input=@"";
    
    //Expected output
    NSString *expectedOutput = nil;
    
    //Convert input string to hex
    NSString *output=[StringToHexConvertor convertStringToHex:input];
    
    //Assert#Comparing output and expectedOutput
    STAssertEqualObjects(output,expectedOutput,nil);
}


//Test04_Class=NSString+HexToByteConverter#Function=convertHexToByte
- (void)testConvertHexToByte_Nominal
{
    //Input variable
    NSString *input=@"6f646a7861736e776d386b376c626d7a";
    
    //Expected output
    const char bytes[]="\x6f\x64\x6a\x78\x61\x73\x6e\x77\x6d\x38\x6b\x37\x6c\x62\x6d\x7a";
    NSData *expectedOutput =[NSData dataWithBytes:bytes length:16];
    
    //Convert input hex string to bytes
    NSData *output=[input convertHexToBytes];
    
    //Assert#Comparing output and expectedOutput
    STAssertEqualObjects(output,expectedOutput,nil);
}

//Test05_Class=NSString+HexToByteConverter#Function=convertHexToByte
- (void)testConvertHexToByte_Errorneous_WithEmptyInputString
{
    //Input variable
    NSString *input=@"";
    
    //Expected output
    NSData *expectedOutput = nil;
    
    //Convert input string to hex
    NSData *output=[input convertHexToBytes];
    
    //Assert#Comparing output and expectedOutput
    STAssertEqualObjects(output,expectedOutput,nil);
}

//Test06_Class=NSData+Base64Converter#Function=convertToBase64
- (void)testConvertToBase64_Errorneous_WithEmptyStringToConvert
{
    //Input variable
    NSData*input=nil;
    
    //Expected output
    NSString *expectedOutput=nil;
    
    //Convert input to base64 string
    NSString *output= [input convertToBase64];
    
    //Assert#Comparing output and expectedOutput
    STAssertEqualObjects(output,expectedOutput,nil);
}

//Test07_Class=NSData+Base64Converter#Function=convertToBase64
- (void)testConvertToBase64_Nominal
{
    //Input variable
    const char bytes[]="\x70\x73\x62\x61\x72\x36\x6b\x6f\x74\x66\x6d\x68\x32\x6d\x66\x6a";
    NSData *input =[NSData dataWithBytes:bytes length:16];
    
    //Expected output
    NSString *expectedOutput=@"cHNiYXI2a290Zm1oMm1mag2";
    
    //Convert input to base64 string
    NSString *output= [input convertToBase64];
    
    //Assert#Comparing output and expectedOutput
    STAssertEqualObjects(output,expectedOutput,nil);
}

//Test08_Class=SignatureGenerator#Function=getSignature
- (void)testGetSignature_Nominal
{
    //Input variable
    NSString*inputQueryString=@"username=7DaAFgPldUQM9c0kWUgi5w2&password=Rvmg3ouf44ViiJ87LgO3zA2&useriv=bzMxeWY3ZmhlOGE0aHdhOQ2&"
    "passiv=OHIzbXBiazQ5MmhsenluYw2&requestdatetime=2013-05-15T11:00:39.003Z";
    
    ConfigManager *configManager = [[ConfigManager alloc]init];
    NSString *inputPrivateSignatureKey =configManager.privateSignatureKey;
    
    //Expected output
    NSString *expectedOutputSignature=@"3a1tMFfK9ONB_3-qD_KGsJT01sNilRdrW3oBcXJFwFE1";
    
    //Get signature
    NSString *outputSignature= [SignatureGenerator getSignature:inputQueryString :inputPrivateSignatureKey];
    
    //Assert#Comparing output and expectedOutput
    STAssertEqualObjects(outputSignature,expectedOutputSignature,nil);
}

//Test09_Class=SignatureGenerator#Function=getSignature
- (void)testGetSignature_Errorneous_WithEmptyInputString
{
    //Input variable
    NSString*inputQueryString=@"";
    
    ConfigManager *configManager = [[ConfigManager alloc]init];
    NSString *inputPrivateSignatureKey =configManager.privateSignatureKey;
    
    //Expected output
    NSString *expectedOutputSignature=nil;
    
    //Get signature
    NSString *outputSignature= [SignatureGenerator getSignature:inputQueryString :inputPrivateSignatureKey];
    
    //Assert#Comparing output and expectedOutput
    STAssertEqualObjects(outputSignature,expectedOutputSignature,nil);
}

//Test10_Class=SignatureGenerator#Function=getSignature
- (void)testGetSignature_Errorneous_WithEmptyPrivateSignatureKey
{
    //Input variable
    NSString*inputQueryString=@"username=7DaAFgPldUQM9c0kWUgi5w2&password=Rvmg3ouf44ViiJ87LgO3zA2&useriv=bzMxeWY3ZmhlOGE0aHdhOQ2&"
    "passiv=OHIzbXBiazQ5MmhsenluYw2&requestdatetime=2013-05-15T11:00:39.003Z";
    
    NSString *inputPrivateSignatureKey =@"";
    
    //Expected output
    NSString *expectedOutputSignature=nil;
    
    //Get signature
    NSString *outputSignature= [SignatureGenerator getSignature:inputQueryString :inputPrivateSignatureKey];
    
    //Assert#Comparing output and expectedOutput
    STAssertEqualObjects(outputSignature,expectedOutputSignature,nil);
}


//Test11_Class=Login#Function=loginWithUsernameAndPassword
- (void)testLoginWithUserNameAndPassword_Nominal
{
    //Input variables
    NSString *inputUsername=@"stirling.admin";
    NSString *inputPassword=@"duck121";
    
    //Mock api instance
    AuthenticateAPI_Nominal *mockAPI = [[AuthenticateAPI_Nominal alloc]init];
    
    //init Login model instance
    Login *loginVar;
    loginVar=[[Login alloc] init:mockAPI];
    loginVar = [Login sharedInstance];
    
    //Call to loginWithUsernameAndPassword
    [loginVar loginWithUsernameAndPassword:inputUsername :inputPassword];
    
    //Wait for control to pass back to callback function
    [myMARTiPadTestConfig waitAsyncTaskForSeconds:10];
    
    NSLog(@"Mocked Result=%@",loginVar.userID);
    
    //Assert
    ///STAssertTrue(loginVar.authenticated==YES,@"Authenticate flag must be YES");
}

@end
