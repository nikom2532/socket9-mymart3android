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

// TODO: Auto-generated Javadoc
/**
 * Class Configuration.
 */
public class ConfigManager {
	
	/** context. */
	static Context mContext = null;
	
	/** g version code. */
	static public int gVersionCode = 0;
	
	/** g device id. */
	static public String getDeviceID = "";
	
	
	/** g user id. */
	static public String gUserID = "bc9ce5ff-1731-457f-bee3-336a99165c22";
	
	/**
	 * Inits the.
	 *
	 * @param context context
	 */
	static public void Init(Context context)
	{
		mContext = context;
		
		getDeviceID = Secure.getString(mContext.getContentResolver(), Secure.ANDROID_ID); 
        
        try {
			PackageInfo pinfo = mContext.getPackageManager().getPackageInfo(mContext.getPackageName(), 0);
			gVersionCode = pinfo.versionCode;
		} catch (NameNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	/**
	 * Clean.
	 */
	static public void Clean()
	{		
	}
	
	/**
	 * Sets private string.
	 *
	 * @param name
	 * @param val
	 */
	static public void setPrivateString(String name,String val)
	{
		SharedPreferences settings = ((Activity)mContext).getPreferences(Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = settings.edit();
        editor.putString(name, val);
        editor.commit();		
	}
	
	/**
	 * Gets private string.
	 *
	 * @param name name
	 * @return private string
	 */
	static public String getPrivateString(String name)
	{
		SharedPreferences settings = ((Activity)mContext).getPreferences(Context.MODE_PRIVATE);
		String access_token = settings.getString(name, null);
		return access_token;		
	}

}
