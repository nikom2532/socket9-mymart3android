﻿using MyMart.Library;
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

// The Blank Page item template is documented at http://go.microsoft.com/fwlink/?LinkId=234238

namespace MyMart.View
{
    /// <summary>
    /// An empty page that can be used on its own or navigated to within a Frame.
    /// </summary>
    public sealed partial class HomePage : Page
    {
        public HomePage()
        {
            this.InitializeComponent();
        }

        /// <summary>
        /// Invoked when this page is about to be displayed in a Frame.
        /// </summary>
        /// <param name="e">Event data that describes how this page was reached.  The Parameter
        /// property is typically used to configure the page.</param>
        protected override async void OnNavigatedTo(NavigationEventArgs e)
        {
            ClassListJsonResult result = await MyMartService.GetClassList();
            classListBox.ItemsSource = result.Classes;
        }

        private async void classListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (classListBox.SelectedIndex >= 0)
            {
                Class clas = classListBox.SelectedItem as Class;
                UnitListJsonResult result = await MyMartService.GetUnitList(clas.ClassID);
                unitListBox.ItemsSource = result.Units;
            }
            

        }
    }
}
