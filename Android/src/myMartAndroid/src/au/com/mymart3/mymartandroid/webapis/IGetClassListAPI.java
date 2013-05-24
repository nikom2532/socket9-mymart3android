/*
 * 
 */
package au.com.mymart3.mymartandroid.webapis;

/**
 * The Interface IGetClassListAPI.
 */
public interface IGetClassListAPI {
	
	/**
	 * Gets the class list.
	 *
	 * @param userID the user id
	 * @return the string
	 */
	public String execute(String userID);
	
	/**
	 * Gets the response.
	 *
	 * @return the response
	 */
	public String getResponse();
}