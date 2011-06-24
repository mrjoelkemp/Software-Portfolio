using Microsoft.Xna.Framework;
using System;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using System.Collections.Generic;
namespace Gesture
{
    class SimonSaysGameScreen : GameScreen
    {
        ContentManager content;
        SpriteBatch spriteBatch;

        PlayerManager playerManager;
        /// <summary>
        /// Indicates whether or not the game is over.
        /// </summary>
        bool gameOver = false;

        public SimonSaysGameScreen()
        {
            TransitionOnTime = TimeSpan.FromSeconds(1.0);
            TransitionOffTime = TimeSpan.FromSeconds(1.0);
        }

        public void Initialize()
        {
            Defines.playersGestures.Clear();
            Defines.playerFusionTriggered.Clear();

            Defines.clientBounds = ScreenManager.Game.Window.ClientBounds;
            //Set up the frames counter
            ScreenManager.Game.Components.Add(new FPSComponent(ScreenManager.Game));
            gameOver = false;

            //Set up the players
            //TODO: Only signed in players should be added.
            playerManager = new PlayerManager(ScreenManager.Game);

            //Set up the particle system manager.
            Defines.particleManager = new ParticleManager(ScreenManager.Game);

        }

        public override void LoadContent()
        {

            if (content == null)
            {
                content = new ContentManager(ScreenManager.Game.Services, "Content");
            }

            spriteBatch = new SpriteBatch(ScreenManager.GraphicsDevice);

            //Load up the players based on connected controllers
            for (int i = 0; i < 4; i++)
                if (GamePad.GetState((PlayerIndex)i).IsConnected)
                    playerManager.AddPlayer((PlayerIndex)i);

            //If there are no connected controllers
            if (playerManager.playerList.Count == 0)
            {
                //Still add Player 1 -- he'll use the keyboard!
                playerManager.AddPlayer(PlayerIndex.One);
                playerManager.AddPlayer(PlayerIndex.Two);
            }

            //Set the initial positions of the players.
            playerManager.SetInitialPositions();
            //Initialize the system-wide number of players
            Defines.NUM_PLAYERS = playerManager.playerList.Count;

            base.LoadContent();
        }

        public override void UnloadContent()
        {
            if (spriteBatch != null)
            {
                spriteBatch.Dispose();
                spriteBatch = null;
            }

            content.Unload();
            base.UnloadContent();
        }

        public override void Update(GameTime gameTime, bool otherScreenHasFocus, bool coveredByOtherScreen)
        {
            base.Update(gameTime, otherScreenHasFocus, coveredByOtherScreen);

            // if this screen is leaving, then stop the music
            if (IsExiting)
            {
                //audio.StopMusic();
            }
            else if ((otherScreenHasFocus == true) || (coveredByOtherScreen == true))
            {
                // make sure nobody's controller is vibrating
                for (int i = 0; i < 4; i++)
                {
                    GamePad.SetVibration((PlayerIndex)i, 0f, 0f);
                }
                if (gameOver == false)
                {

                }
            }
            else
            {
                // check for a winner
                if (gameOver == false)
                {

                }
                // update the world
                if (gameOver == false)
                {
                    playerManager.Update(gameTime);
                }
            }
        }

        /// <summary>
        /// Lets the game respond to player input. Unlike the Update method,
        /// this will only be called when the gameplay screen is active.
        /// </summary>
        public override void HandleInput(InputState input)
        {
            if (input == null)
                throw new ArgumentNullException("input");

            if (ControllingPlayer.HasValue)
            {
                // In single player games, handle input for the controlling player.
                HandlePlayerInput(input, ControllingPlayer.Value);
            }
            /*
        else if (networkSession != null)
        {
            // In network game modes, handle input for all the
            // local players who are participating in the session.
            foreach (LocalNetworkGamer gamer in networkSession.LocalGamers)
            {
                if (!HandlePlayerInput(input, gamer.SignedInGamer.PlayerIndex))
                    break;
            }
        }          
             */
        }

