using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Input;


namespace Gesture
{
    class StatsScreen : GameScreen
    {
        #region Fields
        Texture2D titleTexture;
        List<int> playerScoresList;
        #endregion

        #region Initialization

        public StatsScreen(List<int> scores)
        {
            //Store the list of scores
            this.playerScoresList = scores;

            // Flag that there is no need for the game to transition
            // off when the pause menu is on top of it.
            IsPopup = true;
        }

        public override void LoadContent()
        {
            titleTexture = ScreenManager.Game.Content.Load<Texture2D>("misc/title");
            base.LoadContent();
        }

        #endregion


        #region Handle Input

        public override void HandleInput(InputState input)
        {
            if (input == null)
                throw new ArgumentNullException("input");

            if(input.IsNewButtonPress(Buttons.Back))
                ExitScreen();

            base.HandleInput(input);
        }

        #endregion

        public override void Draw(GameTime gameTime)
        {
            Viewport viewport = ScreenManager.GraphicsDevice.Viewport;
            Vector2 viewportSize = new Vector2(viewport.Width, viewport.Height);

            // title
            Vector2 titlePosition = new Vector2(
                (viewportSize.X - titleTexture.Width) / 2f,
                viewportSize.Y * 0.18f);
            titlePosition.Y -= (float)Math.Pow(TransitionPosition, 2) * titlePosition.Y;
            Color titleColor = Color.White;

            ScreenManager.SpriteBatch.Begin();
            ScreenManager.SpriteBatch.Draw(titleTexture, titlePosition,
                new Color(titleColor.R, titleColor.G, titleColor.B, TransitionAlpha));
            
            //Draw player scores
            for (int i = 0; i < playerScoresList.Count; i++)
                ScreenManager.SpriteBatch.DrawString(ScreenManager.Font, "Player " + (PlayerIndex)i + " Score: " +playerScoresList[i], new Vector2(titlePosition.X, titlePosition.Y + ((i+1)*300)), Color.White);

            ScreenManager.SpriteBatch.End();

            base.Draw(gameTime);
        }
    }
}
