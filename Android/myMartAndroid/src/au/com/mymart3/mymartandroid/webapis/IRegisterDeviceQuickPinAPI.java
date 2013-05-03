/*
 * 
 */
package au.com.mymart3.mymartandroid.webapis;

import android.app.Activity;

// TODO: Auto-generated Javadoc
/**
 * The Interface IRegisterDeviceQuickPinAPI.
 */
public interface IRegisterDeviceQuickPinAPI {
	
	/**
	 * Execute.
	 *
	 * @param userID the user id
	 * @param quickPin the quick pin
	 * @param deviceID the device id
	 * @param forceOverride the force override
	 * @return the string
	 */
	public String execute(String userID, String quickPin, String deviceID, Boolean forceOverride);
	
	/**
	 * Gets the response.
	 *
	 * @return the response
	 */
	public String getResponse();
}