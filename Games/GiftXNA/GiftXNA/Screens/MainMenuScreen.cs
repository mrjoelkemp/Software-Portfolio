#region File Description
//-----------------------------------------------------------------------------
// MainMenuScreen.cs
//
// Microsoft XNA Community Game Platform
// Copyright (C) Microsoft Corporation. All rights reserved.
//-----------------------------------------------------------------------------
#endregion

#region Using Statements
using System;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Audio;
#endregion

namespace Gesture
{
    /// <summary>
    /// The main menu screen is the first thing displayed when the game starts up.
    /// </summary>
    /// <remarks>
    /// This class is somewhat similar to one of the same name in the 
    /// GameStateManagement sample.
    /// </remarks>
    class MainMenuScreen : MenuScreen
    {
        #region Initialization
        

        /// <summary>
        /// Constructor fills in the menu contents.
        /// </summary>
        public MainMenuScreen()
        {
            
            MenuEntry playGameMenuEntry = new MenuEntry("Play Game");
            MenuEntry exitMenuEntry = new MenuEntry("Exit");
            playGameMenuEntry.Color = Color.Red;
            playGameMenuEntry.Selected += playGameMenuEntrySelected;
            exitMenuEntry.Color = Color.Red;
            exitMenuEntry.Selected += ExitMenuEntrySelected;

            MenuEntries.Add(playGameMenuEntry);
            MenuEntries.Add(exitMenuEntry);
        }


        #endregion

        #region Handle Input

        /// <summary>
        /// Event handler for when the Play Game menu entry is selected.
        /// </summary>
        void playGameMenuEntrySelected(object sender, EventArgs e)
        {
            LoadingScreen.Load(ScreenManager, LoadGameplayScreen, true);
        }


        /// <summary>
        /// Loading screen callback for activating the gameplay screen.
        /// </summary>
        void LoadGameplayScreen(object sender, EventArgs e)
        {
            GameplayScreen gameplayScreen = new GameplayScreen();
            gameplayScreen.ScreenManager = this.ScreenManager;
            gameplayScreen.Initialize();
            ScreenManager.AddScreen(gameplayScreen);
        }

        /// <summary>
        /// Event handler for when the Exit menu entry is selected.
        /// </summary>
        void ExitMenuEntrySelected(object sender, EventArgs e)
        {
            OnCancel();
        }


        /// <summary>
        /// When the user cancels the main menu, ask if they want to exit the sample.
        /// </summary>
        protected override void OnCancel()
        {
            const string message = "No more kisses?";

            MessageBoxScreen messageBox = new MessageBoxScreen(message);
            messageBox.Accepted += ExitMessageBoxAccepted;
            ScreenManager.AddScreen(messageBox);
        }


        /// <summary>
        /// Event handler for when the user selects ok on the "are you sure
        /// you want to exit" message box.
        /// </summary>
        void ExitMessageBoxAccepted(object sender, EventArgs e)
        {
            ScreenManager.Game.Exit();
        }


        #endregion
    }
}
