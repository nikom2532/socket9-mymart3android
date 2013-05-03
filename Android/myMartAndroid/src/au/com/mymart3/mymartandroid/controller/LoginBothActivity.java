/*
 * 
 */
package au.com.mymart3.mymartandroid.controller;

import au.com.mymart3.mymartandroid.controller.LoginQuickPinActivity;
import au.com.mymart3.mymartandroid.controller.LoginUserActivity;

import android.app.TabActivity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TabHost;
import android.widget.TabHost.TabSpec;
import au.com.mymart3.mymartandroid.R;

// TODO: Auto-generated Javadoc
/**
 * The Class LoginBothActivity: LoginBothActivity Controller.
 */
public class LoginBothActivity extends TabActivity {
	
	/* (non-Javadoc)
	 * @see android.app.ActivityGroup#onCreate(android.os.Bundle)
	 */
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_main);
        setContentView(R.layout.main);
//        setContentView(R.layout.login_both2);
        
        //#######
        
        TabHost tabHost = getTabHost();
        
        // the first Account
        TabSpec userlogin = tabHost.newTabSpec("UserLogin");
        // setting Title and Icon for the Tab
//        userlogin.setIndicator("UserLogin", getResources().getDrawable(R.drawable.menu_account));
        userlogin.setIndicator("User Login");
        Intent accountIntent = new Intent(this, LoginUserActivity.class);
        userlogin.setContent(accountIntent);
        
        // Tab for Slide
        TabSpec quickpin = tabHost.newTabSpec("QuickPin");
//        quickpin.setIndicator("QuickPin", getResources().getDrawable(R.drawable.menu_slideshow));
        quickpin.setIndicator("QuickPin Login");
        Intent slideIntent = new Intent(this, LoginQuickPinActivity.class);
        quickpin.setContent(slideIntent);
        
        // Adding all Tab to TabHost
        
        tabHost.addTab(userlogin); 
        tabHost.addTab(quickpin); 
        
        //#######
    }
}