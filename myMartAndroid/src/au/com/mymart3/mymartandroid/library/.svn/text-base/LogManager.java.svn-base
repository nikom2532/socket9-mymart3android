/*
 * 
 */
package au.com.mymart3.mymartandroid.library;

import java.net.SocketException;

import javax.xml.parsers.ParserConfigurationException;

import android.widget.TextView;

// TODO: Auto-generated Javadoc
/**
 * The Class Log.
 */
public class LogManager {
	
	/** The m_tv. */
	private static TextView m_tv = null;
	
	/** The m_log. */
	private static String m_log;
	
	/** The m_classname. */
	private String m_classname = "";
	

	/**
	 * Inits the.
	 *
	 * @param tv
	 */
	public void Init(TextView tv)
	{
		m_tv = tv;
		m_log= "";
	}
	
	/**
	 * Sets the class name.
	 *
	 * @param className 
	 */
	public void setClassName(String className){
		m_classname = className + " : ";
	}
	
	/**
	 * Log.
	 *
	 * @param strLog 
	 */
	public void log(String strLog)
	{
		android.util.Log.i(au.com.mymart3.mymartandroid.config.Constants.TAGWDBG,m_classname +strLog+"\r\n");
		//m_log += strLog+"\r\n";
		//m_tv.setText(m_log);
	}
	
	/**
	 * Logcat.
	 *
	 * @param strLog the str log
	 */
	public void logcat(String strLog)
	{
		log(strLog);		
	}
	
	/**
	 * Error.
	 *
	 * @param strLog the str log
	 * @param throwable the throwable
	 */
	public void error(String strLog,Throwable throwable )
	{
		log(strLog);
	}
	
	/**
	 * Trace.
	 *
	 * @param strLog the str log
	 */
	public void trace(String strLog) 
	{
		log(strLog);
	}

	/**
	 * Fatal.
	 *
	 * @param strLog the str log
	 * @param ex the ex
	 */
	public void fatal(String strLog, ParserConfigurationException ex) 
	{
		log(strLog);
	}

	/**
	 * Error.
	 *
	 * @param strLog the str log
	 */
	public void error(String strLog) {
		log(strLog);
	} 
	
	/**
	 * Info.
	 *
	 * @param strLog the str log
	 * @param throwable the throwable
	 */
	public void info(String strLog,Throwable throwable )
	{
		log(strLog);
	}
	
	/**
	 * Info.
	 *
	 * @param strLog the str log
	 */
	public void info(String strLog) 
	{
		log(strLog);
	}

	/**
	 * Debug.
	 *
	 * @param strLog the str log
	 */
	public void debug(String strLog) {
		log(strLog);
	}

	/**
	 * Debug.
	 *
	 * @param strLog the str log
	 * @param ex the ex
	 */
	public void debug(String strLog, SocketException ex) {
		log(strLog);
	}

	/**
	 * Warn.
	 *
	 * @param strLog the str log
	 */
	public void warn(String strLog) {
		log(strLog);		
	}

	/**
	 * Debug.
	 *
	 * @param strLog the str log
	 * @param ex the ex
	 */
	public void debug(String strLog, InterruptedException ex) {
		log(strLog);
	}

	/**
	 * Warn.
	 *
	 * @param strLog the str log
	 * @param ex the ex
	 */
	public void warn(String strLog, Exception ex) {
		log(strLog);
	}


}
