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

import au.com.mymart3.mymartandroid.config.Constants;
import au.com.mymart3.mymartandroid.library.EncryptionConverter;
import au.com.mymart3.mymartandroid.library.LogFactory;
import au.com.mymart3.mymartandroid.library.LogManager;

public class GetUnitListAPI extends BaseAPI implements IGetUnitListAPI {
	
	/**
	 * Call api.
	 *
	 * @param request the request
	 */
	
	public String execute(String userID, String classID) {
		try
		{
			String requestParam = "";
			String url = "";
			
			// Make webservice param
			requestParam = "userid=" + userID
					+ "&classid=" + classID
					+ "&requestdatetime="+ getDateTime();
			url = Constants.APIServerURL + "GetUnitList?"+ requestParam + "&signature="+ EncryptionConverter.hmacSha256(requestParam);

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
