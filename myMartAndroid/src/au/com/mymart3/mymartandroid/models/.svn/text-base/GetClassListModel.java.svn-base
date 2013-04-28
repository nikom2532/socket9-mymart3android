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
import au.com.mymart3.mymartandroid.webapis.GetClassListAPI;
import au.com.mymart3.mymartandroid.webapis.GetUnitListAPI;
import au.com.mymart3.mymartandroid.webapis.IGetClassListAPI;

// TODO: Auto-generated Javadoc
/**
 * The Class GetClassList.
 */
public class GetClassListModel extends BaseModel {
	
	/** The m user id. */
	String mUserID = "";
	
	// Result
	/** The Class list success. */
	public Boolean ClassListSuccess = false;
	
	/** The Reporting period. */
	public String ReportingPeriod = "";
	
	/**
	 * The Class ClassListDetailResult.
	 */
	public class ClassListDetailResult
	{
		
		/** The Class id. */
		public String ClassID = "";
		
		/** The Class title. */
		public String ClassTitle = "";
	}
	
	/** The Classes. */
	public ArrayList<ClassListDetailResult> Classes = null;
	
	public IGetClassListAPI _api = null;
	
	/**
	 * Instantiates a new gets the class list.
	 */
	//Constructor
	public GetClassListModel() {
		_api = new GetClassListAPI();
	}
	
	//Constructor
	/**
	 * Instantiates a new gets the class list api.
	 *
	 * @param context the context
	 * @param onCompleteCallback the on complete callback
	 */
	public GetClassListModel(IGetClassListAPI api){
		_api = api;
	}
	
	/**
	 * Do get class list.
	 *
	 * @param UserID the user id
	 */
	public AsyncTask GetClassList(String UserID) {
		// Save required param
		mUserID = UserID;
		
		// Call async task to do job
		GetClassListTask getClassListTask = new GetClassListTask();
		getClassListTask.execute();
		return getClassListTask;
	}
	
	/**
	 * The Class GetClassListTask.
	 */
	private class GetClassListTask extends AsyncTask<Object, Void, Void> {

    	/* (non-Javadoc)
	     * @see android.os.AsyncTask#onPreExecute()
	     */
	    @Override
    	protected void onPreExecute() {
    		// Display wait dialog
    		Handler handler = new Handler();
    		handler.post(new Runnable() {
				public void run() { 
					// AlertManager.DisplayLoadingMessage(context, "GetClassList...", null); 
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
				errorMessage = _api.execute(mUserID);
				response = _api.getResponse();
				
				// Check connection result
				if(!errorMessage.equalsIgnoreCase("success")) return null;
				
				// Parse result
				JSONObject jsonResult = new JSONObject(response);
				JSONObject jsonGetClassListJsonResult = jsonResult.getJSONObject("GetClassListJsonResult");
				JSONArray jsonClasses = jsonGetClassListJsonResult.getJSONArray("Classes");
				
				ClassListSuccess = jsonGetClassListJsonResult.getBoolean("ClassListSuccess");
				ReportingPeriod = jsonGetClassListJsonResult.getString("ReportingPeriod");
				exceptionMessage = jsonGetClassListJsonResult.getString("ExceptionMessage");
				Classes = new ArrayList<ClassListDetailResult>();
				if(null != jsonClasses) {
					for(int i=0;i<jsonClasses.length();i++) {
						JSONObject jsonClassListDetailResult = jsonClasses.getJSONObject(i);
						ClassListDetailResult classListDetailResult = new ClassListDetailResult();
						classListDetailResult.ClassID =jsonClassListDetailResult.getString("ClassID");
						classListDetailResult.ClassTitle =jsonClassListDetailResult.getString("ClassTitle");
						Classes.add(classListDetailResult);
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
			
        	// Call on complete function
        	if(null != onCompleteCallback) onCompleteCallback.run();
        }		
	}
}
