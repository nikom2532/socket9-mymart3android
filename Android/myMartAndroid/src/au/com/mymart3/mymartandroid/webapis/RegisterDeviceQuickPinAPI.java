/*
 * 
 */
package au.com.mymart3.mymartandroid.webapis;

import java.lang.reflect.UndeclaredThrowableException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;

import android.util.Log;
import au.com.mymart3.mymartandroid.config.Constants;
import au.com.mymart3.mymartandroid.library.EncryptionConverter;
import au.com.mymart3.mymartandroid.library.LogFactory;
import au.com.mymart3.mymartandroid.library.LogManager;

// TODO: Auto-generated Javadoc
/**
 * The Class RegisterDeviceQuickPinAPI.
 */
public class RegisterDeviceQuickPinAPI extends BaseAPI implements IRegisterDeviceQuickPinAPI {


	/**
	 * Call api.
	 *
	 * @param userID the user id
	 * @param quickPin the quick pin
	 * @param deviceID the device id
	 * @param forceOverride the force override
	 * @return the string
	 */
	public String execute(String userID, String quickPin, String deviceID, Boolean forceOverride) {
		try
		{
			EncryptionConverter.Result quickpinResult;
			EncryptionConverter.Result deviceidResult;		
			String requestParam = "";
			String url = "";
			
			// Make webservice param
			quickpinResult = EncryptionConverter.encrypt(quickPin);
			deviceidResult = EncryptionConverter.encrypt(deviceID);
			
			requestParam = "userid="+ userID
							+ "&quickpin=" + quickpinResult.result
							+ "&deviceid=" + deviceidResult.result
							+ "&quickpiniv=" + quickpinResult.iv
							+ "&deviceidiv=" + deviceidResult.iv
							+ "&forceoverride="+ forceOverride.toString()
							+ "&requestdatetime="+ getDateTime();
			url = Constants.APIServerURL + "RegisterDeviceQuickPin?"+requestParam + "&signature="+ EncryptionConverter.hmacSha256(requestParam);
			
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
