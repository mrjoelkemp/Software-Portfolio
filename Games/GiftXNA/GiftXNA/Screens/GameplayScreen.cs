#region File Description
//-----------------------------------------------------------------------------
// GameplayScreen.cs
//
// Microsoft XNA Community Game Platform
// Copyright (C) Microsoft Corporation. All rights reserved.
//-----------------------------------------------------------------------------
#endregion

#region Using Statements
using System;
using System.Threading;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using System.Collections.Generic;
using Microsoft.Xna.Framework.Audio;
#endregion

namespace Gesture
{
    class GameplayScreen : GameScreen
    {
        #region Fields

        ContentManager content;
        SpriteBatch spriteBatch;
        SpriteFont spriteFont;
        // Audio objects
        SoundEffect soundEffect;

        Sprite joey;
        Vector2 monikaSpeed;
        Sprite monika;
        PlayerBullet kiss;
        int score = 0;
        //bool canKiss = true;
        bool flipMonikaRotation = false;
        KeyboardState oldState;
//        PlayerManager playerManager;
  
        /// <summary>
        /// Indicates whether or not the game is over.
        /// </summary>
        bool gameOver;
        #endregion

        #region Initialization
        /// <summary>
        /// Constructor.
        /// </summary>
        public GameplayScreen()
        {
            TransitionOnTime = TimeSpan.FromSeconds(1.0);
            TransitionOffTime = TimeSpan.FromSeconds(1.0);
        }


        /// <summary>
        /// Initialize the game, after the ScreenManager is set, but not every time
        /// the graphics are reloaded.
        /// </summary>
        public void Initialize()
        {
            //Set up the frames counter
            //ScreenManager.Game.Components.Add(new FPSComponent(ScreenManager.Game));
            gameOver = false;
        }


        /// <summary>
        /// Load graphics content for the game.
        /// </summary>
        public override void LoadContent()
        {
            if (content == null)
                content = new ContentManager(ScreenManager.Game.Services, "Content");

            spriteBatch = new SpriteBatch(ScreenManager.GraphicsDevice);
            spriteFont = ScreenManager.Game.Content.Load<SpriteFont>("Kootenay");
            
            soundEffect = ScreenManager.Game.Content.Load<SoundEffect>("kiss2");

            joey = new Sprite(ScreenManager.Game, "joey");
            monika = new Sprite(ScreenManager.Game, "monika");
            kiss = new PlayerBullet(ScreenManager.Game, "kiss");
            joey.Initialize();
            monika.Initialize();
            joey.position = new Vector2(600 - joey.texture.Width + joey.center.X, 300);
            monika.position = new Vector2(100, 300);
            kiss.forwardVector = new Vector2(-1, 0);
            
            monikaSpeed = new Vector2(0, 3);

            //Once the load has finished, we use ResetElapsedTime to tell the game's
            //timing mechanism that we have just finished a very long frame, and that
            //it should not try to catch up.
            ScreenManager.Game.ResetElapsedTime();
        }


        /// <summary>
        /// Unload graphics content used by the game.
        /// </summary>
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
        #endregion

        #region Update and Draw
        /// <summary>
        /// Updates the state of the game. This method checks the GameScreen.IsActive
        /// property, so the game will stop updating when the pause menu is active,
        /// or if you tab away to a different application.
        /// </summary>
        public override void Update(GameTime gameTime, bool otherScreenHasFocus,
                                                       bool coveredByOtherScreen)
        {
            base.Update(gameTime, otherScreenHasFocus, coveredByOtherScreen);
            
            joey.Update(gameTime);
            UpdateMonikaMovement(gameTime);
            monika.Update(gameTime);

            if (kiss.isActive)
            {
                kiss.Update(gameTime);
                Vector2 position = kiss.position;
                if (position.X - kiss.center.X < 0 || position.X - kiss.center.X > 600 || 
                    position.Y  - kiss.center.Y < 0 || position.Y - kiss.center.Y > 600)
                    kiss.isActive = false;
                checkCollision();

            }
            if ((otherScreenHasFocus == true) || (coveredByOtherScreen == true))
            {
                if (gameOver == false)
                {
                  
                }
            }
            else
            {
                // check for a winner
                if (gameOver == false)
                {
                    if (score >= 30)
                    {
                        gameOver = true;
                        // If they pressed pause, bring up the pause menu screen.
                        ScreenManager.AddScreen(new GameOverScreen());
                    }
                }
                
            }
        }

