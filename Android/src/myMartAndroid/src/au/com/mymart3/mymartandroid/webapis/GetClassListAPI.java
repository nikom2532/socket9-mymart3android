/*
 * 
 */
package au.com.mymart3.mymartandroid.webapis;

import java.lang.reflect.UndeclaredThrowableException;

import au.com.mymart3.mymartandroid.config.Constants;
import au.com.mymart3.mymartandroid.library.EncryptionConverter;

// TODO: Auto-generated Javadoc
/**
 * The Class GetClassListAPI.
 */
public class GetClassListAPI extends BaseAPI implements IGetClassListAPI{
	
	/**
	 * Call api.
	 *
	 * @param userID the user id
	 * @return the string
	 */
	public String execute(String userID) {
		try
		{
			String requestParam = "";
			String url = "";
			
			// Make webservice param
			requestParam = "userid=" + userID
					+ "&requestdatetime="+ getDateTime();
			url = Constants.APIServerURL + "GetClassList?"+ requestParam + "&signature="+ EncryptionConverter.hmacSha256(requestParam);
			
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
