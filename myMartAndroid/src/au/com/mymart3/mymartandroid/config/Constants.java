/*
 * 
 */
package au.com.mymart3.mymartandroid.config;

// TODO: Auto-generated Javadoc
/**
 * The Interface Constants.
 */
public interface Constants {
	
	/** The Constant TAGWDBG. */
	public static final String TAGWDBG = "myMart_debug";
	
	/** The Constant PREFS_NAME. */
	public static final String PREFS_NAME = "myMartPrefsFile";

	/** The key aes. */
	public static String PrivateAESKey = "0DB03F0B8D734F339A22E1FCC31D85BC";
	
	/** The key hmac. */
	public static String PrivateHMACKey = "C48BC385-25F5-4CAD-BD2C-7EEA72546FF7";
	
	/** The Server url. */
	public static String APIServerURL = "http://mymart3demo.cloudapp.net/MobileService.svc/json/";
	
	/** The login_username. */
	public static String login_username = "username";
	
	/** The login_password. */
	public static String login_password = "password";
	
	/** The Constant login_response_jsonAuthenticated. */
	public static final String login_response_jsonAuthenticated = "jsonAuthenticated";
	
	/** The Constant login_response_jsonExceptionMessage. */
	public static final String login_response_jsonExceptionMessage = "jsonExceptionMessage";
	
	// Activity ID
	/** The Constant ACTIVITY_LOGIN_USER. */
	public static final int ACTIVITY_LOGIN_USER = 1;
	
	/** The Constant ACTIVITY_LOGIN_QUICKPIN. */
	public static final int ACTIVITY_LOGIN_QUICKPIN = 2;
	
	/** The Constant ACTIVITY_LOGIN_BOTH. */
	public static final int ACTIVITY_LOGIN_BOTH = 3;
	
	/** The Constant ACTIVITY_CLASS_LIST. */
	public static final int ACTIVITY_CLASS_LIST = 4;
}