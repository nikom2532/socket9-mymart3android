/*
 * 
 */
package au.com.mymart3.mymartandroid.models;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

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
import au.com.mymart3.mymartandroid.webapis.GetUnitListAPI;
import au.com.mymart3.mymartandroid.webapis.IGetUnitListAPI;

// TODO: Auto-generated Javadoc
/**
 * The Class GetUnitList.
 */
public class GetUnitListModel extends BaseModel {
	
	/** The m user id. */
	String mUserID = "";
	
	/** The m class id. */
	String mClassID = "";
	
	// Result
	/** The Unit list success. */
	public Boolean UnitListSuccess = false;
	
	public IGetUnitListAPI _api = null;
	
	/**
	 * The Class UnitListDetailResult.
	 */
	public class UnitListDetailResult
	{
		/** The Unit id. */
		public String UnitID = "";
		
		/** The Unit title. */
		public String UnitTitle = "";
	}
	
	/** The Units. */
	public ArrayList<UnitListDetailResult> Units = null;
	
	/**
	 * Instantiates a new gets the unit list.
	 */
	public GetUnitListModel() {
		_api = new GetUnitListAPI();
	}
	
	public GetUnitListModel(IGetUnitListAPI api) {
		_api = api;
	}
	
	/**
	 * Do get unit list.
	 *
	 * @param UserID the user id
	 * @param classID the class id
	 */
	public AsyncTask execute(String UserID,String classID) {
		// Save required param
		mUserID = UserID;
		mClassID = classID;
		
		// Call async task to do job
		GetUnitListTask getUnitListTask = new GetUnitListTask();
		getUnitListTask.execute();
		return getUnitListTask;
	}
	
	/**
	 * The Class GetUnitListTask.
	 */
	private class GetUnitListTask extends AsyncTask<Object, Void, Void> {

    	/* (non-Javadoc)
	     * @see android.os.AsyncTask#onPreExecute()
	     */
	    @Override
    	protected void onPreExecute() {
    		// Display wait dialog
    		Handler handler = new Handler();
    		handler.post(new Runnable() {
				public void run() { 
					//AlertManager.DisplayLoadingMessage(context, "GetUnitList...", null); 
					} 
			});
    	} 
    	
		/* (non-Javadoc)
		 * @see android.os.AsyncTask#doInBackground(Params[])
		 */
		@Override
		protected Void doInBackground(Object... params) {
			
			try {
				// Call web service
				errorMessage = _api.execute(mUserID, mClassID);
				response = _api.getResponse();
				
				// Check connection result
				if(!errorMessage.equalsIgnoreCase("success")) return null;
				
				// Parse result
				JSONObject jsonResult = new JSONObject(response);
				JSONObject jsonGetUnitListJsonResult = jsonResult.getJSONObject("GetUnitListJsonResult");
				JSONArray jsonUnits = jsonGetUnitListJsonResult.getJSONArray("Units");
				
				UnitListSuccess = jsonGetUnitListJsonResult.getBoolean("UnitListSuccess"); 
				exceptionMessage = jsonGetUnitListJsonResult.getString("ExceptionMessage");
				Units = new ArrayList<UnitListDetailResult>();
				if(null != jsonUnits) {
					for(int i=0;i<jsonUnits.length();i++) {
						JSONObject jsonUnitListDetailResult = jsonUnits.getJSONObject(i);
						UnitListDetailResult unitListDetailResult = new UnitListDetailResult();
						unitListDetailResult.UnitID = jsonUnitListDetailResult.getString("UnitID");
						unitListDetailResult.UnitTitle = jsonUnitListDetailResult.getString("UnitTitle");
						Units.add(unitListDetailResult);
					}
				}

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
