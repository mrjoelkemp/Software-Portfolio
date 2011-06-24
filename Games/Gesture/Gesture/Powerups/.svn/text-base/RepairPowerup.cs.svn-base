using Microsoft.Xna.Framework;
using System.Collections.Generic;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;

namespace Gesture
{
    class RepairPowerup : AnimatedSprite
    {
        /// <summary>
        /// How long the powerup should stay active.
        /// </summary>
        public int duration;

        /// <summary>
        /// How long the powerup has been alive.
        /// </summary>
        private float timeAlive = 0;

        /// <summary>
        /// Whether or not the powerup is alive.
        /// </summary>
        public bool isAlive;

        /// <summary>
        /// The speed at which the powerup travels.
        /// </summary>
        public Vector2 speed;

        /// <summary>
        /// The number of times the 'A' Button must be pressed for repair charge to take place
        /// </summary>
        public static int repairCharge;

        /// <summary>
        /// Controls whether if the repair sequence is in effect
        /// </summary>
        public static bool repairModeEnabled;

        public bool rechargeModeEnabled;

        public static bool enterRepairMode;
        static bool buttonHeldDown_A;

        static Player currentPlayer;

        static string status;
        
        /// <summary>
        /// Time delay till another repair power up appears
        /// </summary>
        public int delay;
        
        
        public RepairPowerup(Game game) : base(game)
        {
            List<Texture2D> _normal = new List<Texture2D>();
            _normal.Add(game.Content.Load<Texture2D>("powerups/repair"));
            base.animationList.Add(0, _normal);

            buttonHeldDown_A = false;

            status = "";

            // 3 second delay time
            delay = 3;

            //5 Seconds
            duration = 5;

            isAlive = true;

            // 20 button presses 
            repairCharge = 20;

            speed = new Vector2(100f, 100f);

            enterRepairMode = false;
            rechargeModeEnabled = false;

            base.Initialize();
        }

        public override void Update(GameTime gameTime)
        {
            movement(gameTime);            
            base.Update(gameTime);
        }

        public void movement(GameTime gameTime)
        {
            position += speed * (float)gameTime.ElapsedGameTime.TotalSeconds;
            timeAlive = (float)gameTime.ElapsedGameTime.TotalSeconds;

            //Boundary Checks (bounce)
            if (position.X >= MaxX)
            {
                speed.X *= -1;
                position.X = MaxX;
            }

            else if (position.X <= MinX)
            {
                speed.X *= -1;
                position.X = MinX;
            }

            if (position.Y >= MaxY)
            {
                speed.Y *= -1;
                position.Y = MaxY;
            }

            else if (position.Y <= MinY)
            {
                speed.Y *= -1;
                position.Y = MinY;
            }

            if (timeAlive >= (float)duration)
            {
                this.isAlive = false;
            }
        }

        public override void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            if (!enterRepairMode && !repairModeEnabled && !rechargeModeEnabled)
                base.Draw(ref spriteBatch, gameTime);
            else
            {
                // For some reason, this only works when placed in Draw() function and not in Update()
                // function...where it belongs
                checkInput(gameTime, currentPlayer);

                // Display the current message to screen
                spriteBatch.DrawString(Defines.spriteFontKootenay, status, new Vector2(0, 350), Defines.textColor);
            }
        }

        public static void sequence(RepairPowerup powerup, ref Player player)
        {
            // Prevent us from restarting the sequence
            if (!enterRepairMode && !repairModeEnabled && !powerup.rechargeModeEnabled)
                enterRepairMode = true;

            currentPlayer = player;
        }

        public void checkInput(GameTime gameTime, Player player)
        {

            float _timeLeft = delay - (float)gameTime.TotalGameTime.TotalSeconds;
            GamePadState _currentAction = GamePad.GetState(player.playerIndex);

            // Display message to enter repair mode

            if (enterRepairMode)
            {
                if (_currentAction.ThumbSticks.Right.X != 0 || _currentAction.ThumbSticks.Right.Y != 0)
                {
                    enterRepairMode = false;
                    repairModeEnabled = true;
                }
                else
                    status = "Hit the right analog stick in any direction to enter repair mode!!";
            }

            // Repair mode entered
            else if (repairModeEnabled)
            {
                if (repairCharge > 0)
                {
                    // Check 'A' button state
                    if (_currentAction.IsButtonDown(Buttons.A) && !buttonHeldDown_A)
                    {
                        buttonHeldDown_A = true;
                        repairCharge--;
                    }
                    else if (_currentAction.IsButtonUp(Buttons.A) && buttonHeldDown_A)
                        buttonHeldDown_A = false;

                    status = "Push the 'A' Button " + repairCharge + " more times!!";
                }
                else
                {
                    repairModeEnabled = false;
                    rechargeModeEnabled = true;

                    // Keep delay value updated for when Repair Mode ends
                    delay = (int)gameTime.TotalGameTime.TotalSeconds + duration;

                    // Show "explosive" recovery!
                    //GameplayScreen.particleManager.AddParticleSystem(ParticleSystem, player.shipManager.formationManager.globalFixedPoint);
                }
            }

            // Repair complete, recharge mode start
            else if (rechargeModeEnabled)
            {
                if (_timeLeft > 0)
                    status = "Time till Next Power Up:  " + _timeLeft.ToString("N2");
                else
                {
                    this.isActive = true;
                    rechargeModeEnabled = false;
                    status = "";
                    repairCharge = 20;
                    timeAlive = 0;
                }
            }
        }
    }
}
