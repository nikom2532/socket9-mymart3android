/*
 * 
 */
package au.com.mymart3.mymartandroid.config;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Handler;
import android.view.MenuItem;
import au.com.mymart3.mymartandroid.controller.ClassListActivity;
import au.com.mymart3.mymartandroid.controller.LoginBothActivity;
import au.com.mymart3.mymartandroid.controller.LoginQuickPinActivity;
import au.com.mymart3.mymartandroid.controller.LoginUserActivity;

// TODO: Auto-generated Javadoc
/**
 *  Class ActivitySelector.
 */
public class ActivitySelector {
	
	/**  root activity. */
	static public Activity mRootActivity;
	
	/**  menu caller activity. */
	static public Activity mMenuCallerActivity;
	
	/**  current menu id. */
	static public int mCurrentMenuID = -1;
	
	/**  handler. */
	static public Handler mHandler;
	
	/**  sub activity list. */
	static public ArrayList<Activity> mSubActivityList = new ArrayList<Activity>();

	/**
	 * Inits .
	 *
	 * @param rootActivity
	 */
	static public void Init(Activity rootActivity) {
		mCurrentMenuID = -1;
		mRootActivity = rootActivity;
		mHandler = new Handler();
		
		String hasQuickPin = ConfigManager.getPrivateString("hasQuickPin");
		if(null == hasQuickPin || !hasQuickPin.equalsIgnoreCase("true")) {
			startactivitybyID(Constants.ACTIVITY_LOGIN_USER);
		}
		else {
			startactivitybyID(Constants.ACTIVITY_LOGIN_BOTH);
		}
		//startactivitybyID(Constants.ACTIVITY_CLASS_LIST);
	}	
	
	/**
	 * Clean.
	 */
	static public void Clean()
	{
		mCurrentMenuID = -1;
	}

	/**
	 * Startactivityby id.
	 *
	 * @param ID
	 * @return true, if successful
	 */
	static public boolean startactivitybyID(int ID)
	{
    	switch (ID) {
	    	case Constants.ACTIVITY_LOGIN_USER:
	    		mRootActivity.startActivityForResult(new Intent(mRootActivity,LoginUserActivity.class),Constants.ACTIVITY_LOGIN_USER);
	    		break;
	    	case Constants.ACTIVITY_LOGIN_QUICKPIN:
	    		mRootActivity.startActivityForResult(new Intent(mRootActivity,LoginQuickPinActivity.class),Constants.ACTIVITY_LOGIN_USER);
	    		break;
	    	case Constants.ACTIVITY_LOGIN_BOTH:
	    		mRootActivity.startActivityForResult(new Intent(mRootActivity,LoginBothActivity.class),Constants.ACTIVITY_LOGIN_USER);
	    		break;
	    	case Constants.ACTIVITY_CLASS_LIST:
	    		mRootActivity.startActivityForResult(new Intent(mRootActivity,ClassListActivity.class),Constants.ACTIVITY_CLASS_LIST);
	    		break;
	    	default:
	    		return false;
    	}
		return true;
	}
	
	/**
	 * Finish all activity.
	 */
	static public void finishAllActivity() {
		for(Activity activityItem : mSubActivityList) activityItem.finish();
		mSubActivityList.removeAll(mSubActivityList);		
	}
}
