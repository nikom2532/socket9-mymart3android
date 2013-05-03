/*
 * 
 */
package au.com.mymart3.mymartandroid.models;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.content.Context;
import android.os.AsyncTask;
import android.os.Handler;
import android.util.Log;
import au.com.mymart3.mymartandroid.config.ConfigManager;
import au.com.mymart3.mymartandroid.config.Constants;
import au.com.mymart3.mymartandroid.library.AlertManager;
import au.com.mymart3.mymartandroid.library.LogManager;
import au.com.mymart3.mymartandroid.library.LogFactory;
import au.com.mymart3.mymartandroid.library.EncryptionConverter;
import au.com.mymart3.mymartandroid.webapis.AuthenticateAPI;
import au.com.mymart3.mymartandroid.webapis.BaseAPI;
import au.com.mymart3.mymartandroid.webapis.IAuthenticateAPI;

// TODO: Auto-generated Javadoc
/**
 * The Class Authenticate.
 */
public class AuthenticateModel extends BaseModel{
	
	
	/** The m username. */
	private String mUsername;
	
	/** The m password. */
	private String mPassword;
	
	// Result
	/** The Authenticated. */
	public Boolean Authenticated = false;
	
	/** The User id. */
	public String userID = "";
	
	/** The _api. */
	private IAuthenticateAPI _api = null;
	
	/**
	 * Instantiates a new authenticate.
	 */
	public AuthenticateModel() {
		_api = new AuthenticateAPI();
	}
	
	/**
	 * Instantiates a new authenticate model.
	 *
	 * @param api the api
	 */
	public AuthenticateModel(IAuthenticateAPI api) {
		_api = api;
	}


	
	
	/**
	 * Gets the authenticate task.
	 *
	 * @param userName the user name
	 * @param password the password
	 * @return the async task
	 */
	public AsyncTask authenticate(String userName, String password){
		
		mUsername = userName;
		mPassword = password;
		
		// Call async task to do job
		AuthenticateTask authenticateTask = new AuthenticateTask();
		authenticateTask.execute();
		
//		log.debug("##########################");
//		log.debug(Authenticated.toString());
//		log.debug(mUsername.toString());
//		log.debug(mPassword.toString());
//		log.debug(ExceptionMessage.toString());
//		log.debug(UserID.toString());
//		log.debug("##########################");
		
		return authenticateTask;
	}

	

	/**
	 * The Class AuthenticateTask.
	 */
	public class AuthenticateTask extends AsyncTask<Object, Void, Void> {
		
		
		/* (non-Javadoc)
		 * @see android.os.AsyncTask#doInBackground(Params[])
		 */
		@Override
		public Void doInBackground(Object... params) {
			
			try {
				log.debug(_api.toString());
				// Call web service
				errorMessage = _api.execute(mUsername, mPassword);
				response = _api.getResponse();
				
				// Check connection result
				if(!errorMessage.equalsIgnoreCase("success")) return null;
				
				// Parse result
				JSONObject jsonResult = new JSONObject(response);
				JSONObject AuthenticateJsonResultObj = jsonResult.getJSONObject("AuthenticateJsonResult");
				Authenticated = AuthenticateJsonResultObj.getBoolean("Authenticated");
				exceptionMessage = AuthenticateJsonResultObj.getString("ExceptionMessage");
				userID = AuthenticateJsonResultObj.getString("UserID");
				
				Log.v("## 1 ######",response);
				
				Log.v("0",userID);
				
			} catch (Exception e) {
				log.debug(e.toString());
				errorMessage = e.toString();
				
				Log.v("555555######dddd#####",errorMessage);
			}			
			return null;
		}

		/* (non-Javadoc)
		 * Run After Execute AuthenticateTask
		 */
		@Override
		protected void onPostExecute(Void result)
        {
			
//			log.debug("##########################");
//			log.debug(Authenticated.toString());
//			log.debug(mUsername.toString());
//			log.debug(mPassword.toString());
//			log.debug(ExceptionMessage.toString());
//			log.debug(UserID.toString());
//			log.debug("##########################");
			
			
			super.onPostExecute(result);
			
        	
        	// Call on complete function
        	if(null != onCompleteCallback) onCompleteCallback.run();
        }
	}
}