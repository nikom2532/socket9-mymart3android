package au.com.mymart3.mymartandroid.webapis;

// TODO: Auto-generated Javadoc
/**
 * The Interface IAuthenticateDeviceQuickPinAPI.
 */
public interface IAuthenticateDeviceQuickPinAPI {
	
	/**
	 * Authenticate device quick pin.
	 *
	 * @param QuickPin the quick pin
	 * @param DeviceID the device id
	 */
	public String execute(String quickPin, String deviceID);
	public String getResponse();
}
