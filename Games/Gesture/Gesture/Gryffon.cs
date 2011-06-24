using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace Gesture
{
    /// <summary>
    /// Represents a Gryffon ship that the player controls.
    /// </summary>
    class Gryffon : AnimatedSprite
    {
        /// <summary>
        /// Represents the health of the gryffon ship.
        /// </summary>
        public int health;

        /// <summary>
        /// Values for health points in different states.
        /// Examples: 
        /// If a ship is dead, it has 0 health points.
        /// If a ship is damaged, it has 1 health point.
        /// </summary>
        public enum HealthStateValues
        {
            DEAD,
            DAMAGED,
            NORMAL
        }

        /// <summary>
        /// Speed is a vector to account for speed values particular to axes.
        /// i.e. We might want the speed along the X-axis to be different from 
        ///     the speed along the Y-axis.
        /// </summary>
        public Vector2 speed;

        /// <summary>
        /// Determines if the ship is alive in the game.
        /// </summary>
        public bool isAlive;

        /// <summary>
        /// A list of states that a ship can have.
        /// </summary>
        public enum ShipState
        {
            NORMAL,
            DAMAGED,
            REPAIRING,
            DEAD, 
            EXPLOSION,
            PULSING
        }

        /// <summary>
        /// The current state of the ship.
        /// </summary>
        public ShipState currentShipState;

        //Bullet Attributes
        public List<PlayerBullet> bulletList = new List<PlayerBullet>();
        /// <summary>
        /// Time between shots
        /// </summary>
        public float timeToNextFire;  
        
        /// <summary>
        /// Maximum number of bullets drawn at once.
        /// </summary>
        public const int NUM_BULLETS = 10;
        /// <summary>
        /// The delay between shots.
        /// </summary>
        public const float FIRE_DELAY = 0.1f;
        /// <summary>
        /// //Used to make the bullet shoot from the ship's lazers.
        /// </summary>
        public int bulletOffset = 0;               

        /// <summary>
        /// How long the pulsing animation should run (in seconds).
        /// </summary>
        private float pulsingTimer = 2.0f;
        /// <summary>
        /// How many seconds have already elapsed.
        /// </summary>
        private float pulsingElapsed = 0f;

        public Gryffon(Vector2 position, Game game) : base(game)
        {
            //Load up the textures
            List<Texture2D> _normal = new List<Texture2D>();
            _normal.Add(game.Content.Load<Texture2D>("gryffon/gryffon1"));
            _normal.Add(game.Content.Load<Texture2D>("gryffon/gryffon2"));
            _normal.Add(game.Content.Load<Texture2D>("gryffon/gryffon3"));
            base.animationList.Add((int)ShipState.NORMAL, _normal);

            List<Texture2D> _explosion = new List<Texture2D>();
            _explosion.Add(game.Content.Load<Texture2D>("gryffon/gryffonexplode1"));
            _explosion.Add(game.Content.Load<Texture2D>("gryffon/gryffonexplode2"));
            _explosion.Add(game.Content.Load<Texture2D>("gryffon/gryffonexplode3"));
            _explosion.Add(game.Content.Load<Texture2D>("gryffon/gryffonexplode4"));
            _explosion.Add(game.Content.Load<Texture2D>("gryffon/gryffonexplode5"));
            base.animationList.Add((int)ShipState.EXPLOSION, _explosion);

            List<Texture2D> _pulsing = new List<Texture2D>();
            _pulsing.Add(game.Content.Load<Texture2D>("gryffon/gryffon1"));
            _pulsing.Add(game.Content.Load<Texture2D>("gryffon/pulsing"));
            base.animationList.Add((int)ShipState.PULSING, _pulsing);

            List<Texture2D> _damaged = new List<Texture2D>();
            _damaged.Add(game.Content.Load<Texture2D>("gryffon/damaged1"));
            _damaged.Add(game.Content.Load<Texture2D>("gryffon/damaged2"));
            _damaged.Add(game.Content.Load<Texture2D>("gryffon/damaged3"));
            base.animationList.Add((int)ShipState.DAMAGED, _damaged);

            base.Initialize();

            for (int i = 0; i < NUM_BULLETS; i++)
                bulletList.Add(new PlayerBullet(game));
            
            timeToNextFire = 0;
            speed = new Vector2(1f, 1f);
            health = (int)HealthStateValues.NORMAL;
            isAlive = true;
            position = new Vector2(Defines.clientBounds.Width/2, Defines.clientBounds.Height);
            //Add the incoming initial position to your own
            this.position = position;

            currentShipState = ShipState.NORMAL;
            
            /* Set up collision spheres. */
            int _offset = 10;   //Pixel offset to evenly space spheres.
            //Top Center
            sphereCenterList.Add(new Vector2(center.X, center.Y + _offset));
            //Bottom Center
            sphereCenterList.Add(new Vector2(center.X, center.Y - _offset));
            //Left Center
            sphereCenterList.Add(new Vector2(center.X - _offset, center.Y));
            //Right Center
            sphereCenterList.Add(new Vector2(center.X + _offset, center.Y));
            InitializeBoundingSpheres(texture.Width / 4);
        }

        public override void Update(GameTime gameTime)
        {
            //Update sprite animation
            UpdateAnimation(gameTime);

            //Update player bullet positions
            for (int i = 0; i < NUM_BULLETS; i++)
                if (bulletList[i].isActive)
                    bulletList[i].Update(gameTime);

            //Decrease the shoot countdown timer
            if (timeToNextFire > 0)
                timeToNextFire = MathHelper.Max(timeToNextFire - (float)gameTime.ElapsedGameTime.TotalSeconds, 0f);
   
            base.Update(gameTime);
        }
             
        /// <summary>
        /// Initialize a ship's bullet for drawing.
        /// </summary>
        public void Shoot()
        {
            if (timeToNextFire <= 0)
            {
                for (int i = 0; i < NUM_BULLETS; i++)
                {
                    PlayerBullet _currentBullet = bulletList[i];
                    
                    if (_currentBullet.isActive == false)
                    {
                        //Let bullet shoot out of the top of the ship
                        Vector2 _newPos = new Vector2();
                        _newPos.X = position.X + bulletOffset;
                        _newPos.Y = position.Y;

                        _currentBullet.position =  _newPos;
                        _currentBullet.rotation = rotation;
                        _currentBullet.forwardVector = forwardVector;
                        _currentBullet.isActive = true;
                        break;
                    }
                }
                
                //Start the countdown timer
                timeToNextFire = FIRE_DELAY;
            }            
        }

        public void UpdateAnimation(GameTime gameTime)
        {            

            //Explosion animation
            if (health <= (int)HealthStateValues.DEAD)
            {
                //If the animation is the Normal
                if (base.currentAnimationID == (int)ShipState.NORMAL || 
                    base.currentAnimationID == (int)ShipState.DAMAGED)
                {
                    //Switch the animation to the explosion animation
                    base.currentAnimationID = (int)ShipState.EXPLOSION;
                   
                }
                //If the explosion animation has finished
                if (isAnimationDone((int)ShipState.EXPLOSION))
                {
                    //Switch the animation to the pulsing animation
                    base.currentAnimationID = (int)ShipState.PULSING;                    
                }
                //If we're in the pulsing state 
                if (base.currentAnimationID == (int)ShipState.PULSING)
                {
                    pulsingElapsed += (float)gameTime.ElapsedGameTime.TotalSeconds;
                    if (pulsingElapsed >= pulsingTimer)
                    {
                        base.currentAnimationID = (int)ShipState.NORMAL;
                        isAlive = true;
                        health = 1;
                        pulsingElapsed = 0;
                    }
                }
            }            
            //Normal animation
            else if (health >= (int)HealthStateValues.NORMAL)
            {
                base.currentAnimationID = (int)ShipState.NORMAL;
            }
            //Damaged Animation
            else if (health == (int)HealthStateValues.DAMAGED)
            {
                base.currentAnimationID = (int)ShipState.DAMAGED;
            }

            //Set the current state of the ship to the current animation
            currentShipState = (ShipState)base.currentAnimationID;
        }

        public override void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            //Draw the player's bullets
            for (int i = 0; i < NUM_BULLETS; i++)
            {
                //Cache current bullet to prevent constant lookup
                PlayerBullet _currentBullet = bulletList[i];
                //Draw bullet to rotate based on player's rotation
                if (_currentBullet.isActive)
                    _currentBullet.Draw(ref spriteBatch, gameTime);
            }

            int _bulletCount = 0;
            //Draw player statistics
            for (int i = 0; i < NUM_BULLETS; i++)
                if (bulletList[i].isActive)
                    _bulletCount++;

            //TODO: Change this to write to the ConsoleComponent
            //spriteBatch.DrawString(Defines.spriteFontKootenay, "Active Bullet Count: " + _bulletCount, new Vector2(0, 300), Defines.textColor);


            base.Draw(ref spriteBatch, gameTime);
        }
    }
}
