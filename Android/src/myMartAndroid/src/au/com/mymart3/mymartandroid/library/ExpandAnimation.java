/*
 * 
 */
package au.com.mymart3.mymartandroid.library;

import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.Animation;
import android.widget.Toast;

/**
 * The Class ExpandAnimation: Make the animation.
 */
public class ExpandAnimation extends Animation implements Animation.AnimationListener {
	
	/** The view. */
	private View view;
	
	/** The animation duration. */
	private static int ANIMATION_DURATION;
	
	/** The Last width. */
	private int lastWidth;
	
	/** The From width. */
	private int fromWidth;
	
	/** The To width. */
	private int toWidth;
	
	/** The step size. */
	private static int STEP_SIZE=30;
	
	/**
	 * ExpandAnimation
	 * Instantiates a new expand animation.
	 *
	 * @param v: the view
	 * @param FromWidth: the from width
	 * @param ToWidth: the to width
	 * @param Duration: the duration
	 */
	public ExpandAnimation(View v, int FromWidth, int ToWidth, int Duration) {
		
		this.view = v;
		ANIMATION_DURATION = 1;
		this.fromWidth = FromWidth;
		this.toWidth = ToWidth;
		setDuration(ANIMATION_DURATION);
		setRepeatCount(20);
		setFillAfter(false);
		setInterpolator(new AccelerateInterpolator());
		setAnimationListener(this);
	}

	/* (non-Javadoc)
	 * @see android.view.animation.Animation.AnimationListener#onAnimationEnd(android.view.animation.Animation)
	 */
	public void onAnimationEnd(Animation anim) {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see android.view.animation.Animation.AnimationListener#onAnimationRepeat(android.view.animation.Animation)
	 */
	public void onAnimationRepeat(Animation anim) {
		// TODO Auto-generated method stub
		LayoutParams lyp =  view.getLayoutParams();
		lyp.width = lastWidth +=toWidth/20;
		view.setLayoutParams(lyp);
	}

	/* (non-Javadoc)
	 * @see android.view.animation.Animation.AnimationListener#onAnimationStart(android.view.animation.Animation)
	 */
	public void onAnimationStart(Animation anim) {
		// TODO Auto-generated method stub
		LayoutParams lyp =  view.getLayoutParams();
		lyp.width = 0;
		view.setLayoutParams(lyp);
		lastWidth = 0;
	}

}
