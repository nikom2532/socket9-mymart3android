/*
 * 
 */
package au.com.mymart3.mymartandroid.library;

import android.content.Context;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import au.com.mymart3.mymartandroid.R;

// TODO: Auto-generated Javadoc
/**
 * The Class PanelPin.
 */
public class PanelPin implements View.OnClickListener {
	
	/** The Constant log oobject to write log to the file */
	private static final LogManager log = LogFactory.getLog(PanelPin.class);
	
	/** The context. */
	Context mContext;
	
	/** The view. */
	View mView;
	
	/** The pin complete callback. */
	Runnable mOnPinCompleteCallback = null;
	
	/** The textview for each digit */
	TextView mTextDigit1,mTextDigit2,mTextDigit3,mTextDigit4;
	
	/** The password. */
	public String mStrPassword = "";
	
	/**
	 * Instantiates a new panel pin.
	 *
	 * @param context the context
	 * @param view the view
	 * @param onPinComplete the on pin complete
	 */
	public PanelPin(Context context,View view,Runnable onPinComplete)
	{
		mContext = context;
		mView = view;
		mOnPinCompleteCallback = onPinComplete;
		
		mTextDigit1 = (TextView)mView.findViewById(R.id.textView1);
		mTextDigit2 = (TextView)mView.findViewById(R.id.textView2);
		mTextDigit3 = (TextView)mView.findViewById(R.id.textView3);
		mTextDigit4 = (TextView)mView.findViewById(R.id.textView4);
		
		clearPin();
		
		// Event handler when button is pressed
		setButtonEventListener(R.id.idButtonDel);
        setButtonEventListener(R.id.idButton0);
        setButtonEventListener(R.id.idButton1);
        setButtonEventListener(R.id.idButton2);
        setButtonEventListener(R.id.idButton3);
        setButtonEventListener(R.id.idButton4);
        setButtonEventListener(R.id.idButton5);
        setButtonEventListener(R.id.idButton6);
        setButtonEventListener(R.id.idButton7);
        setButtonEventListener(R.id.idButton8);
        setButtonEventListener(R.id.idButton9);
	}
	
	/**
	 * setButtonEventListener
	 * Sets the button event listener.
	 *
	 * @param id the new button event listener
	 */
	private void setButtonEventListener(int id) {
		Button button; 
		button = (Button)mView.findViewById(id);
		if(null != button) {
			button.setOnClickListener(this);
		}
	}

	/**
	 * clearPin
	 * Clear pin.
	 */
	public void clearPin() {
		
		// clear text box
		mStrPassword = "";
		
		// Hide 'xxxx' text
		mTextDigit1.setVisibility(View.GONE);
		mTextDigit2.setVisibility(View.GONE);
		mTextDigit3.setVisibility(View.GONE);
		mTextDigit4.setVisibility(View.GONE);
	}
	
	/* (non-Javadoc)
	 * @see android.view.View.OnClickListener#onClick(android.view.View)
	 */
	public void onClick(View v) {
		Button button = (Button)v;
		switch (v.getId()) { 
			case R.id.idButtonDel:
				{
					if(mStrPassword.length() > 0) {
						// Remove right digit
						mStrPassword = mStrPassword.substring(0,mStrPassword.length()-1);
						
						// Adjust X display text
						mTextDigit1.setVisibility(View.GONE);
						mTextDigit2.setVisibility(View.GONE);
						mTextDigit3.setVisibility(View.GONE);
						mTextDigit4.setVisibility(View.GONE);

						if(mStrPassword.length() >=1) mTextDigit1.setVisibility(View.VISIBLE);
						if(mStrPassword.length() >=2)mTextDigit2.setVisibility(View.VISIBLE);
						if(mStrPassword.length() >=3)mTextDigit3.setVisibility(View.VISIBLE);
						if(mStrPassword.length() >=4)mTextDigit4.setVisibility(View.VISIBLE);
					}
				}
				return; 
		} 
		
		// Get pressed value and display X
		if(mStrPassword.length() < 4) {
			mStrPassword += button.getText();
			if(mStrPassword.length() >=1) mTextDigit1.setVisibility(View.VISIBLE);
			if(mStrPassword.length() >=2) mTextDigit2.setVisibility(View.VISIBLE);
			if(mStrPassword.length() >=3) mTextDigit3.setVisibility(View.VISIBLE);
			if(mStrPassword.length() >=4) mTextDigit4.setVisibility(View.VISIBLE);
		}
		
		// Call back when get all digit
		if(mStrPassword.length() >= 4){
			if(null != mOnPinCompleteCallback) mOnPinCompleteCallback.run();
		}
	}

}
