package au.com.mymart3.mymartandroid.testModel;
import au.com.mymart3.mymartandroid.models.*;
import au.com.mymart3.mymartandroid.webapis.IAuthenticateDeviceQuickPinAPI;

import au.com.mymart3.mymartandroid.webapis.*;

public class AuthenticateDeviceQuickPinMock extends BaseAPI implements IAuthenticateDeviceQuickPinAPI {

	public String mExpectedResult = null;
	
	public AuthenticateDeviceQuickPinMock(String expectedResult){
		mExpectedResult = expectedResult;
	}
	
	@Override
	public String execute(String quickPin, String deviceID)
	{
		// TODO Auto-generated method stub
		
		response = "";
		
		errorMessage = "success";
        
		return errorMessage;
	}

}