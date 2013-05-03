/*
 * 
 */
package au.com.mymart3.mymartandroid.webapis;

// TODO: Auto-generated Javadoc
/**
 * The Interface IAuthenticateAPI.
 */
public interface IAuthenticateAPI {

	/**
	 * Execute.
	 *
	 * @param userName the user name
	 * @param password the password
	 * @return the string
	 */
	public String execute(String userName,String password);
	
	/**
	 * Gets the response.
	 *
	 * @return the response
	 */
	public String getResponse();
}
