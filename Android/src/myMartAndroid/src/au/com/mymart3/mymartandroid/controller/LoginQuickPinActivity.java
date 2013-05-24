/*
 * 
 */
package au.com.mymart3.mymartandroid.controller;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.widget.LinearLayout;
import au.com.mymart3.mymartandroid.R;
import au.com.mymart3.mymartandroid.config.ActivitySelector;
import au.com.mymart3.mymartandroid.config.ConfigManager;
import au.com.mymart3.mymartandroid.config.Constants;
import au.com.mymart3.mymartandroid.library.AlertManager;
import au.com.mymart3.mymartandroid.library.LogManager;
import au.com.mymart3.mymartandroid.library.LogFactory;
import au.com.mymart3.mymartandroid.library.PanelPin;
import au.com.mymart3.mymartandroid.models.AuthenticateDeviceQuickPinModel;

/**
 * The Class LoginQuickPinActivity: LoginQuickPinActivity Controller.
 */
public class LoginQuickPinActivity extends Activity {
	
	/** The log object to write the log message to file */
	private static final LogManager log = LogFactory.getLog(LoginQuickPinActivity.class);

	/** The context. */
	public Activity mContext;
	
    /** The on authenticate device quick pin complete. */
    public Runnable onAuthenticateDeviceQuickPinComplete = new Runnable() {		
		@Override
		public void run() {
			if(mAuthenticateDeviceQuickPin.authenticated)
			{
				// Show class list
				ActivitySelector.startactivitybyID(Constants.ACTIVITY_MAIN_VIEW);
			}
			else
			{
				
			}
		}
	};
	
	/** The m authenticate device quick pin. */
	AuthenticateDeviceQuickPinModel mAuthenticateDeviceQuickPin = new AuthenticateDeviceQuickPinModel(); 
	
	/** The m panel pin. */
	PanelPin mPanelPin;
	
    /* (non-Javadoc)
     * @see android.app.Activity#onCreate(android.os.Bundle)
     */
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.loginquickpin);
        
        // store the value
        mContext = this;
        
        // Load panel quick pin
        mPanelPin = new PanelPin(mContext, (LinearLayout)findViewById(R.id.root), onQuickPinComplete);
    }
    
    /** The on quick pin complete. */
    Runnable onQuickPinComplete = new Runnable() {		
		@Override
		public void run() {
			
			// Call web service (through the model object)			
			mAuthenticateDeviceQuickPin.onCompleteCallback = onAuthenticateDeviceQuickPinComplete;			
			mAuthenticateDeviceQuickPin.authenticateDeviceQuickPin(mPanelPin.mStrPassword, ConfigManager.getDeviceID);
			mPanelPin.clearPin();
		}
	};
	
	/**
	 * On pre execute.
	 */
	protected void onPreExecute() {
		// Display wait dialog
		Handler handler = new Handler();
		handler.post(new Runnable() {
			public void run() {
				AlertManager.displayLoadingMessage(mContext, "AuthenticateDeviceQuickPin...",
						null);
			}
		});
	}
}