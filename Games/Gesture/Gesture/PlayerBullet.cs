using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Content;
using System;

namespace Gesture
{
    class PlayerBullet : BulletBase
    {
        /// <summary>
        /// Constructor for the playerbullet class.
        /// </summary>
        /// <param name="content"></param>
        public PlayerBullet(Game game) : base(game)
        {            
            texture = game.Content.Load<Texture2D>("bullets/gryffonlaser");
            damage = 1;
            speed = new Vector2(35f, 35f);
            position = Vector2.Zero;
            rotation = 0f;
            isActive = false;
            forwardVector = new Vector2((float)Math.Sin(rotation) * 8, (float)Math.Cos(rotation) * -8);

            //Set up other necessary sprite attributes.
            base.Initialize();

            //Set up collision sphere information
            sphereCenterList.Add(new Vector2(center.X, center.Y));
            InitializeBoundingSpheres(texture.Width / 2);
        }

        public new void Update(GameTime gameTime)
        {
            Vector2 _bulletDirection = new Vector2();
            Vector2.Multiply(ref forwardVector, ref speed, out _bulletDirection);

            Vector2 _bulletSpeedOffset = new Vector2();
            Vector2.Multiply(ref speed, (float)gameTime.ElapsedGameTime.TotalSeconds, out _bulletSpeedOffset);
            
            //Set the bullet's position as a function of speed and direction.
            Vector2 _newPosition = new Vector2();
            Vector2.Multiply(ref _bulletDirection, ref _bulletSpeedOffset, out _newPosition);

            position.X += _newPosition.X;
            position.Y += _newPosition.Y;

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
