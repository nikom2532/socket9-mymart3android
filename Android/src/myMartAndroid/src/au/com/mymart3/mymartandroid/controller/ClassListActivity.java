/*
 * 
 */
package au.com.mymart3.mymartandroid.controller;

import java.util.ArrayList;

import android.app.Activity;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;
import au.com.mymart3.mymartandroid.R;
import au.com.mymart3.mymartandroid.config.ConfigManager;
import au.com.mymart3.mymartandroid.library.AlertManager;
import au.com.mymart3.mymartandroid.models.GetClassListModel;
import au.com.mymart3.mymartandroid.models.GetUnitListModel;
import au.com.mymart3.mymartandroid.models.GetClassListModel.ClassListDetailResult;
import au.com.mymart3.mymartandroid.models.GetUnitListModel.UnitListDetailResult;

/**
 * The Class ClassListActivity: ClassListActivity Controller.
 */
public class ClassListActivity extends Activity {
	
	/** The context. */
	private Activity mContext;
	
	/** The class list model . */
	private GetClassListModel mGetClassList;
	
	/** The unit list model. */
	private GetUnitListModel mGetUnitList;
	
	/** The list view object for class*/
	private ListView mClassListView; 
	
	/** The list view object for unit*/
	private ListView mUnitListView;
	
