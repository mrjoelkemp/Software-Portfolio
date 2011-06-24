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
            MenuEntry practiceGameMenuEntry = new MenuEntry("Practice");
            MenuEntry simonSaysGameMenuEntry = new MenuEntry("Simon Says");
            MenuEntry survivalGameMenuEntry = new MenuEntry("Survival");
            MenuEntry optionsMenuEntry = new MenuEntry("Options");
            MenuEntry exitMenuEntry = new MenuEntry("Exit");

            practiceGameMenuEntry.Selected += PracticeGameMenuEntrySelected;
            simonSaysGameMenuEntry.Selected += SimonSaysGameMenuEntrySelected;
            survivalGameMenuEntry.Selected += SurvivalGameMenuEntrySelected;
            optionsMenuEntry.Selected += OptionsMenuEntrySelected;
            exitMenuEntry.Selected += ExitMenuEntrySelected;

            MenuEntries.Add(practiceGameMenuEntry);
            MenuEntries.Add(simonSaysGameMenuEntry);
            MenuEntries.Add(survivalGameMenuEntry);
            MenuEntries.Add(optionsMenuEntry);
            MenuEntries.Add(exitMenuEntry);
        }


        #endregion

        #region Handle Input


        /// <summary>
        /// Event handler for when the Play Game menu entry is selected.
        /// </summary>
        void PracticeGameMenuEntrySelected(object sender, EventArgs e)
        {
            LoadingScreen.Load(ScreenManager, LoadPracticeScreen, true);
        }

        /// <summary>
        /// Event handler for when the Play Game menu entry is selected.
        /// </summary>
        void SimonSaysGameMenuEntrySelected(object sender, EventArgs e)
        {
            LoadingScreen.Load(ScreenManager, LoadSimonSaysScreen, true);
        }

        /// <summary>
        /// Event handler for when the Play Game menu entry is selected.
        /// </summary>
        void SurvivalGameMenuEntrySelected(object sender, EventArgs e)
        {
            LoadingScreen.Load(ScreenManager, LoadSurvivalScreen, true);
        }

        /// <summary>
        /// Loading screen callback for activating the gameplay screen.
        /// </summary>
        void LoadPracticeScreen(object sender, EventArgs e)
        {
            GameplayScreen gameplayScreen = new GameplayScreen();
            gameplayScreen.ScreenManager = this.ScreenManager;
            gameplayScreen.Initialize();
            ScreenManager.AddScreen(gameplayScreen);
        }

        /// <summary>
        /// Loading screen callback for activating the gameplay screen.
        /// </summary>
        void LoadSimonSaysScreen(object sender, EventArgs e)
        {
            SimonSaysGameScreen simonSaysScreen = new SimonSaysGameScreen();
            simonSaysScreen.ScreenManager = this.ScreenManager;
            simonSaysScreen.Initialize();
            ScreenManager.AddScreen(simonSaysScreen);
        }

        /// <summary>
        /// Loading screen callback for activating the gameplay screen.
        /// </summary>
        void LoadSurvivalScreen(object sender, EventArgs e)
        {
            SurvivalGameScreen survivalScreen = new SurvivalGameScreen();
            survivalScreen.ScreenManager = this.ScreenManager;
            survivalScreen.Initialize();
            ScreenManager.AddScreen(survivalScreen);
        }

        /// <summary>
        /// Event handler for when the Options menu entry is selected.
        /// </summary>
        void OptionsMenuEntrySelected(object sender, EventArgs e)
        {
            ScreenManager.AddScreen(new OptionsMenuScreen());
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
            const string message = "Exit Project Gesture?";

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
