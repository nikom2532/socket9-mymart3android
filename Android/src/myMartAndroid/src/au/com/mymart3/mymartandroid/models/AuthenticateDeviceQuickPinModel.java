/*
 * 
 */
package au.com.mymart3.mymartandroid.models;

import org.json.JSONObject;

import android.os.AsyncTask;
import au.com.mymart3.mymartandroid.webapis.AuthenticateDeviceQuickPinAPI;
import au.com.mymart3.mymartandroid.webapis.IAuthenticateDeviceQuickPinAPI;

/**
 * The Class AuthenticateDeviceQuickPin.
 */
public class AuthenticateDeviceQuickPinModel extends BaseModel{
	
	
	/** The quick pin value */
	public String mQuickpin = "";
	
	/** The device id value */
	public String mDeviceID = "";
	
	// Result
	/** The authenticated flag  */
	public Boolean authenticated = false;
	
	/** The User id. */
	public String userID="";

	/** The api object */
	public IAuthenticateDeviceQuickPinAPI _api = null;


	/**
	 * AuthenticateDeviceQuickPinModel, constructor
	 * Instantiates a new authenticate device quick pin.
	 */
	
	public AuthenticateDeviceQuickPinModel() {
		_api = new AuthenticateDeviceQuickPinAPI();
	}
	
	/**
	 * AuthenticateDeviceQuickPinModel, constructor
	 * Instantiates a new authenticate device quick pin model.
	 *
	 * @param api the api
	 */
	public AuthenticateDeviceQuickPinModel(IAuthenticateDeviceQuickPinAPI api) {
		_api = api;
	}
	
	
	/**
	 * AuthenticateDeviceQuickPin
	 * Performs authenticate device quick pin.
	 *
	 * @param QuickPin the quickpin
	 * @param DeviceID the deviceid
	 * @return the async task
	 */
	public AsyncTask authenticateDeviceQuickPin(String QuickPin,String DeviceID) {
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
