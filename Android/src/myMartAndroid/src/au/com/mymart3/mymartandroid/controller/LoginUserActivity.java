/*
 * 
 */
package au.com.mymart3.mymartandroid.controller;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.AlertDialog.Builder;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.os.Bundle;
import android.os.Handler;
import android.text.InputType;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnKeyListener;
import android.widget.Button;
import android.widget.EditText;
import au.com.mymart3.mymartandroid.R;
import au.com.mymart3.mymartandroid.config.ActivitySelector;
import au.com.mymart3.mymartandroid.config.ConfigManager;
import au.com.mymart3.mymartandroid.config.Constants;
import au.com.mymart3.mymartandroid.library.AlertManager;
import au.com.mymart3.mymartandroid.library.LogManager;
import au.com.mymart3.mymartandroid.library.LogFactory;
import au.com.mymart3.mymartandroid.library.PanelPin;
import au.com.mymart3.mymartandroid.models.AuthenticateModel;
import au.com.mymart3.mymartandroid.models.RegisterDeviceQuickPinModel;
import au.com.mymart3.mymartandroid.webapis.AuthenticateAPI;
import au.com.mymart3.mymartandroid.webapis.AuthenticateDeviceQuickPinAPI;

/**
 * The Class LoginUserActivity: LoginUserActivity Controller.
 */
public class LoginUserActivity extends Activity {
	
	/** The log object to write log to the file  */
	private static final LogManager log = LogFactory.getLog(LoginUserActivity.class);
	/** The m context. */
	public Activity mContext = this;
	
	/** The edit text object for the username. */
	public EditText mEditTextUsername;
	
	/** The edit text for the password. */
	public EditText mEditTextPassword;
	
	/** The button for user login. */
	public Button mButtonUserLogin; 
	

	/** The authentication model */
	private AuthenticateModel mAuthenticate = new AuthenticateModel();
	
	/** The device quick pin model */
	private RegisterDeviceQuickPinModel mRegisterDeviceQuickPin = new RegisterDeviceQuickPinModel();
	
	/** The pin panel */
	private PanelPin mPanelPin;
	
	/** The pin value */
	private String mPin="";
	
	/** The pin value for the second attempt. */
	private String mPinSecond="";
	
	/* (non-Javadoc)
	 * @see android.app.Activity#onCreate(android.os.Bundle)
	 */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.loginuser);
		mContext = this;
		
		// get the objects
		mEditTextUsername = (EditText)findViewById(R.id.EditTextUsername);
		mEditTextPassword = (EditText)findViewById(R.id.EditTextPassword);
		mButtonUserLogin = (Button)findViewById(R.id.buttonUserLogin);
		
//		for Test purpose, set the value
		mEditTextUsername.setText("stirling.admin");
		mEditTextPassword.setText("duck121");
		
		//PopupQuickPinDlg();
		
