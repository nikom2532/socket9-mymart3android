/*
 * 
 */
package au.com.mymart3.mymartandroid.config;

import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.provider.Settings.Secure;

/**
 * Class Configuration: to store all configuration values centralize, the value can be referenced later in the app 
 */
public class ConfigManager {
	
	/** context. */
	static Context mContext = null;
	
	/** code version number */
	static public int gVersionCode = 0;
	
	/** device ID. */
	static public String getDeviceID = "";
	
	
	/** user ID. */
	static public String gUserID = "bc9ce5ff-1731-457f-bee3-336a99165c22";
	
	/**
	 * Init
	 * Initializes the variables, get values from the devices, etc.
	 * @param context
	 * @exception  
	 */
	static public void init(Context context)
	{
		// store the value in member variable
		mContext = context;
		
		// get device id and store in member variable
		getDeviceID = Secure.getString(mContext.getContentResolver(), Secure.ANDROID_ID); 
        
        try {
			PackageInfo pinfo = mContext.getPackageManager().getPackageInfo(mContext.getPackageName(), 0);
			gVersionCode = pinfo.versionCode;
		} catch (NameNotFoundException e) {
			e.printStackTrace();
		}		
	}
	
	/**
	 * Clean
	 * cleans up variables
	 */
	static public void clean()
	{		
	}
	
	/**
	 * setPrivateString
	 * Sets pair of string, value
	 *
	 * @param key
	 * @param value
	 */
	static public void setPrivateString(String name,String val)
	{
		SharedPreferences settings = ((Activity)mContext).getPreferences(Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = settings.edit();
        editor.putString(name, val);
        editor.commit();		
	}
	
	/**
	 * getPrivateString
	 * Gets value of the given key
	 *
	 * @param name: key to get its value
	 * @exception if no such given key or any other unexpected error 
	 * @return value of the given key
	 */
	static public String getPrivateString(String name)
	{
		// value from the key
		String val = "";
		
		try
		{
			SharedPreferences settings = ((Activity)mContext).getPreferences(Context.MODE_PRIVATE);
			val = settings.getString(name, null);
		}
		catch(Exception e)
		{}
		
		return val;		
	}

}
