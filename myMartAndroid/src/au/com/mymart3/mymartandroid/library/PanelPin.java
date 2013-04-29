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
	
	/** The Constant log. */
	private static final LogManager log = LogFactory.getLog(PanelPin.class);
	
	/** The m context. */
	Context mContext;
	
	/** The m view. */
	View mView;
	
	/** The m on pin complete callback. */
	Runnable mOnPinCompleteCallback = null;
	
	/** The m text digit4. */
	TextView mTextDigit1,mTextDigit2,mTextDigit3,mTextDigit4;
	
	/** The m str password. */
	public String mStrPassword = "";
	
	/**
	 * Instantiates a new panel pin.
	 *
	 * @param context
	 * @param view 
	 * @param onPinComplete
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
	 * Clear pin.
	 */
	public void clearPin() {
		mStrPassword = "";
		
		// Hide X text
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
			if(mStrPassword.length() >=2)mTextDigit2.setVisibility(View.VISIBLE);
			if(mStrPassword.length() >=3)mTextDigit3.setVisibility(View.VISIBLE);
			if(mStrPassword.length() >=4)mTextDigit4.setVisibility(View.VISIBLE);
		}
		
		// Call back when get all digit
		if(mStrPassword.length() >= 4){
			if(null != mOnPinCompleteCallback) mOnPinCompleteCallback.run();
		}
	}

}