//		new AuthenticateModel().execute("stirling.admin","duck121");
//		new AuthenticateDeviceQuickPinAPI().execute("", ConfigManager.getDeviceID );
		// For testing web service
		//new AuthenticateAPI().Authenticate(this, "stirling.admin","duck121", null);
		//new RegisterDeviceQuickPinAPI().RegisterDeviceQuickPin(this, "bc9ce5ff-1731-457f-bee3-336a99165c22", "1234", Configuration.gDeviceID, true, null);
		//new AuthenticateDeviceQuickPinAPI().doAuthenticateDeviceQuickPin(this, "1234", Configuration.gDeviceID, null);
		//new GetClassListAPI().GetClassList(this, "bc9ce5ff-1731-457f-bee3-336a99165c22", null);
		//new GetUnitListAPI().GetUnitList(this, "bc9ce5ff-1731-457f-bee3-336a99165c22","79795af1-ff89-47e9-905b-095d36bdeb94", null);
	}
	
	/**
	 * onStartClick
	 * Handles when the start is clicked
	 *
	 * @param v: the view
	 */
	public void onStartClick(View v) {
		onStartClickMethod();
	}
	
	/**
	 * On start click.
	 *
	 */
	public void onStartClickMethod() {		
		// Display wait dialog
		AlertManager.displayLoadingMessage(mContext, "Authenticating...", null); 
		
		mAuthenticate.onCompleteCallback = onAuthenticateComplete;
		mAuthenticate.authenticate(mEditTextUsername.getText().toString(),mEditTextPassword.getText().toString());
	}	
	
	/** The on authenticate complete. */
	public Runnable onAuthenticateComplete = new Runnable() {
		@Override
		public void run() {
			// Hide loading message
			AlertManager.hideWaitDlg();

			// Check result and display error popup
			if(!mAuthenticate.errorMessage.equalsIgnoreCase("success"))
			{
				AlertManager.displayMessage(mContext, mAuthenticate.errorMessage,"Authentication Fail");
			}
			else if(null != mAuthenticate.exceptionMessage && mAuthenticate.exceptionMessage.length() > 0 && !mAuthenticate.exceptionMessage.equalsIgnoreCase("null") )
			{
				AlertManager.displayMessage(mContext, mAuthenticate.exceptionMessage,"Authentication Fail");
			}

			// If Authenticated
			if(mAuthenticate.Authenticated)
			{
				// Display result
				//helper.Popup(mContext, mAuthenticate.UserID,"Authentication Result");
				
				// Save UserID for use later
				ConfigManager.gUserID = mAuthenticate.userID;
				
				// Ask to enter pin if not enter before
				String hasQuickPin = ConfigManager.getPrivateString("hasQuickPin");
				if(null == hasQuickPin || !hasQuickPin.equalsIgnoreCase("true")) {
					
			    	try {
				        AlertDialog.Builder dialog = new AlertDialog.Builder(mContext);
				        dialog.setTitle("Reister Device ?");
				        dialog.setMessage("Enter quick pin ?");
				        dialog.setPositiveButton("Yes", new OnClickListener() {
							public void onClick(DialogInterface dialog, int which) {
								dialog.dismiss();
								mPin="";
								mPinSecond="";
								PopupQuickPinDlg();
							}
						});
				        dialog.setNegativeButton("No", new OnClickListener() {
							public void onClick(DialogInterface dialog, int which) {
								dialog.dismiss();

								// Show class list
								ActivitySelector.startactivitybyID(Constants.ACTIVITY_MAIN_VIEW);
							}
						});
				        dialog.show();
			    	} 
				    catch (Exception e) {}	 					
					
				}
				else {
					// Show class list
					ActivitySelector.startactivitybyID(Constants.ACTIVITY_MAIN_VIEW);	
				}				
			}
			else
			{
			}
		}
	};
	
	/** The on register device quick pin complete. */
	public Runnable onRegisterDeviceQuickPinComplete = new Runnable() {
		@Override
		public void run() {
			// Close wait dialog
        	AlertManager.hideWaitDlg();
			
			// Check result and display error popup
			if(!mRegisterDeviceQuickPin.errorMessage.equalsIgnoreCase("success"))
			{
				AlertManager.displayMessage(mContext, mRegisterDeviceQuickPin.errorMessage,"RegisterDeviceQuickPin Fail");
			}
			else if(null != mRegisterDeviceQuickPin.exceptionMessage && mRegisterDeviceQuickPin.exceptionMessage.length() > 0 && !mRegisterDeviceQuickPin.exceptionMessage.equalsIgnoreCase("null") )
			{
				AlertManager.displayMessage(mContext, mRegisterDeviceQuickPin.exceptionMessage,"RegisterDeviceQuickPin Fail");
			}			
			
			if(mRegisterDeviceQuickPin.registerSuccess)
			{
				// Save to private string
				ConfigManager.setPrivateString("hasQuickPin","true");
				
				// Show class list
				ActivitySelector.startactivitybyID(Constants.ACTIVITY_CLASS_LIST);					
			}
			else
			{
			}
		}
	};
	
	/**
	 * Popup quick pin dlg.
	 */
	private void PopupQuickPinDlg() {
		LayoutInflater factory = LayoutInflater.from(mContext);
		View logonView = factory.inflate(R.layout.loginquickpin,  (ViewGroup) findViewById(R.id.root));
    	AlertDialog.Builder dialogBuilder = new AlertDialog.Builder(mContext);
    	final Dialog dialog = dialogBuilder.setView(logonView).create();

    	// Set pin view and complete call back
		mPanelPin = new PanelPin(mContext,logonView,new Runnable() {
			@Override
			public void run() {
				dialog.dismiss();
				
				// If enter pin for the first time
				if(mPin.length()==0)
				{
					mPin = mPanelPin.mStrPassword;
					
					// Ask pin for second time
					PopupQuickPinDlg();
				}
				else
				{
					// Check pin matching
					mPinSecond = mPanelPin.mStrPassword;
					
					if(!mPin.equals(mPinSecond)) {
						AlertManager.displayMessage(mContext, "Pin does not match","RegisterDeviceQuickPin Fail");
					}
					else {
						// Display wait dialog
						AlertManager.displayLoadingMessage(mContext, "Registering...", null); 
	
						// Call webservice to set pin 
						mRegisterDeviceQuickPin.onCompleteCallback = onRegisterDeviceQuickPinComplete;
						mRegisterDeviceQuickPin.registerDeviceQuickPin(ConfigManager.gUserID, mPin, ConfigManager.getDeviceID, true);
					}
				}
			}
		});
		
		// Show pin dialog
    	dialog.show();
	}
	
}
