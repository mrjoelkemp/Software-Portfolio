using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Audio;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.GamerServices;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using Microsoft.Xna.Framework.Media;
using Microsoft.Xna.Framework.Net;
using Microsoft.Xna.Framework.Storage;

namespace Gesture
{
    public class ProjectGesture : Game
    {

        public GraphicsDeviceManager graphics;
        public ScreenManager screenManager;
        private ContentManager content;

        public ProjectGesture()
        {
            graphics = new GraphicsDeviceManager(this);
            graphics.PreferredBackBufferWidth = 1280;
            graphics.PreferredBackBufferHeight = 720;
            graphics.SynchronizeWithVerticalRetrace = true;
            //graphics.SynchronizeWithVerticalRetrace = false;
            //this.IsFixedTimeStep = false;
            Content.RootDirectory = "Content";


        }

        protected override void Initialize()
        {
            screenManager = new ScreenManager(this);
            this.Components.Add(screenManager);

            screenManager.AddScreen(new BackgroundScreen());
            screenManager.AddScreen(new MainMenuScreen());

            base.Initialize();
        }

        protected override void LoadContent()
        {

            if (content == null)
            {
                content = new ContentManager(screenManager.Game.Services, "Content");
            }

            //Load system fonts
            Defines.spriteFontKootenay = content.Load<SpriteFont>("fonts/Kootenay");

            base.LoadContent();
        }
        /// <summary>
        /// Allows the game to run logic such as updating the world,
        /// checking for collisions, gathering input and playing audio.
        /// </summary>
        /// <param name="gameTime">Provides a snapshot of timing values.</param>
        protected override void Update(GameTime gameTime)
        {
            base.Update(gameTime);
        }

        /// <summary>
        /// This is called when the game should draw itself.
        /// </summary>
        /// <param name="gameTime">Provides a snapshot of timing values.</param>
        protected override void Draw(GameTime gameTime)
        {
            graphics.GraphicsDevice.Clear(Color.Black);

            // the screen manager owns the real drawing

            base.Draw(gameTime);
        }


    }


}

