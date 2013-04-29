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
import au.com.mymart3.mymartandroid.webapis.BaseAPI;
import au.com.mymart3.mymartandroid.webapis.IRegisterDeviceQuickPinAPI;
import au.com.mymart3.mymartandroid.webapis.RegisterDeviceQuickPinAPI;

// TODO: Auto-generated Javadoc
/**
 * The Class RegisterDeviceQuickPin.
 */
public class RegisterDeviceQuickPinModel extends BaseModel {
	

	/** The m user id. */
	public String mUserID = "";
	
	/** The m quickpin. */
	public String mQuickpin = "";
	
	/** The m deviceid. */
	public String mDeviceid = "";
	
	/** The m forceoverride. */
	public Boolean mForceoverride = false;
	
	// Result
	/** The Register success. */
	public Boolean registerSuccess = false;
	
	/** The Already registered. */
	public Boolean alreadyRegistered = false;
	
	IRegisterDeviceQuickPinAPI _api = null;

	/**
	 * Instantiates a new register device quick pin api.
	 *
	 * @param context the context
	 * @param onRegisterDeviceQuickPinComplete the on register device quick pin complete
	 */
	public RegisterDeviceQuickPinModel() {
		_api = new RegisterDeviceQuickPinAPI();
	}
	
	/**
	 * Instantiates a new register device quick pin.
	 */
	public RegisterDeviceQuickPinModel(IRegisterDeviceQuickPinAPI api) {
		_api = api;
	}
	
	
	/**
	 * Do register device quick pin.
	 *
	 * @param userid the userid
	 * @param QuickPin the quickpin
	 * @param DeviceID the deviceid
	 * @param forceoverride the forceoverride
	 */
	public AsyncTask RegisterDeviceQuickPin(String userid, String QuickPin,String DeviceID,Boolean forceoverride) {
		// Save required param
		mUserID  = userid;
		mQuickpin = QuickPin;
		mDeviceid = DeviceID;
		mForceoverride = forceoverride;
		
		// Call async task to do job
		RegisterDeviceQuickPinTask registerDeviceQuickPinTask = new RegisterDeviceQuickPinTask();
		registerDeviceQuickPinTask.execute();
		return registerDeviceQuickPinTask;
	}
	
	/**
	 * The Class RegisterDeviceQuickPinTask.
	 */
	private class RegisterDeviceQuickPinTask extends AsyncTask<Object, Void, Void> {

    	/* (non-Javadoc)
	     * @see android.os.AsyncTask#onPreExecute()
	     */
//	    @Override
//    	protected void onPreExecute() {
//    		// Display wait dialog
//    		Handler handler = new Handler();
//    		handler.post(new Runnable() {
//				public void run() { helper.showWaitDlg(mContext, "RegisterDeviceQuickPin...", null); } 
//			});
//    	} 
    	
		/* (non-Javadoc)
		 * @see android.os.AsyncTask#doInBackground(Params[])
		 */
		@Override
		protected Void doInBackground(Object... params) {

			
			try {
				
				// Call web service
				errorMessage = _api.execute(mUserID, mQuickpin, mDeviceid, mForceoverride);
				response = _api.getResponse();
				
				// Check connection result
				if(!errorMessage.equalsIgnoreCase("success")) return null;
				
				// Parse result
				JSONObject jsonResult = new JSONObject(response);
				JSONObject jsonRegisterDeviceQuickPinJsonResult = jsonResult.getJSONObject("RegisterDeviceQuickPinJsonResult");
				
				registerSuccess = jsonRegisterDeviceQuickPinJsonResult.getBoolean("RegisterSuccess");
				alreadyRegistered = jsonRegisterDeviceQuickPinJsonResult.getBoolean("AlreadyRegistered");
				exceptionMessage = jsonRegisterDeviceQuickPinJsonResult.getString("ExceptionMessage");
				
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
			

			// Close wait dialog
        	AlertManager.hideWaitDlg();
        	
        	// Call on complete function
        	if(null != onCompleteCallback) onCompleteCallback.run();
        }		
	}
}
