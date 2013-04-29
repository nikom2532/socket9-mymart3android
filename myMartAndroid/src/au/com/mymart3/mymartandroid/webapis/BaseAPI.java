/*
 * 
 */
package au.com.mymart3.mymartandroid.webapis;

import java.lang.reflect.UndeclaredThrowableException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

//import android.content.res.Configuration;
import au.com.mymart3.mymartandroid.config.ConfigManager;
import au.com.mymart3.mymartandroid.config.Constants;
import au.com.mymart3.mymartandroid.library.LogManager;
import au.com.mymart3.mymartandroid.library.LogFactory;

// TODO: Auto-generated Javadoc
/**
 * The Class BaseWebAPI.
 */
public class BaseAPI {
	
	/** The Constant log. */
	protected static final LogManager log = LogFactory.getLog(BaseAPI.class);
	
	/** The m response. */
	public String response = "";
	
	/** The m error. */
	public String errorMessage = "unknow error";
	
	/**
	 * Call api.
	 *
	 * @param request the request
	 */
	public String callAPI(String url) {
		try
		{
            HttpClient httpClient = new DefaultHttpClient();
            HttpContext localContext = new BasicHttpContext();

            log.debug("webAPI : " + "Request: " + url);
            
        	// Send request to web server
            HttpGet httpGet = new HttpGet(url);
            HttpResponse hrp = httpClient.execute(httpGet, localContext);
            HttpEntity myEntity = hrp.getEntity();
            
            // Save result
            response = EntityUtils.toString(myEntity);
            
			log.debug("webAPI : " + "Response: " + response );
			errorMessage = "success";			
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
	
	/**
	 * Gets the date time.
	 *
	 * @return the date time
	 */
	public static String getDateTime() {
		SimpleDateFormat dateFormatGmt = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",Locale.US);
		dateFormatGmt.setTimeZone(TimeZone.getTimeZone("UTC"));
		return dateFormatGmt.format(new Date());
	}	
	
	public String getResponse()
	{
		return response;
	}
	
}
