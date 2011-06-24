using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using Gesture;

class GameOverScreen : GameScreen
{
    Texture2D texture;
    ParticleManager particleManager;

    private KeyboardState lastState;
    SpriteFont spriteFont; 
    public GameOverScreen()
    {
        //this.game = game;
        
        lastState = Keyboard.GetState();
        IsPopup = true;
       
    }

    public override void LoadContent()
    {
        texture = ScreenManager.Game.Content.Load<Texture2D>("GameOverScreen");
        spriteFont = ScreenManager.Game.Content.Load<SpriteFont>("Kootenay");
        particleManager = new ParticleManager(ScreenManager.Game);
        if (!particleManager.HasTypeAlready(typeof(ExplosionParticleSystem)))
            particleManager.Register(new ExplosionParticleSystem(ScreenManager.Game, 1));
        particleManager.AddParticleSystem(typeof(ExplosionParticleSystem), new Vector2(235, 55));
        base.LoadContent();
    }

    public override void  HandleInput(InputState input)
    {
        KeyboardState keyboardState = Keyboard.GetState();

        if (keyboardState.IsKeyDown(Keys.Escape))
        {
            ScreenManager.Game.Exit();
        }

        lastState = keyboardState;
        base.HandleInput(input);

    }

    public override void Draw(GameTime gameTime)
    {
        ScreenManager.FadeBackBufferToBlack(TransitionAlpha * 2 / 3);
        Color titleColor = Color.White;
        ScreenManager.GraphicsDevice.Clear(Color.White);
        ScreenManager.SpriteBatch.Begin();
        ScreenManager.SpriteBatch.Draw(texture, new Vector2(0f, 0f),
            new Color(titleColor.R, titleColor.G, titleColor.B, TransitionAlpha));

        particleManager.Draw(ScreenManager.SpriteBatch, gameTime);

        ScreenManager.SpriteBatch.End();
        base.Draw(gameTime);
    }
}