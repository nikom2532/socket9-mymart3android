/*
 * 
 */
package au.com.mymart3.mymartandroid.library;

/**
 * A factory for creating Log objects: .
 */
public class LogFactory {
	
	/**
	 * getLog
	 * Gets the log.
	 *
	 * @param clazz: the class
	 * @return log object
	 */
	public static LogManager getLog(Class clazz)
	{
		LogManager log = new LogManager();
		log.setClassName(clazz.getName());
		return log;
	}

	/**
	 * getLog with defined name
	 * Gets the log.
	 *
	 * @param name the name
	 * @return log
	 */
	public static LogManager getLog(java.lang.String name)
	{
		LogManager log = new LogManager();
		log.setClassName(name);
		return log;
	}
}
