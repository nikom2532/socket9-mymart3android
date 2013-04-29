package au.com.mymart3.mymartandroid.webapis;

//import java.text.SimpleDateFormat;
//import java.util.Date;
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
import au.com.mymart3.mymartandroid.models.AuthenticateModel;



public class AuthenticateAPI extends BaseAPI implements IAuthenticateAPI {
	
//	public S
	/**
	 * authenticate.
	 *
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
