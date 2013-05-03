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
    public sealed partial class LoginQuickPinUC : UserControl
    {
        public delegate void LoggedInHandler(object sender, RoutedEventArgs e);
        public event LoggedInHandler LoggedIn;

        string password;
        bool isConfirmPin;

        public LoginQuickPinUC()
        {
            this.InitializeComponent();
            password = "";

            if (App.IsFirstTimeLogin)
            {
                isConfirmPin = true;
                cancelButton.Visibility = Visibility.Visible;
            }
            else
            {
                cancelButton.Visibility = Windows.UI.Xaml.Visibility.Collapsed;
            }
        }

        private void buttonNum_Click(object sender, RoutedEventArgs e)
        {
            Button button = sender as Button;
            if (button.Content.ToString().CompareTo("<") == 0)
            {
                if (password.Length >= 1)
                {
                    password = password.Substring(0, password.Length - 1);

                    SetPasswordBox(password);
                }
            }
            else if (button.Content.ToString().CompareTo("Forgot My Pin") == 0)
            {
                
            }
            else 
            {
                password += button.Content.ToString();

                SetPasswordBox(password);

                if (password.Length >= 4)
                {
                    if (isConfirmPin)
                    {
                        isConfirmPin = false;
                        descriptionTextBlock.Text = "Please confirm your Quick-Pin";
                        password = "";

                        SetPasswordBox(password);
                    }
                    else
                    {
                        LoggedIn(sender, e);
                    }
                }
            }
        }

        void SetPasswordBox(string password)
        {
            passwordNum1.Text = password.Length >= 1 ? "*" : "";
            passwordNum2.Text = password.Length >= 2 ? "*" : "";
            passwordNum3.Text = password.Length >= 3 ? "*" : "";
            passwordNum4.Text = password.Length >= 4 ? "*" : "";
        }
    }
}