        //Purpose: Controls monika's movement
        private void UpdateMonikaMovement(GameTime gameTime)
        {
            
            int upperBound = 600 - monika.texture.Height + (int)monika.center.Y;
            int lowerBound = 0 + (int)monika.center.Y;
            if (monika.position.Y >= upperBound || monika.position.Y <= lowerBound)
                monikaSpeed.Y = -monikaSpeed.Y;

            //Update vertical movement
            monika.position.Y += monikaSpeed.Y;
            
            float currentRotation = monika.rotation;
            if (!flipMonikaRotation)
            {
                currentRotation -= MathHelper.ToRadians(1f);
                if (currentRotation <= MathHelper.ToRadians(-10))
                    flipMonikaRotation = true;
            }
            else
            {
                currentRotation += MathHelper.ToRadians(1f);
                if (monika.rotation >= MathHelper.ToRadians(10))
                    flipMonikaRotation = false;
            }

            monika.rotation = currentRotation;
        }

        /// <summary>
        /// Lets the game respond to player input. Unlike the Update method,
        /// this will only be called when the gameplay screen is active.
        /// </summary>
        public override void HandleInput(InputState input)
        {
            if (input == null)
                throw new ArgumentNullException("input");

            KeyboardState keyboardState = input.CurrentKeyboardStates[1];
            if (keyboardState.IsKeyDown(Keys.Escape))
                // If they pressed pause, bring up the pause menu screen.
                ScreenManager.AddScreen(new PauseMenuScreen());
            if (keyboardState.IsKeyDown(Keys.Up))
                joey.position += new Vector2(0,-5);
            if (keyboardState.IsKeyDown(Keys.Down))
                joey.position += new Vector2(0,5);
            if (keyboardState.IsKeyDown(Keys.Space) && !oldState.IsKeyDown(Keys.Space))
                blowKiss();
            
            //Clamp the positions
            joey.position.X = MathHelper.Clamp(joey.position.X, 0, 600);
            joey.position.Y = MathHelper.Clamp(joey.position.Y, 0 + joey.center.Y, 600 - joey.texture.Height + joey.center.Y);     

            oldState = keyboardState;

        }

        //Purpose: Simulates the blowing of a kiss from joey to monika
        private void blowKiss()
        {
            if (kiss.isActive == false)
            {
                kiss.position = new Vector2(joey.position.X, joey.position.Y + (joey.texture.Height/2) - 10);
                kiss.isActive = true;
                soundEffect.Play();
                //canKiss = false;
            }
        }
        
        //TODO: Finish Collision!
        private void checkCollision()
        {
            
            if (kiss.isActive)
            {
                bool isCollision = Collision.PlayerBulletWithEnemy(kiss, monika);
                if (isCollision)
                {
                     kiss.isActive = false;
                    //canKiss = true;
                    score += 10;
                }
            }
            
        }

        /// <summary>
        /// Draws the gameplay screen.
        /// </summary>
        public override void Draw(GameTime gameTime)
        {
            ScreenManager.GraphicsDevice.Clear(Color.Thistle);

            //Draw what's not taken care of by the sprite manager.
            spriteBatch.Begin();

            joey.Draw(ref spriteBatch, gameTime);
            monika.Draw(ref spriteBatch, gameTime);
            if (kiss.isActive)
                kiss.Draw(ref spriteBatch, gameTime);

            DrawHud(spriteBatch, gameTime);
            
            spriteBatch.End();

            // If the game is transitioning on or off, fade it out to black.
            if (TransitionPosition > 0)
                ScreenManager.FadeBackBufferToBlack(255 - TransitionAlpha);
        }


        /// <summary>
        /// Draw the user interface elements of the game (scores, etc.).
        /// </summary>
        /// <param name="elapsedTime">The amount of elapsed time, in seconds.</param>
        private void DrawHud(SpriteBatch spriteBatch, GameTime gameTime)
        {
            string message = "How Young Are You?";
            spriteBatch.DrawString(this.spriteFont, message, new Vector2((ScreenManager.Game.GraphicsDevice.Viewport.Width/2) - 95, 0), Color.Red);

            // Pulsate the size of the selected menu entry.
            double time = gameTime.TotalGameTime.TotalSeconds;
            
            float pulsate = (float)Math.Sin(time * 6) + 1;

            float scale = 1 + pulsate * 0.05f;
            Vector2 origin = new Vector2(0, this.spriteFont.LineSpacing / 2);
            //spriteBatch.DrawString(this.spriteFont, score.ToString(), new Vector2(ScreenManager.Game.GraphicsDevice.Viewport.Width / 2, 25), Color.Red);
            spriteBatch.DrawString(this.spriteFont, score.ToString(), new Vector2(ScreenManager.Game.GraphicsDevice.Viewport.Width / 2, 35), Color.Red,
                0, origin, scale, SpriteEffects.None, 0);
        }
        #endregion
    }
}
