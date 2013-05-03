/*
 * 
 */
package au.com.mymart3.mymartandroid.models;

import org.json.JSONObject;

import android.app.Activity;
import android.content.Context;
import android.os.AsyncTask;
import android.os.Handler;
import au.com.mymart3.mymartandroid.config.ConfigManager;
import au.com.mymart3.mymartandroid.config.Constants;
import au.com.mymart3.mymartandroid.library.AlertManager;
import au.com.mymart3.mymartandroid.library.LogManager;
import au.com.mymart3.mymartandroid.library.LogFactory;
import au.com.mymart3.mymartandroid.library.EncryptionConverter;
import au.com.mymart3.mymartandroid.webapis.AuthenticateDeviceQuickPinAPI;
import au.com.mymart3.mymartandroid.webapis.BaseAPI;
import au.com.mymart3.mymartandroid.webapis.IAuthenticateAPI;
import au.com.mymart3.mymartandroid.webapis.IAuthenticateDeviceQuickPinAPI;

// TODO: Auto-generated Javadoc
/**
 * The Class AuthenticateDeviceQuickPin.
 */
public class AuthenticateDeviceQuickPinModel extends BaseModel{
	
	
	/** The m quickpin. */
	public String mQuickpin = "";
	
	/** The m deviceid. */
	public String mDeviceID = "";
	
	// Result
	/** The Authenticated. */
	public Boolean authenticated = false;
	
	/** The User id. */
	public String userID="";

	/** The _api. */
	public IAuthenticateDeviceQuickPinAPI _api = null;


	/**
	 * Instantiates a new authenticate device quick pin.
	 */
	
	public AuthenticateDeviceQuickPinModel() {
		_api = new AuthenticateDeviceQuickPinAPI();
	}
	
	/**
	 * Instantiates a new authenticate device quick pin model.
	 *
	 * @param api the api
	 */
	public AuthenticateDeviceQuickPinModel(IAuthenticateDeviceQuickPinAPI api) {
		_api = api;
	}
	
	
	/**
	 * Do authenticate device quick pin.
	 *
	 * @param QuickPin the quickpin
	 * @param DeviceID the deviceid
	 * @return the async task
	 */
	public AsyncTask AuthenticateDeviceQuickPin(String QuickPin,String DeviceID) {
		// Save required param
		mQuickpin = QuickPin;
		mDeviceID = DeviceID;
		
		// Call async task to do job
		AuthenticateDeviceQuickPinTask authenticateDeviceQuickPinTask = new AuthenticateDeviceQuickPinTask();
		authenticateDeviceQuickPinTask.execute();
		return authenticateDeviceQuickPinTask;
	}
	
	/**
	 * The Class AuthenticateDeviceQuickPinTask.
	 */
	private class AuthenticateDeviceQuickPinTask extends AsyncTask<Object, Void, Void> {

    	/* (non-Javadoc)
	     * @see android.os.AsyncTask#onPreExecute()
	     */
//	    @Override
//    	protected void onPreExecute() {
//    		// Display wait dialog
//    		Handler handler = new Handler();
//    		handler.post(new Runnable() {
//				public void run() { helper.showWaitDlg(mContext, "AuthenticateDeviceQuickPin...", null); } 
//			});
//    	} 
		
    	
		/* (non-Javadoc)
		 * @see android.os.AsyncTask#doInBackground(Params[])
		 */
		@Override
		protected Void doInBackground(Object... params) {
			
			try {
				// Call web service
				errorMessage = _api.execute(mQuickpin, mDeviceID);
				response = _api.getResponse();
				
				// Check connection result
				if(!errorMessage.equalsIgnoreCase("success")) return null;
				
				// Parse result
				JSONObject jsonResult = new JSONObject(response);
				JSONObject AuthenticateJsonResultObj = jsonResult.getJSONObject("AuthenticateDeviceQuickPinJsonResult");
				
				authenticated = AuthenticateJsonResultObj.getBoolean("Authenticated");
				exceptionMessage = AuthenticateJsonResultObj.getString("ExceptionMessage");
				userID = AuthenticateJsonResultObj.getString("UserID");
				
			} catch (Exception e) {
				log.debug(e.toString());
				errorMessage = e.toString();
			}			
			return null;
		}

		/* (non-Javadoc)
		 * @see android.os.AsyncTask#onPostExecute(java.lang.Object)
		 */
		@Override
		protected void onPostExecute(Void result)
        {
			super.onPostExecute(result);
			
			
        	
        	// Call on complete function
        	if(null != onCompleteCallback) onCompleteCallback.run();
        }		
	}
}
