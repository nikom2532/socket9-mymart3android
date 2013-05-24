/*
 * 
 */
package au.com.mymart3.mymartandroid.webapis;

//import java.text.SimpleDateFormat;
//import java.util.Date;
import java.lang.reflect.UndeclaredThrowableException;

import android.util.Log;
import au.com.mymart3.mymartandroid.config.Constants;
import au.com.mymart3.mymartandroid.library.EncryptionConverter;



/**
 * The Class AuthenticateAPI.
 */
public class AuthenticateAPI extends BaseAPI implements IAuthenticateAPI {
	
//	public S
	/**
 * authenticate.
 *
 * @param userName the user name
 * @param password the password
 * @return the string
 */
	
	
	/**
	 * Call api.
	 * @param UserName the username
	 * @param Password the password
	 *
	 * @param request the request
	 */
	public String execute(String userName,String password) {
		
		
		try
		{
			EncryptionConverter.Result usernameResult;
			EncryptionConverter.Result passwordResult;		
			String requestParam = "";
			String url = "";
			// Make webservice param
			usernameResult = EncryptionConverter.encrypt(userName);
			passwordResult = EncryptionConverter.encrypt(password);
			
			requestParam = "username="+usernameResult.result
							+ "&password="+passwordResult.result
							+ "&useriv="+usernameResult.iv
							+ "&passiv="+passwordResult.iv
							+ "&requestdatetime="+ getDateTime();
			url = Constants.APIServerURL + "Authenticate?"+requestParam + "&signature="+ EncryptionConverter.hmacSha256(requestParam);
			
			
			Log.v("## url ####", url);

			
			callAPI(url);
		}
		catch(UndeclaredThrowableException e)
		{
			log.debug(e.getUndeclaredThrowable().getMessage());
			errorMessage  = e.getUndeclaredThrowable().getMessage();
		}
		catch (Exception e) 
		{
			log.debug(e.getCause() + " : " + e.getMessage());
			errorMessage = e.getCause() + " : " + e.getMessage();
		}
		
		return errorMessage;
	}
}