        /// <summary>
        /// Handles input for the specified player. In local game modes, this is called
        /// just once for the controlling player. In network modes, it can be called
        /// more than once if there are multiple profiles playing on the local machine.
        /// Returns true if we should continue to handle input for subsequent players,
        /// or false if this player has paused the game.
        /// </summary>
        bool HandlePlayerInput(InputState input, PlayerIndex playerIndex)
        {
            // Look up inputs for the specified player profile.
            KeyboardState keyboardState = input.CurrentKeyboardStates[(int)playerIndex];
            GamePadState gamePadState = input.CurrentGamePadStates[(int)playerIndex];

            // The game pauses either if the user presses the pause button, or if
            // they unplug the active gamepad. This requires us to keep track of
            // whether a gamepad was ever plugged in, because we don't want to pause
            // on PC if they are playing with a keyboard and have no gamepad at all!
            bool gamePadDisconnected = !gamePadState.IsConnected &&
                                       input.GamePadWasConnected[(int)playerIndex];

            if (input.IsPauseGame(playerIndex) || gamePadDisconnected)
            {
                // If they pressed pause, bring up the pause menu screen.
                ScreenManager.AddScreen(new PauseMenuScreen());
                return false;
            }
            if (input.SeeStats)
            {
                // If they pressed to see their stats, bring up the stats screen.
                List<int> playerScores = new List<int>();
                for (int i = 0; i < playerManager.playerList.Count; i++)
                    playerScores.Add(playerManager.playerList[i].score);

                ScreenManager.AddScreen(new StatsScreen(playerScores));
            }

            // Pressing DPad-Up enables the High Score Screen
            if (input.IsNewButtonPress(Buttons.DPadUp))
                ScreenManager.AddScreen(new HighScoreScreen(ScreenManager.Game));

            return true;
        }

        public override void Draw(GameTime gameTime)
        {
            ScreenManager.GraphicsDevice.Clear(Color.Black);

            //Draw what's not taken care of by the sprite manager.
            spriteBatch.Begin(SpriteBlendMode.AlphaBlend, SpriteSortMode.Texture, SaveStateMode.None);

            //playerSpriteManager.Draw(ref spriteBatch, gameTime);
            //player1.Draw(ref spriteBatch, gameTime);
            playerManager.Draw(ref spriteBatch, gameTime);
            
            spriteBatch.End();
            
            DrawHud(gameTime);

            // If the game is transitioning on or off, fade it out to black.
            if (TransitionPosition > 0)
                ScreenManager.FadeBackBufferToBlack(255 - TransitionAlpha);

            base.Draw(gameTime);
        }

        /// <summary>
        /// Draw the user interface elements of the game (scores, etc.).
        /// </summary>
        /// <param name="elapsedTime">The amount of elapsed time, in seconds.</param>
        private void DrawHud(GameTime gameTime)
        {
            spriteBatch.Begin();

            //Draw game time
            spriteBatch.DrawString(Defines.spriteFontKootenay, "Time", new Vector2(Defines.clientBounds.Width / 2 - 10, 0), Defines.textColor);
            spriteBatch.DrawString(Defines.spriteFontKootenay, gameTime.TotalGameTime.Minutes + ":" + gameTime.TotalGameTime.Seconds.ToString("00"), new Vector2(Defines.clientBounds.Width / 2, 20), Defines.textColor);

            //Draw the global gestures and fusio mode flags for each player
            for (int i = 0; i < Defines.playersGestures.Count; i++)
            {
                spriteBatch.DrawString(Defines.spriteFontKootenay, "Player " + (PlayerIndex)i + " Gesture: " + Defines.playersGestures[(PlayerIndex)i].ToString(),
                    new Vector2(Defines.clientBounds.Right - 400, (i + 1) * 40), Defines.textColor);

                spriteBatch.DrawString(Defines.spriteFontKootenay, "Player " + (PlayerIndex)i + " Fusion Mode: " + Defines.playerFusionTriggered[(PlayerIndex)i].ToString(),
                   new Vector2(Defines.clientBounds.Right - 400, (i + 1) * 60), Defines.textColor);
            }

            spriteBatch.End();
        }
    }
}
