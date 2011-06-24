using System;
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
    /// <summary>
    /// This is the main type for your game
    /// </summary>
    public class Gesture : Microsoft.Xna.Framework.Game
    {
        public static GraphicsDeviceManager graphics;
        public SpriteBatch spriteBatch;


        /// <summary>
        /// Font used to draw text to the screen.
        /// </summary>
        public static SpriteFont spriteFont;
        /// <summary>
        /// A universal color for drawing text.
        /// This allows us to change the color across the entire
        /// system and not in individual modules/classes.
        /// </summary>
        public static Color textColor = Color.White;

        /// <summary>
        /// Random number generator used to generate initial pawn positions
        /// </summary>
        public static Random randomGenerator = new Random();
        
        /// <summary>
        /// Controls the addition and rendering of particle systems.
        /// </summary>
        public static ParticleManager particleManager;

        //public static ConsoleComponent consoleComponent;

        PlayerManager playerManager;
        SpriteManager enemySpriteManager;

        ChargeBar chargeBar;
        RepairPowerup repairPowerup;

        BloomComponent bloomComponent;

        // Assume that two-player mode is enabled
        public static bool twoPlayerMode = true;

        //Constants
        const int NUM_ENEMIES = 20;


        public Gesture()
        {
            graphics = new GraphicsDeviceManager(this);
            graphics.PreferredBackBufferWidth = 1280;
            graphics.PreferredBackBufferHeight = 720;
            graphics.SynchronizeWithVerticalRetrace = true;

            Content.RootDirectory = "Content";
        }

        protected override void Initialize()
        {
            Defines.clientBounds = this.Window.ClientBounds;
            //Set up the frames counter
            this.Components.Add(new FPSComponent(this));
            
            //Set up the bloom post-process effect
            bloomComponent = new BloomComponent(this);
            bloomComponent.Visible = false;
            this.Components.Add(bloomComponent);

            //Set up the console writer.
            //consoleComponent = new ConsoleComponent(clientBounds);

            //Set up the sprite managers
            //playerSpriteManager = new SpriteManagerComponent(this);
            enemySpriteManager = new SpriteManager(this);

            //Set up the players
            //TODO: Only signed in players should be added.
            playerManager = new PlayerManager(this);
           
            // Check whether if two controllers are currently active (Comment to default to two-player mode)
            // TODO: Add additional check for if the game is currently running or not
            //if (!GamePad.GetState(PlayerIndex.Two).IsConnected)
            //    twoPlayerMode = false;

            // Set up the charge Bar
            chargeBar = new ChargeBar(this);

            // Set up repair powerup
            repairPowerup = new RepairPowerup(this);

            //Set up the particle system manager.
            particleManager = new ParticleManager(this);

            base.Initialize();
        }

        protected override void LoadContent()
        {
            spriteBatch = new SpriteBatch(GraphicsDevice);
            spriteFont = Content.Load<SpriteFont>("fonts/Kootenay");
                
            //Load up the players based on connected controllers
            for (int i = 0; i < 4; i++)
                if (GamePad.GetState((PlayerIndex)i).IsConnected)
                    playerManager.AddPlayer((PlayerIndex)i);

            //If there are no connected controllers
            if (playerManager.playerList.Count == 0)
            {
                //Still add Player 1 -- he'll use the keyboard!
                playerManager.AddPlayer(PlayerIndex.One);
            }

            //Load enemies and their initial attributes
            for (int i = 0; i < NUM_ENEMIES; i++)
                //Add the enemy to the sprite manager
                enemySpriteManager.spriteList.Add(new Pawn(this));
        }

        /// <summary>
        /// UnloadContent will be called once per game and is the place to unload
        /// all content.
        /// </summary>
        protected override void UnloadContent()
        {
            Content.Unload();
            base.UnloadContent();
        }

        protected override void Update(GameTime gameTime)
        {
            playerManager.Update(gameTime);
            enemySpriteManager.Update(gameTime);
            chargeBar.Update(gameTime);
            //repairPowerup.Update(gameTime);

            //Debug
            if (GamePad.GetState(PlayerIndex.One).Buttons.LeftStick == ButtonState.Pressed)
            {
                //Reset the pawn manager to redisplay all of the pawns
                foreach (Pawn p in enemySpriteManager.spriteList)
                    p.ResetAttributes();
            }

            // Check collision status for players
            for (int i = 0; i < playerManager.playerList.Count; i++)
                if(playerManager.playerList[i].isPlayerActive)
                    checkCollision(playerManager.playerList[i]);

            base.Update(gameTime);
        }

        private void checkCollision(Player currentPlayer)
        {
            //Check for collisions            
            for (int j = 0; j < currentPlayer.shipManager.shipList.Count; j++)
            {
                //Cache current player
                Gryffon _currentShip = currentPlayer.shipManager.shipList[j];
                // When ships can become damaged, uncomment line below 
                // if (Collision.PlayerWithPowerup(_currentShip, repairPowerup) && _currentShip.health == (int)Gryffon.HealthStateValues.DAMAGED)
                //if (Collision.PlayerWithPowerup(_currentShip, repairPowerup))
                  //  RepairPowerup.sequence();

                int _playerNumBullets = _currentShip.bulletList.Count;
                for (int i = 0; i < _playerNumBullets; i++)
                {
                    //Cache bullet
                    PlayerBullet _currentBullet = _currentShip.bulletList[i];
                    if (_currentBullet.isActive)
                        for (int k = 0; k < NUM_ENEMIES; k++)
                        {
                            //Cache enemy
                            Pawn _currentPawn = (Pawn)enemySpriteManager.spriteList[k];
                            if (_currentPawn.isAlive && Collision.PlayerBulletWithEnemy(_currentBullet, _currentPawn))
                            {
                                _currentPawn.DecreaseHealth(_currentBullet.damage);
                                _currentBullet.isActive = false;
                                currentPlayer.score += _currentPawn.pointValue;
                                //Pawn is no longer able to take damage
                                _currentPawn.isAlive = false;

                                // Add some charge to the charge bar
                                ChargeBar.addCharge();
                                break;         
                            }
                        }
                }
            }
        }




        protected override void Draw(GameTime gameTime)
        {
            graphics.GraphicsDevice.Clear(Color.Black);

            //Draw what's not taken care of by the sprite manager.
            spriteBatch.Begin(SpriteBlendMode.AlphaBlend);

            //playerSpriteManager.Draw(ref spriteBatch, gameTime);
            //player1.Draw(ref spriteBatch, gameTime);
            playerManager.Draw(ref spriteBatch, gameTime);
               
            enemySpriteManager.Draw(ref spriteBatch, gameTime);

            // Draw the charge bar
            chargeBar.Draw(ref spriteBatch, gameTime);

            // Draw the repair power up
            repairPowerup.Draw(ref spriteBatch, gameTime);

            //Draw particle system information
            particleManager.Draw(ref spriteBatch, gameTime);

            //Draw game time
            spriteBatch.DrawString(spriteFont, "Time", new Vector2(Defines.clientBounds.Width / 2 - 10, 0), textColor);
            spriteBatch.DrawString(spriteFont, gameTime.TotalGameTime.Minutes + ":" + gameTime.TotalGameTime.Seconds.ToString("00"), new Vector2(Defines.clientBounds.Width / 2, 20), textColor);

            
            //Print some stats from the enemy manager
            enemySpriteManager.ShowStats(ref spriteBatch);

            //Draw the global gestures and fusio mode flags for each player
            for (int i = 0; i < Defines.playersGestures.Count; i++)
            {
                spriteBatch.DrawString(spriteFont, "Player " + i + " Gesture: " + Defines.playersGestures[(PlayerIndex)i].ToString(),
                    new Vector2(Defines.clientBounds.Right - 400, (i + 1) * 20), textColor);
                
                spriteBatch.DrawString(spriteFont, "Player " + i + " Fusion Mode: " + Defines.playerFusionTriggered[(PlayerIndex)i].ToString(),
                   new Vector2(Defines.clientBounds.Right - 400, (i + 1) * 40), textColor);
                
            }
            spriteBatch.End();

            base.Draw(gameTime);
        }
    }
}
