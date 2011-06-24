using System;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace Gesture
{
    /// <summary>
    /// Renders the current frames per second (FPS).
    /// </summary>
    class FPSComponent : DrawableGameComponent
    {
        SpriteBatch spriteBatch;
        SpriteFont spriteFont;

        int frameRate = 0;
        int frameCounter = 0;
        TimeSpan elapsedTime = TimeSpan.Zero;
        Vector2 textPosition;

        public FPSComponent(Game game)
            : base(game)
        {

            spriteBatch = new SpriteBatch(Game.GraphicsDevice);
            spriteFont = Game.Content.Load<SpriteFont>("Kootenay");
            int screenWidth = Game.GraphicsDevice.Viewport.Width;
            //Top right corner of screen (-70 is just some offset to the left)
            textPosition = new Vector2(screenWidth - 70, 0);
        }

        public override void Initialize()
        {
            base.Initialize();
        }

        protected override void LoadContent()
        {

            base.LoadContent();
        }

        public override void Update(GameTime gameTime)
        {
            elapsedTime += gameTime.ElapsedGameTime;

            if (elapsedTime > TimeSpan.FromSeconds(1))
            {
                elapsedTime -= TimeSpan.FromSeconds(1);
                frameRate = frameCounter;
                frameCounter = 0;
            }
        }

        public override void Draw(GameTime gameTime)
        {
            frameCounter++;

            string fps = string.Format("fps: {0}", frameRate);


            spriteBatch.Begin();
            spriteBatch.DrawString(this.spriteFont, fps, textPosition, Color.White);
            spriteBatch.End();
        }
    }
}
