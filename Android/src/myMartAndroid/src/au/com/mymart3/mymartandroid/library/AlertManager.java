/*
 * 
 */
package au.com.mymart3.mymartandroid.library;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;


import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnCancelListener;
import android.content.DialogInterface.OnClickListener;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

/**
 * The Class AlertManager: Display Alert.
 */
public class AlertManager {

	/** The Constant log. */
	private static final LogManager log = LogFactory.getLog(AlertManager.class);
	
	/** The m progress dialog dialog. */
	public static ProgressDialog mProgressDialogDialog = null;
	
	/** The m toast. */
	static Toast mToast = null;
	
    /**
     * Popup.
     *
     * @param context the context
     * @param message the message
     * @param title the title
     */
    public static void displayMessage(Context context,String message,String title)
    {
    	try {
	        AlertDialog.Builder dialog = new AlertDialog.Builder(context);
	        dialog.setTitle(title);
	        dialog.setMessage(message);
	        dialog.setPositiveButton("OK", new OnClickListener() {
				public void onClick(DialogInterface dialog, int which) {
					dialog.dismiss();
				}
			});
	        dialog.show();
    	} 
	    catch (Exception e) {}	        
    }
    
	/**
	 * Toast.
	 *
	 * @param context: the context
	 * @param txt: the value to display
	 */
	static public void toast(Context context,String txt) {
		CharSequence text = txt;
		int duration = Toast.LENGTH_LONG;
		if(null != mToast) mToast.cancel();
		mToast = Toast.makeText(context, text, duration);
		mToast.show();
	}

    /**
     * Pop error.
     *
     * @param context: the context
     * @param message: the message to display
     */
    public static void displayErrorMessage(Context context,String message)
    {
    	try {
	        AlertDialog.Builder dialog = new AlertDialog.Builder(context);
	        dialog.setTitle("Error");
	        dialog.setMessage(message);
	        dialog.setPositiveButton("OK", new OnClickListener() {
				public void onClick(DialogInterface dialog, int which) {
					dialog.dismiss();
				}
			});
	        dialog.show();
    	} 
	    catch (Exception e) {
	    	log.error("PopError : "+e.getMessage());
	    }
    }

	/**
	 * Display Loading Message
	 *
	 * @param context: the context
	 * @param txt: the text to display
	 * @param onCancel: tell the method to redirect to where if the user cancel the dialog
	 */
	static public void displayLoadingMessage(Context context,String txt,final Runnable onCancel) {
		try {
			if(null != mProgressDialogDialog) mProgressDialogDialog.dismiss();
			mProgressDialogDialog = null;
			mProgressDialogDialog = new ProgressDialog(context);
			mProgressDialogDialog.setMessage(txt); 
			mProgressDialogDialog.setIndeterminate(true); 
			if(null != onCancel){
				mProgressDialogDialog.setCancelable(true);
				mProgressDialogDialog.setButton("Cancel", new OnClickListener() {
					public void onClick(DialogInterface dialog, int which) {
						onCancel.run();
					}
				});
				mProgressDialogDialog.setOnCancelListener(new OnCancelListener() {
					public void onCancel(DialogInterface dialog) {
						onCancel.run();
					}
				});
			}
			else {
				mProgressDialogDialog.setCancelable(false);
			}
			mProgressDialogDialog.show(); 
	    } 
	    catch (Exception e) {}
	}
	
	/**
	 * hideWaitDlg
	 * Hides waiting dialog.
	 */
	static public void hideWaitDlg() {		
	    try {
			if(null != mProgressDialogDialog) mProgressDialogDialog.dismiss();
			mProgressDialogDialog = null;
	    } 
	    catch (Exception e) {}
	}

    /**
     * confirmDialog
     * displays dialog to confirm.
     *
     * @param message: the message to display
     * @param context: the context
     * @param onConfirm: the on confirm
     */
    public static void confirmDialog(String message,Context context, final Runnable onConfirm)
    {
    	try {
	        AlertDialog.Builder dialog = new AlertDialog.Builder(context);
	        dialog.setTitle("Confrim");
	        dialog.setMessage(message);
	        dialog.setPositiveButton("Yes", new OnClickListener() {
				public void onClick(DialogInterface dialog, int which) {
					dialog.dismiss();
					onConfirm.run();					
				}
			});
	        dialog.setNegativeButton("No", new OnClickListener() {
				public void onClick(DialogInterface dialog, int which) {
					dialog.dismiss();
				}
			});
	        dialog.show();
    	} 
	    catch (Exception e) {}	        
    }
    
	/**
	 * getFileName
	 * Gets the file name.
	 *
	 * @param url: the url to extract the file name
	 * @exception if the unexpected error happens
	 * @return the extracted file name
	 */
	static public String getFileName(String url) {
		String filename = "";
		try{
			filename = url.substring(url.lastIndexOf('/')+1, url.lastIndexOf('.'));
			// Or see http://stackoverflow.com/questions/605696/get-file-name-from-url
		}
		catch(Exception e)
		{}
		
		return filename;
	}
	
	/**
	 * setCacheImage
	 * Sets the cache image, support 2 file formats - JPG and PNG
	 *
	 * @param context: the context
	 * @param url: the target url
	 * @param bitmap: the bitmap to catch
	 * @exception exception handler - file not found or any error on IO
	 */
	static public void setCacheImage(Context context,String url,Bitmap bitmap) {
		File cacheDir = context.getCacheDir(); 
		File imageFile;
		FileOutputStream fos;
		imageFile = new File(cacheDir, getFileName(url)); // store the output in cache folder
		Boolean bJPG = true; // keep in JPEG by default
		
		// check the file extension whether the file format is JPG or PNG
		if(url.toLowerCase().contains(".png")) bJPG = false;
		
		try {
			fos = new FileOutputStream(imageFile);
			if(bJPG) bitmap.compress(Bitmap.CompressFormat.JPEG, 80, fos);			
			else bitmap.compress(Bitmap.CompressFormat.PNG, 80, fos);
			fos.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}   
	}
	
	/**
	 * getCacheImage
	 * Gets the cache image.
	 *
	 * @param context the context
	 * @param url the url
	 * @exception check if any error happens - file not found or any IOs
	 * @return bitmap
	 */
	static public Bitmap getCacheImage(Context context,String url) {
		Bitmap bitmap = null;
		log.debug(" context = " + context);
		try {			
			File cacheDir = context.getCacheDir(); 
			File imageFile;
			FileInputStream fis;
			
			// read file from cache folder
			imageFile = new File(cacheDir, getFileName(url));
			
			// read stream
			fis = new FileInputStream(imageFile);
			bitmap = BitmapFactory.decodeStream(fis);
			fis.close();
		} catch (FileNotFoundException e) {
			bitmap = null;
			//e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return bitmap;
	}
	

    /**
     * exitProgram
     * Exits the app
     *
     * @param activity the activity
     */
    public static void exitProgram(final Activity activity)
    {
    	try {
	        AlertDialog.Builder dialog = new AlertDialog.Builder(activity);
	        dialog.setTitle("Confirm");
	        dialog.setMessage("Are you sure you want to exit ?");
	        dialog.setPositiveButton("Yes", new OnClickListener() {
				public void onClick(DialogInterface dialog, int which) {
					dialog.dismiss();
					activity.setResult(-1);
					activity.finish();
				}
			});
	        dialog.setNegativeButton("No", new OnClickListener() {
				public void onClick(DialogInterface dialog, int which) {
					dialog.dismiss();
				}
			});
	        dialog.show();
    	} 
	    catch (Exception e) {}	        
    }	
}
