package au.com.mymart3.mymartandroid.webapis;

// TODO: Auto-generated Javadoc
/**
 * The Interface IGetUnitListAPI.
 */
public interface IGetUnitListAPI {
	
	/**
	 * Gets the unit list.
	 *
	 * @param UserID the user id
	 * @param classID the class id
	 */
	public String execute(String userID, String classID);
	public String getResponse();
}