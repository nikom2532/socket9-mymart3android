using MyMart.Library;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
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
    public sealed partial class LoginQuickPinUC : UserControl
    {
        public delegate void LoggedInHandler(object sender, RoutedEventArgs e);
        public event LoggedInHandler LoggedIn;

        string pin, firstpin;
        bool isConfirmPin;

        public LoginQuickPinUC()
        {
            this.InitializeComponent();
            pin = "";

            if (!LocalSetting.IsRegisterDevice)
            {
                isConfirmPin = true;
                cancelButton.Visibility = Visibility.Visible;
            }
            else
            {
                cancelButton.Visibility = Windows.UI.Xaml.Visibility.Collapsed;
            }
        }

        private async void buttonNum_Click(object sender, RoutedEventArgs e)
        {
            Button button = sender as Button;
            if (button.Content.ToString().CompareTo("<") == 0)
            {
                if (pin.Length >= 1)
                {
                    pin = pin.Substring(0, pin.Length - 1);

                    SetPasswordBox(pin);
                }
            }
            else if (button.Content.ToString().CompareTo("Forgot My Pin") == 0)
            {
                
            }
            else 
            {
                pin += button.Content.ToString();

                SetPasswordBox(pin);

                if (pin.Length >= 4)
                {
                    if (!LocalSetting.IsRegisterDevice)
                    {
                        if (isConfirmPin)
                        {
                            isConfirmPin = false;
                            firstpin = pin;
                            descriptionTextBlock.Text = "Please confirm your Quick-Pin";
                            pin = "";

                            SetPasswordBox(pin);
                        }
                        else
                        {
                            if (pin == firstpin)
	                        {
                                RegisterDeviceQuickPinJsonResult result = await MyMartService.RegisterDeviceQuickPin(pin, true);

                                if (result.RegisterSuccess)
                                {
                                    LocalSetting.IsRegisterDevice = true;
                                    LoggedIn(sender, e);
                                }
                                else
                                {
                                    MessageDialog messageDialog = new MessageDialog(result.ExceptionMessage);
                                    await messageDialog.ShowAsync();
                                }
	                        }
                        }
                    }
                    else
                    {
                        AuthenticateJsonResult result = await MyMartService.AuthenWithQuickPin(pin);

                        if (result.Authenticated)
                        {
                            LocalSetting.UserID = result.UserID;
                            LoggedIn(sender, e);
                        }
                        else
                        {
                            MessageDialog messageDialog = new MessageDialog(result.ExceptionMessage);
                            await messageDialog.ShowAsync();
                        }
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
