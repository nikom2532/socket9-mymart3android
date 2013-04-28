/*
 * 
 */
package au.com.mymart3.mymartandroid.library;

import android.app.Activity;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import au.com.mymart3.mymartandroid.R;
import au.com.mymart3.mymartandroid.library.*;

// TODO: Auto-generated Javadoc
/**
 * The Class SwipeAnimationControl.
 */
public class SwipeAnimationControl extends Activity {
	/** Called when the activity is first created. */
	private LinearLayout MenuList, MenuComment;

	/** The btn toggle menu comment. */
	private Button btnToggleMenuList, btnToggleMenuComment;

	/** The screen width. */
	private int screenWidth;
	
	/** The is expanded. */
	private boolean isExpanded;

	/* (non-Javadoc)
	 * @see android.app.Activity#onCreate(android.os.Bundle)
	 */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.name_table);
		MenuList = (LinearLayout) findViewById(R.id.class_selection);
		MenuComment = (LinearLayout) findViewById(R.id.comment_view);

		btnToggleMenuList = (Button) findViewById(R.id.btnToggleMenuList);
		btnToggleMenuComment = (Button) findViewById(R.id.btnToggleMenuComment);

		DisplayMetrics metrics = new DisplayMetrics();
		getWindowManager().getDefaultDisplay().getMetrics(metrics);
		screenWidth = metrics.widthPixels;

		btnToggleMenuList.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				if (isExpanded) {
					isExpanded = false;
					MenuList.startAnimation(new CollapseAnimation(MenuList, 0,
							(int) (screenWidth * 0.7), 20));
					MenuComment.startAnimation(new CollapseAnimation(
							MenuComment, 0, (int) (screenWidth * 0.7), 20));
				} else {
					isExpanded = true;
					MenuList.startAnimation(new ExpandAnimation(MenuList, 0,
							(int) (screenWidth * 0.7), 20));
					MenuComment.startAnimation(new ExpandAnimation(MenuComment,
							0, (int) (screenWidth * 0.7), 20));
				}
			}
		});

		btnToggleMenuComment.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				if (isExpanded) {
					isExpanded = false;

					MenuComment.startAnimation(new CollapseAnimation(
							MenuComment, 0, (int) (screenWidth * 0.7), 20));
				} else {
					isExpanded = true;

					MenuComment.startAnimation(new ExpandAnimation(MenuComment,
							0, (int) (screenWidth * 0.7), 20));
				}
			}
		});
	}
}