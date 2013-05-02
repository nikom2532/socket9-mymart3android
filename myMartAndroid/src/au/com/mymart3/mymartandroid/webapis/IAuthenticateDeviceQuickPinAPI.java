/*
 * 
 */
package au.com.mymart3.mymartandroid.webapis;

// TODO: Auto-generated Javadoc
/**
 * The Interface IAuthenticateDeviceQuickPinAPI.
 */
public interface IAuthenticateDeviceQuickPinAPI {
	
	/**
	 * Authenticate device quick pin.
	 *
	 * @param quickPin the quick pin
	 * @param deviceID the device id
	 * @return the string
	 */
	public String execute(String quickPin, String deviceID);
	
	/**
	 * Gets the response.
	 *
	 * @return the response
	 */
	public String getResponse();
}
