/*
 * 
 */
package au.com.mymart3.mymartandroid.webapis;

import java.lang.reflect.UndeclaredThrowableException;

import au.com.mymart3.mymartandroid.config.Constants;
import au.com.mymart3.mymartandroid.library.EncryptionConverter;

// TODO: Auto-generated Javadoc
/**
 * The Class AuthenticateDeviceQuickPinAPI.
 */
public class AuthenticateDeviceQuickPinAPI extends BaseAPI implements IAuthenticateDeviceQuickPinAPI {
	
	/**
	 * Call api.
	 *
	 * @param quickpin the quickpin
	 * @param deviceid the deviceid
	 * @return the string
	 */
	public String execute(String quickpin, String deviceid) {
		try
		{
			EncryptionConverter.Result quickpinResult;
			EncryptionConverter.Result deviceidResult;		
			String requestParam = "";
			String url = "";
			
			// Make webservice param
			quickpinResult = EncryptionConverter.encrypt(quickpin);
			deviceidResult = EncryptionConverter.encrypt(deviceid);
			
			requestParam = "quickpin="+quickpinResult.result
							+ "&deviceid="+deviceidResult.result
							+ "&quickpiniv="+quickpinResult.iv
							+ "&deviceidiv="+deviceidResult.iv
							+ "&requestdatetime="+ getDateTime();
			url = Constants.APIServerURL + "AuthenticateDeviceQuickPin?"+requestParam + "&signature="+ EncryptionConverter.hmacSha256(requestParam);
			
			callAPI(url);
		} 
		catch(UndeclaredThrowableException e)
		{
			log.debug(e.getUndeclaredThrowable().getMessage());
			errorMessage = e.getUndeclaredThrowable().getMessage();
		}
		catch (Exception e) 
		{
			log.debug(e.getCause() + " : " + e.getMessage());
			errorMessage = e.getCause() + " : " + e.getMessage();
		}
		
		return errorMessage;
	}

}
