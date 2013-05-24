using MyMart.Library;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Windows.Foundation;
using Windows.Foundation.Collections;
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
    public sealed partial class LoginUserPassUC : UserControl
    {
        public delegate void LoggedInHandler(object sender, RoutedEventArgs e);
        public event LoggedInHandler LoggedIn;

        public LoginUserPassUC()
        {
            this.InitializeComponent();

            if (!LocalSetting.IsRegisterDevice)
            {
                firstLoginTextBlock.Visibility = Visibility.Visible;
            }
            else firstLoginTextBlock.Visibility = Visibility.Collapsed;                
            
        }

        private async void loginButton_Click(object sender, RoutedEventArgs e)
        {
            AuthenticateJsonResult result = await MyMartService.AuthenWithUsername(userNameTextBox.Text, passwordBox.Password);

            if (result.Authenticated)
            {
                LocalSetting.UserID = result.UserID;
                LoggedIn(sender, e);
            }
            else
            {
                MessageDialog messageDialog = new MessageDialog(result.ExceptionMessage, "Authentication Fail");
                await messageDialog.ShowAsync();
            }
        }
    }
}
