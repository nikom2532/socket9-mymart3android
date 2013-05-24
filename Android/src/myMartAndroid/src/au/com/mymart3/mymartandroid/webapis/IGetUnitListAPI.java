/*
 * 
 */
package au.com.mymart3.mymartandroid.webapis;

// TODO: Auto-generated Javadoc
/**
 * The Interface IGetUnitListAPI.
 */
public interface IGetUnitListAPI {
	
	/**
	 * Gets the unit list.
	 *
	 * @param userID the user id
	 * @param classID the class id
	 * @return the string
	 */
	public String execute(String userID, String classID);
	
	/**
	 * Gets the response.
	 *
	 * @return the response
	 */
	public String getResponse();
}