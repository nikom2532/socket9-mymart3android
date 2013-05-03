using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Windows.Foundation;
using Windows.Foundation.Collections;
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

            if (App.IsFirstTimeLogin)
            {
                firstLoginTextBlock.Visibility = Visibility.Visible;
            }
            else firstLoginTextBlock.Visibility = Visibility.Collapsed;                
            
        }

        private void loginButton_Click(object sender, RoutedEventArgs e)
        {
            LoggedIn(sender, e);
        }
    }
}
