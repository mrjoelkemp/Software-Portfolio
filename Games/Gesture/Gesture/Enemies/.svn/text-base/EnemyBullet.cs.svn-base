using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework;

namespace Gesture
{
    class EnemyBullet : BulletBase
    {
        /// <summary>
        /// The velocity of the bullet.
        /// </summary>
        public Vector2 velocity;

        public EnemyBullet(Game game) : base(game)
        {
            
            velocity = Vector2.Zero;
            speed = new Vector2(20f, 20f);
            rotation = 0;
            isActive = false;
            position = Vector2.Zero;
            damage = 1;
            texture = game.Content.Load<Texture2D>("bullets/enemybullet1");
            scale = 2;  //Double the texture size
            forwardVector = new Vector2((float)Math.Sin(rotation), (float)Math.Cos(rotation));

            base.Initialize();

            //Set up collision sphere information
            sphereCenterList.Add(new Vector2(center.X, center.Y));
            InitializeBoundingSpheres(texture.Width / 2);

        }

        public new void Update(GameTime gameTime)
        {
            Vector2 _bulletDirection = Vector2.Multiply(forwardVector, speed);
            Vector2 _bulletSpeedOffset = Vector2.Multiply(speed, (float)gameTime.ElapsedGameTime.TotalSeconds);
            //Set the bullet's position as a function of speed and direction.
            Vector2 _newPosition = Vector2.Multiply(_bulletDirection, _bulletSpeedOffset);
            position.X = position.X + _newPosition.X;
            position.Y = position.Y + _newPosition.Y;

            //Boundary checks
            if (position.X < MinX || position.X > MaxX || position.Y < MinY || position.Y > MaxY)
                isActive = false;

            //Update bounding box and other automatic attributes
            base.Update(gameTime);
        }
        
        public new void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            base.Draw(ref spriteBatch, gameTime);
        }
    }
}
