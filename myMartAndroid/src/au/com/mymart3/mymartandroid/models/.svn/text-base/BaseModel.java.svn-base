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
public class BaseModel {
	
	/** The Constant log. */
	protected static final LogManager log = LogFactory.getLog(BaseModel.class);
	
	/** The m on complete callback. */
	public Runnable onCompleteCallback = null;
	
	public String response = "";	
	public String errorMessage = "";
	
	/** The Exception message. */
	public String exceptionMessage="";
}