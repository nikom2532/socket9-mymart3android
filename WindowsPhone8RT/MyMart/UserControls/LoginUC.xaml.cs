using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI;
using Windows.UI.Popups;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

// The User Control item template is documented at http://go.microsoft.com/fwlink/?LinkId=234236

namespace MyMart.UserControls
{
    public sealed partial class LoginUC : UserControl
    {
        LoginUserPassUC loginUserPassUC;
        LoginQuickPinUC loginQuickPinUC;

        SolidColorBrush purpleBrush = new SolidColorBrush(Color.FromArgb(255, 108, 34, 44));
        SolidColorBrush grayBrush = new SolidColorBrush(Color.FromArgb(255, 203, 204, 210));
        SolidColorBrush blackBrush = new SolidColorBrush(Color.FromArgb(255, 0, 0, 0));
        SolidColorBrush whiteBrush = new SolidColorBrush(Color.FromArgb(255, 255, 255, 255));

        public LoginUC()
        {
            this.InitializeComponent();

            loginUserPassUC = new LoginUserPassUC();
            loginUserPassUC.LoggedIn += loginUserPassUC_LoggedIn;
            contentBorder.Child = loginUserPassUC;

            if (App.IsFirstTimeLogin)
            {
                tabGrid.Visibility = Visibility.Collapsed;
            }
            else tabGrid.Visibility = Visibility.Visible;
        }

        async void loginUserPassUC_LoggedIn(object sender, RoutedEventArgs e)
        {
            if (App.IsFirstTimeLogin)
            {
                MessageDialog messageDialog = new MessageDialog("This is the first time you have logged into myMART using this device.\n\n- If this is your personal (trusted) device. you may setup a 'quick-pin' for easier future access.\n- If this a shared (public), please select 'No'\n\nThank You.", "Register your device?");
                messageDialog.Commands.Add(new UICommand("No", new UICommandInvokedHandler(this.FirstTimeQuickPinInvokedHandler)));
                messageDialog.Commands.Add(new UICommand("Yes", new UICommandInvokedHandler(this.FirstTimeQuickPinInvokedHandler)));
                messageDialog.DefaultCommandIndex = 1;
                messageDialog.CancelCommandIndex = 0;

                await messageDialog.ShowAsync();
            }
            else LoggedIn();            
        }

        private void FirstTimeQuickPinInvokedHandler(IUICommand command)
        {
            // Display message showing the label of the command that was invoked
            if (command.Label.CompareTo("Yes") == 0)
            {
                loginQuickPinUC = new LoginQuickPinUC();
                loginQuickPinUC.LoggedIn += loginQuickPinUC_LoggedIn;
                contentBorder.Child = loginQuickPinUC;
            }
            else LoggedIn();  
        }

        void loginQuickPinUC_LoggedIn(object sender, RoutedEventArgs e)
        {
            App.IsFirstTimeLogin = false;
            LoggedIn();
        }

        void LoggedIn()
        {
            //TODO
            Frame rootFrame = Window.Current.Content as Frame;

            if (!rootFrame.Navigate(typeof(View.HomePage)))
            {
                throw new Exception("Failed to create initial page");
            }
        }

        private void userPassButton_Click(object sender, RoutedEventArgs e)
        {
            userPassBorder.Background = purpleBrush;
            quickPinBorder.Background = grayBrush;

            userPassButton.Foreground = whiteBrush;
            quickPinButton.Foreground = blackBrush;
            
            loginUserPassUC = new LoginUserPassUC();
            loginUserPassUC.LoggedIn += loginUserPassUC_LoggedIn;
            contentBorder.Child = loginUserPassUC;
        }

        private void quickPinButton_Click(object sender, RoutedEventArgs e)
        {
            userPassBorder.Background = grayBrush;
            quickPinBorder.Background = purpleBrush;

            userPassButton.Foreground = blackBrush;
            quickPinButton.Foreground = whiteBrush;

            loginQuickPinUC = new LoginQuickPinUC();
            loginQuickPinUC.LoggedIn += loginQuickPinUC_LoggedIn;
            contentBorder.Child = loginQuickPinUC;
        }
    }
}
