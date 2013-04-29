package au.com.mymart3.mymartandroid.testModel;

import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;
import au.com.mymart3.mymartandroid.library.LogFactory;
import au.com.mymart3.mymartandroid.library.LogManager;
import au.com.mymart3.mymartandroid.models.*;
import au.com.mymart3.mymartandroid.webapis.*;

public class AuthenticateMock extends BaseAPI implements IAuthenticateAPI {
	
	// 1 = success
	// 2 = incorrect password
	// 3 = invalid user
	// 4 = incorrect user and password
	public String mExpectedResult = "";
	

	public AuthenticateMock(String expectedResult)
	{
		mExpectedResult = expectedResult;
	}
	
	public String execute(String userName, String password) {
		// TODO Auto-generated method stub

		//		try {
//			
//			// Parse result
//			mResponse = "{\"AuthenticateJsonResult\":{\"Authenticated\":true,\"ExceptionMessage\":null,\"UserID\":\"bc9ce5ff-1731-457f-bee3-336a99165c22\"}}";
//			JSONObject jsonResult = new JSONObject(mResponse);
//			JSONObject AuthenticateJsonResultObj = jsonResult.getJSONObject("AuthenticateJsonResult");
//			Authenticated = AuthenticateJsonResultObj.getBoolean("Authenticated");
//			ExceptionMessage = AuthenticateJsonResultObj.getString("ExceptionMessage");
//			UserID = AuthenticateJsonResultObj.getString("UserID");			
//		} catch (Exception e) {
//			log.debug(e.toString());
//			mError = e.toString();
//		}
		
		    response = mExpectedResult;
//        	Log.v("## 2 ##", response);
//            break;
        
//        }
		
        errorMessage = "success";
        
        return errorMessage;
	}
	
}