/*
 * 
 */
package au.com.mymart3.mymartandroid.webapis;

import java.lang.reflect.UndeclaredThrowableException;


import au.com.mymart3.mymartandroid.config.Constants;
import au.com.mymart3.mymartandroid.library.EncryptionConverter;

// TODO: Auto-generated Javadoc
/**
 * The Class GetUnitListAPI.
 */
public class GetUnitListAPI extends BaseAPI implements IGetUnitListAPI {
	
	/**
	 * Call api.
	 *
	 * @param userID the user id
	 * @param classID the class id
	 * @return the string
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
