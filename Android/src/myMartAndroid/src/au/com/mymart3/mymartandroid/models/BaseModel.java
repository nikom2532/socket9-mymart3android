/*
 * 
 */
package au.com.mymart3.mymartandroid.models;


import au.com.mymart3.mymartandroid.library.LogManager;
import au.com.mymart3.mymartandroid.library.LogFactory;

/**
 * The Class Authenticate.
 */
public class BaseModel {
	
	/** The Constant log to write log to the file */
	protected static final LogManager log = LogFactory.getLog(BaseModel.class);
	
	/** The m on complete callback. */
	public Runnable onCompleteCallback = null;
	
	/** The response. */
	public String response = "";	
	
	/** The error message. */
	public String errorMessage = "";
	
	/** The Exception message. */
	public String exceptionMessage="";
}