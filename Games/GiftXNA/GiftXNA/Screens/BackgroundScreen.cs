#region File Description
//-----------------------------------------------------------------------------
// BackgroundScreen.cs
//
// Microsoft XNA Community Game Platform
// Copyright (C) Microsoft Corporation. All rights reserved.
//-----------------------------------------------------------------------------
#endregion

#region Using Statements
using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
#endregion

namespace Gesture
{
    /// <summary>
    /// The background screen sits behind all the other menu screens.
    /// It draws a background image that remains fixed in place regardless
    /// of whatever transitions the screens on top of it may be doing.
    /// </summary>
    /// <remarks>
    /// This class is somewhat similar to one of the same name in the 
    /// GameStateManagement sample.
    /// </remarks>
    class BackgroundScreen : GameScreen
    {
        #region Fields
        ContentManager content;
        //Texture2D backgroundTexture;
        Texture2D titleTexture;
        #endregion

        #region Initialization


        /// <summary>
        /// Constructor.
        /// </summary>
        public BackgroundScreen()
        {
            TransitionOnTime = TimeSpan.FromSeconds(1.0);
            TransitionOffTime = TimeSpan.FromSeconds(1.0);

        }


        /// <summary>
        /// Loads graphics content for this screen. The background texture is quite
        /// big, so we use our own local ContentManager to load it. This allows us
        /// to unload before going from the menus into the game itself, wheras if we
        /// used the shared ContentManager provided by the ScreenManager, the content
        /// would remain loaded forever.
        /// </summary>
        public override void LoadContent()
        {
            if (content == null)
                content = new ContentManager(ScreenManager.Game.Services, "Content");

            //backgroundTexture = content.Load<Texture2D>("misc/background");
            titleTexture = content.Load<Texture2D>("title");
            

            int viewportWidth = ScreenManager.GraphicsDevice.Viewport.Width;
            int viewportHeight = ScreenManager.GraphicsDevice.Viewport.Height;


            base.LoadContent();
        }

        /// <summary>
        /// Unloads graphics content for this screen.
        /// </summary>
        public override void UnloadContent()
        {
            content.Unload();
        }


        #endregion

        #region Update and Draw


        /// <summary>
        /// Updates the background screen. Unlike most screens, this should not
        /// transition off even if it has been covered by another screen: it is
        /// supposed to be covered, after all! This overload forces the
        /// coveredByOtherScreen parameter to false in order to stop the base
        /// Update method wanting to transition off.
        /// </summary>
        public override void Update(GameTime gameTime, bool otherScreenHasFocus,
                                                       bool coveredByOtherScreen)
        {
 
            base.Update(gameTime, otherScreenHasFocus, false);
        }


        /// <summary>
        /// Draws the background screen.
        /// </summary>
        public override void Draw(GameTime gameTime)
        {
            SpriteBatch spriteBatch = ScreenManager.SpriteBatch;
            Viewport viewport = ScreenManager.GraphicsDevice.Viewport;
            Vector2 viewportSize = new Vector2(viewport.Width, viewport.Height);
            Rectangle fullscreen = new Rectangle(0, 0, viewport.Width, viewport.Height);
            byte fade = TransitionAlpha;
            // title
            //Vector2 titlePosition = new Vector2(
                //(viewportSize.X - titleTexture.Width) / 2f,
                //viewportSize.Y * 0.18f);
            Vector2 titlePosition = new Vector2(0,0);
            titlePosition.Y -= (float)Math.Pow(TransitionPosition, 2) * titlePosition.Y;

            ScreenManager.Game.GraphicsDevice.Clear(Color.White);
            spriteBatch.Begin(SpriteBlendMode.AlphaBlend);

            //spriteBatch.Draw(backgroundTexture, fullscreen, new Color(fade, fade, fade));
            spriteBatch.Draw(titleTexture, titlePosition, Color.White);

            spriteBatch.End();

        }


        #endregion
    }
}
