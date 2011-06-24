using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Content;
using System.Collections.Generic;
using System;

namespace Gesture
{
    class Pawn : EnemyBase
    {
        /// <summary>
        /// Copy of the main particle manager.
        /// </summary>
        ParticleManager particleManager;

        /// <summary>
        /// Time elapsed between shots
        /// </summary>
        public float timeToNextFire = 0;

        /// <summary>
        /// Maximum number of bullets drawn at once.
        /// </summary>
        public const int NUM_BULLETS = 1;
        
        /// <summary>
        /// The delay between shots.
        /// </summary>
        public const float FIRE_DELAY = 1.0f;

        /// <summary>
        /// //Used to make the bullet shoot from the enemy.
        /// </summary>
        public int bulletOffset = 0;               


        public Pawn(Game game) : base(game)
        {
            //Initialize attributes            
            List<Texture2D> _normal = new List<Texture2D>();
            _normal.Add(game.Content.Load<Texture2D>("pawn/pawn1"));
            _normal.Add(game.Content.Load<Texture2D>("pawn/pawn2"));
            base.animationList.Add((int)EnemyState.NORMAL, _normal);

            List<Texture2D> _explosion = new List<Texture2D>();
            _explosion.Add(game.Content.Load<Texture2D>("enemyexplosion/enemyexplosion1"));
            _explosion.Add(game.Content.Load<Texture2D>("enemyexplosion/enemyexplosion2"));
            _explosion.Add(game.Content.Load<Texture2D>("enemyexplosion/enemyexplosion3"));
            _explosion.Add(game.Content.Load<Texture2D>("enemyexplosion/enemyexplosion4"));
            base.animationList.Add((int)EnemyState.EXPLOSION, _explosion);

            base.Initialize();
            speed = new Vector2(150f, 150f);
            pointValue = 10;
            isAlive = true;

            position.X = Defines.randomGenerator.Next(MaxX - texture.Width);
            position.Y = Defines.randomGenerator.Next(MaxY - texture.Height);
            health = 1;

            /* Define bounding sphere positions */
            //Middle of ship plus 10 units upward
            int _offset = 5;
            Vector2 topCenter = new Vector2(center.X, center.Y - _offset);
            //Middle of ship plus 10 units downward
            Vector2 bottomCenter = new Vector2(center.Y, center.Y + _offset);

            sphereCenterList.Add(topCenter);
            sphereCenterList.Add(bottomCenter);

            float radius = texture.Width/4;
            InitializeBoundingSpheres(radius);

            //Set up particle systems that we'll use.
            particleManager = Defines.particleManager;
            if (!particleManager.HasTypeAlready(typeof(ExplosionParticleSystem)))
                particleManager.Register(new ExplosionParticleSystem(game, 1));
            if (!particleManager.HasTypeAlready(typeof(ExplosionSmokeParticleSystem)))
                particleManager.Register(new ExplosionSmokeParticleSystem(game, 2));
        
            //Set up the bullets
            for (int i = 0; i < NUM_BULLETS; i++)
                bullets.Add(new EnemyBullet(game));
            bulletOffset = -5;
        
        }

        public override void Update(GameTime gameTime)
        {
            this.UpdateAnimation(gameTime);
            float elapsed = (float)gameTime.ElapsedGameTime.TotalSeconds;

            position.X = position.X + speed.X * elapsed;
            position.Y = position.Y + speed.Y * elapsed;

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

            //Update forward vector so bullets know where to travel
            this.forwardVector = speed;
            this.forwardVector.Normalize();

            //Update bullets
            if (timeToNextFire > 0)
                timeToNextFire = MathHelper.Max(timeToNextFire - (float)gameTime.ElapsedGameTime.TotalSeconds, 0f);
            
            this.Shoot();
            
            //Update bullet positions
            for (int i = 0; i < NUM_BULLETS; i++)
                if (bullets[i].isActive)
                    bullets[i].Update(gameTime);


            base.Update(gameTime);
        }//end Update

        public void Shoot()
        {
            if (timeToNextFire <= 0)
            {
                for (int i = 0; i < NUM_BULLETS; i++)
                {
                    EnemyBullet _currentBullet = bullets[i];

                    if (_currentBullet.isActive == false)
                    {
                        //Let bullet shoot out of the top of the ship
                        _currentBullet.position = new Vector2(position.X + bulletOffset, position.Y);
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

        public override void UpdateAnimation(GameTime gameTime)
        {            
            //Explosion animation
            if (health <= 0)
            {
                //base.currentAnimationID = (int)EnemyState.EXPLOSION;

                Defines.particleManager.AddParticleSystem(typeof(ExplosionParticleSystem), this.position);
                Defines.particleManager.AddParticleSystem(typeof(ExplosionSmokeParticleSystem), this.position);
               
                this.Die();   
            }
            //Normal animation
            else if (health > 0)
            {
                base.currentAnimationID = (int)EnemyState.NORMAL;
            }
            base.UpdateAnimation(gameTime);
        }

        public override void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            //Draw the enemy's bullets
            for (int i = 0; i < NUM_BULLETS; i++)
            {
                //Cache current bullet to prevent constant lookup
                EnemyBullet _currentBullet = bullets[i];
                //Draw bullet to rotate based on player's rotation
                if (_currentBullet.isActive)
                    _currentBullet.Draw(ref spriteBatch, gameTime);
            }

            base.Draw(ref spriteBatch, gameTime);
        }

        /// <summary>
        /// Used to bring the Pawn back to life for practice mode.
        /// Allows us to reuse space to prevent garbage collection.
        /// </summary>
        public override void ResetAttributes()
        {
            position.X = Defines.randomGenerator.Next(MaxX - texture.Width);
            position.Y = Defines.randomGenerator.Next(MaxY - texture.Height);
            base.currentAnimationID = (int)EnemyState.NORMAL;
            base.ResetAttributes();
        }

    }
}