    /* (non-Javadoc)
     * @see android.app.Activity#onCreate(android.os.Bundle)
     */
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_classlist);
        mContext = this;
        
        // Find the ListView resource.   
        mClassListView = (ListView) findViewById( R.id.listViewClass );
        mUnitListView = (ListView) findViewById( R.id.listViewUnit );
        
        mClassListView.setOnItemClickListener(OnClassListItemClickListener);
        
		// Display wait dialog
		AlertManager.displayLoadingMessage(mContext, "Getting class list...", null); 

        // Load class list
        mGetClassList = new GetClassListModel();
       
        // set call back
        mGetClassList.onCompleteCallback = onGetClassListComplete;
        mGetClassList.getClassList(ConfigManager.gUserID);
    }
    
    // This will called after GetClassList is complete
    /** The on get class list complete. */
    Runnable onGetClassListComplete = new Runnable() {		
		@Override
		public void run() {
			
			// Hide loading message
			AlertManager.hideWaitDlg();
						
			// Check result and display error popup
			if(!mGetClassList.errorMessage.equalsIgnoreCase("success"))
			{
				AlertManager.displayMessage(mContext, mGetClassList.errorMessage,"GetClassList Fail");
			}
			else if(null != mGetClassList.exceptionMessage && mGetClassList.exceptionMessage.length() > 0 && !mGetClassList.exceptionMessage.equalsIgnoreCase("null") )
			{
				AlertManager.displayMessage(mContext, mGetClassList.exceptionMessage,"GetClassList Fail");
			}

			if(true == mGetClassList.ClassListSuccess)
			{
				// Set result to list adapter
				mClassListView.setAdapter(new ClassAdapter(mGetClassList.classes));
			}
			else
			{
				AlertManager.displayErrorMessage(mContext, "Get ClassList Fail");
			}
			
			// Auto load unit list if has only one class
			if(mGetClassList.classes.size() == 1)
			{
				LoadUnitList(mGetClassList.classes.get(0).classID);
			}
		}
	};

	// Create custom adapter to display class list
	/**
	 * The Class ClassAdapter.
	 */
	private class ClassAdapter extends BaseAdapter {
        
        /** The m result list. */
        private ArrayList<ClassListDetailResult> mResultList;
        
        /**
         * Instantiates a new class adapter.
         *
         * @param Classes the classes
         */
        public ClassAdapter(ArrayList<ClassListDetailResult> Classes) 
        {
        	mResultList = Classes;
        }

        /* (non-Javadoc)
         * @see android.widget.Adapter#getCount()
         */
        public int getCount() { return mResultList.size(); }

        /* (non-Javadoc)
         * @see android.widget.Adapter#getItem(int)
         */
        public Object getItem(int position) { return mResultList.get(position); }

        /* (non-Javadoc)
         * @see android.widget.Adapter#getItemId(int)
         */
        public long getItemId(int position) { return position; }

        /* (non-Javadoc)
         * @see android.widget.Adapter#getView(int, android.view.View, android.view.ViewGroup)
         */
        public View getView(int position, View convertView, ViewGroup parent) {
        	LayoutInflater factory = LayoutInflater.from(mContext);
        	View listItemView = null;
        	
        	ClassListDetailResult classListDetailResult = mResultList.get(position);
        	
        	// Get view for display this item
        	listItemView = factory.inflate(R.layout.simplerow, null);
            ((TextView)listItemView.findViewById(R.id.idTextView)).setText(classListDetailResult.classTitle);

            return listItemView;
        }
    }

	// This will called after item in mClassListView is clicked
	/** The On class list item click listener. */
	OnItemClickListener OnClassListItemClickListener = new OnItemClickListener() {
		@Override
		public void onItemClick(AdapterView<?> adapter, View view, int position, long arg) {
			// Get clicked item
			ClassListDetailResult classListDetailResult = (ClassListDetailResult) adapter.getItemAtPosition(position);
			
			// Load Unit base on selected class
			LoadUnitList(classListDetailResult.classID);
		}
	};
	
	/**
	 * Load unit in class.
	 * 
	 * @param classID the class ID which you want to see unit list
	 */
	protected void LoadUnitList(String classID) {
		// Display wait dialog
		AlertManager.displayLoadingMessage(mContext, "Getting unit list...", null); 
		
		mGetUnitList = new GetUnitListModel();
		mGetUnitList.onCompleteCallback = onGetUnitListComplete;
		mGetUnitList.getUnitList(ConfigManager.gUserID, classID);		
	}
	
	
    // This will called after GetUnitList is complete
    /** The on get unit list complete. */
    Runnable onGetUnitListComplete = new Runnable() {		
		@Override
		public void run() {
			// Close wait dialog
        	AlertManager.hideWaitDlg();			

			// Check result and display error popup
			if(!mGetUnitList.errorMessage.equalsIgnoreCase("success"))
			{
				AlertManager.displayMessage(mContext, mGetUnitList.errorMessage,"GetClassList Fail");
			}
			else if(null != mGetUnitList.exceptionMessage && mGetUnitList.exceptionMessage.length() > 0 && !mGetUnitList.exceptionMessage.equalsIgnoreCase("null") )
			{
				AlertManager.displayMessage(mContext, mGetUnitList.exceptionMessage,"GetClassList Fail");
			}
        	
			if(true == mGetUnitList.unitListSuccess)
			{
				// Set result to list adapter
				mUnitListView.setAdapter(new UnitAdapter(mGetUnitList.Units));
			}
			else
			{
				AlertManager.displayErrorMessage(mContext, "Get UnitList Fail");
			}
		}
	};	
		

	// Create custom adapter to display unit list
	/**
	 * The Class UnitAdapter.
	 */
	private class UnitAdapter extends BaseAdapter {
        
        /** The m result list. */
        private ArrayList<UnitListDetailResult> mResultList;
        
        /**
         * Instantiates a new unit adapter.
         *
         * @param Classes the classes
         */
        public UnitAdapter(ArrayList<UnitListDetailResult> Classes) 
        {
        	mResultList = Classes;
        }

        /* (non-Javadoc)
         * @see android.widget.Adapter#getCount()
         */
        public int getCount() { return mResultList.size(); }

        /* (non-Javadoc)
         * @see android.widget.Adapter#getItem(int)
         */
        public Object getItem(int position) { return mResultList.get(position); }

        /* (non-Javadoc)
         * @see android.widget.Adapter#getItemId(int)
         */
        public long getItemId(int position) { return position; }

        /* (non-Javadoc)
         * @see android.widget.Adapter#getView(int, android.view.View, android.view.ViewGroup)
         */
        public View getView(int position, View convertView, ViewGroup parent) {
        	LayoutInflater factory = LayoutInflater.from(mContext);
        	View listItemView = null;
        	
        	UnitListDetailResult unitListDetailResult = mResultList.get(position);
        	
        	// Get view for display this item
        	listItemView = factory.inflate(R.layout.simplerow, null);
            ((TextView)listItemView.findViewById(R.id.idTextView)).setText(unitListDetailResult.unitTitle);

            return listItemView;
        }
    }	
}
