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

// TODO: Auto-generated Javadoc
/**
 * The Class LoginUserActivity.
 */
public class LoginUserActivity extends Activity {
	
	/** The Constant log. */
	private static final LogManager log = LogFactory.getLog(LoginUserActivity.class);
	/** The m context. */
	public Activity mContext = this;
	
	/** The m edit text username. */
	public EditText mEditTextUsername;
	
	/** The m edit text password. */
	public EditText mEditTextPassword;
	
	/** The m button user login. */
	public Button mButtonUserLogin; 
	
	
	/** The on authenticate complete. */
	public Runnable onAuthenticateComplete = new Runnable() {
		@Override
		public void run() {
			
			// If Authenticated
			if(mAuthenticate.Authenticated)
			{
				// Display result
				//helper.Popup(mContext, mAuthenticate.UserID,"Authentication Result");
				
				// Save UserID for use later
				ConfigManager.gUserID = mAuthenticate.UserID;
				
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
								PopupQuickPinDlg();
							}
						});
				        dialog.setNegativeButton("No", new OnClickListener() {
							public void onClick(DialogInterface dialog, int which) {
								dialog.dismiss();

								// Show class list
								ActivitySelector.startactivitybyID(Constants.ACTIVITY_CLASS_LIST);
							}
						});
				        dialog.show();
			    	} 
				    catch (Exception e) {}	 					
					
				}
				else {
					// Show class list
					ActivitySelector.startactivitybyID(Constants.ACTIVITY_CLASS_LIST);	
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
						
			// Check result and display error popup
			if(!mAuthenticate.errorMessage.equalsIgnoreCase("success"))
			{
				AlertManager.DisplayMessage(mContext, mAuthenticate.errorMessage,"Authentication Fail");
			}
			else if(null != mAuthenticate.exceptionMessage && mAuthenticate.exceptionMessage.length() > 0 && !mAuthenticate.exceptionMessage.equalsIgnoreCase("null") )
			{
				AlertManager.DisplayMessage(mContext, mAuthenticate.exceptionMessage,"Authentication Fail");
			}

			/*/
			// Check result and display error popup
			if(!mAuthenticate.errorMessage.equalsIgnoreCase("success"))
			{
				AlertManager.DisplayMessage(mContext, mRegisterDeviceQuickPin.errorMessage,"AuthenticateDeviceQuickPin Success");
			}
			else if(null != mRegisterDeviceQuickPin.exceptionMessage && mRegisterDeviceQuickPin.exceptionMessage.length() > 0 && !mAuthenticate.exceptionMessage.equalsIgnoreCase("null") )
			{
				AlertManager.DisplayMessage(mContext, mRegisterDeviceQuickPin.exceptionMessage,"AuthenticateDeviceQuickPin Fail");
			}
			/*/
			
			// Check result and display error popup
			if(!mRegisterDeviceQuickPin.errorMessage.equalsIgnoreCase("success"))
			{
				AlertManager.DisplayMessage(mContext, mRegisterDeviceQuickPin.errorMessage,"RegisterDeviceQuickPin Fail");
			}
			else if(null != mRegisterDeviceQuickPin.exceptionMessage && mRegisterDeviceQuickPin.exceptionMessage.length() > 0 && !mRegisterDeviceQuickPin.exceptionMessage.equalsIgnoreCase("null") )
			{
				AlertManager.DisplayMessage(mContext, mRegisterDeviceQuickPin.exceptionMessage,"RegisterDeviceQuickPin Fail");
			}


			// Close wait dialog
        	AlertManager.hideWaitDlg();
			
			// Close wait dialog
        	AlertManager.hideWaitDlg();
			
			
			if(mRegisterDeviceQuickPin.RegisterSuccess)
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
	
	/** The m authenticate. */
	AuthenticateModel mAuthenticate = new AuthenticateModel();
	
	/** The m register device quick pin. */
	RegisterDeviceQuickPinModel mRegisterDeviceQuickPin = new RegisterDeviceQuickPinModel();
	
	/** The m panel pin. */
	PanelPin mPanelPin;
	
	/** The m pin. */
	String mPin="";
	
	/* (non-Javadoc)
	 * @see android.app.Activity#onCreate(android.os.Bundle)
	 */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.loginuser);
		mContext = this;
		
		mEditTextUsername = (EditText)findViewById(R.id.EditTextUsername);
		mEditTextPassword = (EditText)findViewById(R.id.EditTextPassword);
		mButtonUserLogin = (Button)findViewById(R.id.buttonUserLogin);
		
//		Test
		mEditTextUsername.setText("stirling.admin");
		mEditTextPassword.setText("duck121");
		
		// ####### make search keyboard
		mEditTextUsername.setInputType(InputType.TYPE_CLASS_TEXT);

		// ####### make enter key when search
//		mEditTextUsername.setOnKeyListener(new OnKeyListener() {
//			@Override
//			public boolean onKey(View v, int keyCode, KeyEvent event) {
//				if ((keyCode == KeyEvent.KEYCODE_ENTER)) {
//			    	return false;
//				} else
//					return true;
//			}
//		});
//		
//		mEditTextPassword.setOnKeyListener(new OnKeyListener() {
//			@Override
//			public boolean onKey(View v, int keyCode, KeyEvent event) {
//				if ((keyCode == KeyEvent.ACTION_DOWN)) {
//					onStartClickMethod();
//			    	return true;
//				} else
//					return false;
//			}
//			
//		 
//		});
		
		
		
		//PopupQuickPinDlg();
		
//		new AuthenticateModel().Authenticate("stirling.admin","duck121");
		// For testing web service
		//new AuthenticateAPI().Authenticate(this, "stirling.admin","duck121", null);
		//new RegisterDeviceQuickPinAPI().RegisterDeviceQuickPin(this, "bc9ce5ff-1731-457f-bee3-336a99165c22", "1234", Configuration.gDeviceID, true, null);
		//new AuthenticateDeviceQuickPinAPI().doAuthenticateDeviceQuickPin(this, "1234", Configuration.gDeviceID, null);
		//new GetClassListAPI().GetClassList(this, "bc9ce5ff-1731-457f-bee3-336a99165c22", null);
		//new GetUnitListAPI().GetUnitList(this, "bc9ce5ff-1731-457f-bee3-336a99165c22","79795af1-ff89-47e9-905b-095d36bdeb94", null);
	}
	
	/**
	 * On start click.
	 *
	 * @param v
	 */
	public void onStartClick(View v) {
		onStartClickMethod();
	}
	
	/**
	 * On start click.
	 *
	 */
	public void onStartClickMethod() {
		mAuthenticate.onCompleteCallback = onAuthenticateComplete;
		mAuthenticate.authenticate(mEditTextUsername.getText().toString(),mEditTextPassword.getText().toString());
	}
	
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
				mPin = mPanelPin.mStrPassword;
				
				// Call webservice to set pin 
				mRegisterDeviceQuickPin.onCompleteCallback = onRegisterDeviceQuickPinComplete;
				mRegisterDeviceQuickPin.RegisterDeviceQuickPin(ConfigManager.gUserID, mPin, ConfigManager.getDeviceID, true);
			}
		});
		
		// Show pin dialog
    	dialog.show();
	}
	
	/**
	 * On pre execute.
	 */
	protected void onPreExecute() {
		// Display wait dialog
		Handler handler = new Handler();
		handler.post(new Runnable() {
			public void run() { AlertManager.DisplayLoadingMessage(mContext, "Authenticating...", null); } 
		});
	} 
}
