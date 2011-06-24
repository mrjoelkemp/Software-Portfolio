using System;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework;
using System.Collections.Generic;

namespace Gesture
{
    class Sprite
    {
        /// <summary>
        /// Local copy of the main game object.
        /// </summary>
        Game game;

        /// <summary>
        /// The color to draw the texture pixels.
        /// This allows us to easily change the color of the sprite.
        /// </summary>
        public Color color;

        /// <summary>
        /// Texture to be rendered.
        /// </summary>
        public Texture2D texture;

        /// <summary>
        /// Rotation (in radians) of the sprite.
        /// </summary>
        public float rotation;

        /// <summary>
        /// Position in 2D Space.
        /// </summary>
        public Vector2 position;

        /// <summary>
        /// Determines the forward direction of the sprite.
        /// </summary>
        public Vector2 forwardVector;

        /// <summary>
        /// The center of the sprite's texture.
        /// </summary>
        public Vector2 center;

        /// <summary>
        /// Used to rotate the sprite about a certain point.
        /// </summary>
        public Vector2 rotationFixedPoint;
        public float rotationAboutFixedPoint;

        /// <summary>
        /// Used to specify that the sprite should rotate about the
        /// rotationOrigin point.
        /// </summary>
        public bool rotateAboutFixedPoint;

        /// <summary>
        /// Used to scale the sprite.
        /// </summary>
        public float scale;

        /// <summary>
        /// Used to determine the bounding rectangle for a texture.
        /// </summary>
        public BoundingBox boundingBox;
        
        /// <summary>
        /// A list of spheres that are used to detect collision between sprites.
        /// </summary>
        public List<BoundingSphere> boundingSphereList;

        /// <summary>
        /// Sphere that bounds the entire texture.
        /// Used for collision with client bounds and for 
        /// generalized (not fine-tuned with sphere list) collision detection.
        /// </summary>
        public BoundingSphere generalBoundingSphere;

        /// <summary>
        /// Keeps track of the positions of the spheres about a texture.
        /// </summary>
        public List<Vector2> sphereCenterList;

        /// <summary>
        /// Keeps track of whether we should draw the collision
        /// bounding spheres.
        /// </summary>
        public bool drawBoundingSpheres;

        /// <summary>
        /// Controls whether we use a Bounding Box or Sphere for collision.
        /// Default is Bounding Sphere.
        /// </summary>
        public bool useBoundingBox;

        /// <summary>
        /// Contains the texture's color information. 
        /// Used in per-pixel collision detection.
        /// </summary>
        public Color[] textureColorData;

        /// <summary>
        /// Controls whether or not we use per-pixel or bounding volume collision.
        /// </summary>
        public bool usePerPixelCollision;
        
        /// <summary>
        /// Used to determine if the sprite should be updated and drawn.
        /// </summary>
        public bool isActive;
        
        /// <summary>
        /// Boundary variables.
        /// Some sprites need to know their bounds within the viewport.
        /// </summary>
        public int MaxX, MaxY, MinX, MinY;
        
        public Sprite(Game game)
        {
            scale = 1f;
            isActive = true;
            color = Color.White;
            useBoundingBox = true;
            usePerPixelCollision = false;
            rotation = 0f;
            rotateAboutFixedPoint = false;
            center = Vector2.Zero;
            forwardVector = Vector2.Zero;
            MaxX = 0;
            MaxY = 0;
            MinX = 0;
            MinY = 0;
            sphereCenterList = new List<Vector2>();
            drawBoundingSpheres = false;

            this.game = game;
        }
            
        /// <summary>
        /// Constructor allowing you to load the texture from a passed
        /// filename and also call the default constructor to initialize
        /// the sprite attributes.
        /// </summary>
        /// <param name="game"></param>
        /// <param name="assetName"></param>
        public Sprite(Game game, string assetName)
        {
            //Load the texture based on the given assetname
            texture = game.Content.Load<Texture2D>(assetName);
            
        }

        /// <summary>
        /// Called after the child's members have been initialized.
        /// Takes care of all the routine attribute setting.
        /// </summary>
        public void Initialize()
        {
            //Set up the sprite's center.
            center.X = texture.Width / 2;
            center.Y = texture.Height / 2;
            //By default, the sprite rotates about its center
            rotationFixedPoint = center;

            //Set up boundary variables
            //NOTE: We use the center as the offset because the rotation is about the center of the sprite.
            MaxX = Defines.clientBounds.Width - (int)center.X;
            MinX = (int)center.X;
            MaxY = Defines.clientBounds.Height - (int)center.Y;
            MinY = (int)center.Y;

            if (usePerPixelCollision)
            {
                //Set up texture data for collision
                textureColorData = new Color[texture.Width * texture.Height];
                texture.GetData(textureColorData);
            }

        }

        /// <summary>
        /// Intializes a list of bounding spheres for collision detection.
        /// </summary>
        /// <param name="radius">The radius of the circles. Allows us to tweak the sphere for a better
        /// fit.</param>
        public void InitializeBoundingSpheres(float radius)
        {
            //We are using sphere collision detection
            useBoundingBox = false;

            //Create the list
            boundingSphereList = new List<BoundingSphere>();
            if (sphereCenterList.Count > 0)
            {
                for (int i = 0; i < sphereCenterList.Count; i++)
                {
                    BoundingSphere _newSphere = new BoundingSphere();
                    //Translates the 2d position into 3d. We just set the Z-axis to zero.
                    Vector3 _position = new Vector3(sphereCenterList[i].X, sphereCenterList[i].Y, 0);
                    _newSphere.Center = _position;
                    _newSphere.Radius = radius;

                    boundingSphereList.Add(_newSphere);
                }
            }

            //Initialize the general bounding sphere to cover the entire texture
            float _rad = texture.Width / 2;
            generalBoundingSphere = new BoundingSphere(new Vector3(position.X, position.Y, 0), _rad);
        }

        public void Update(GameTime gameTime)
        {
            //Compute position about rotation origin
            if (rotateAboutFixedPoint)
            {
                Matrix matrix = Matrix.CreateRotationZ(rotationAboutFixedPoint);
                
                Vector2 _modPos = new Vector2();
                _modPos.X = position.X - rotationFixedPoint.X;
                _modPos.Y = position.Y - rotationFixedPoint.Y;

                Vector2 _rotatedVector = new Vector2();
                Vector2.Transform(ref _modPos, ref matrix, out _rotatedVector);

                this.position.X = _rotatedVector.X + rotationFixedPoint.X;
                this.position.Y = _rotatedVector.Y + rotationFixedPoint.Y;
            }

            //Update bounding box automatically
            if(useBoundingBox) 
                UpdateBoundingBox();
            else 
                UpdateBoundingSpheres();
        }


        /// <summary>
        /// Simple function to update a bounding box for sprite movement.
        /// Note: We must recreate the bounding box object every single time. 
        /// XNA doesn't allow us to change the position of the bounding box.
        /// </summary>
        public void UpdateBoundingBox()
        {
            //Top left corner of the sprite.
            Vector3 min = new Vector3((int)position.X, (int)position.Y, 0);
            //Bottom right corner of the sprite
            Vector3 max = new Vector3((int)position.X + texture.Width, (int)position.Y + texture.Height, 0);
            boundingBox = new BoundingBox(min, max);

        }

        /// <summary>
        /// Updates the center of the sphere bounding the sprite.
        /// 
        /// Notes: 
        /// 
        /// Radius doesn't need to be updated.
        /// 
        /// When we recreate the bounding spheres, we want to remember
        /// where we initially created them about the texture. If we simply
        /// update the position to the sprite's current position, then we lose
        /// that positioning information. The local variable _offset attempts
        /// to retain that positioning information.
        /// </summary>
        public void UpdateBoundingSpheres()
        {
            //Update spheres for fine-tuned collision detection
            for (int i = 0; i < boundingSphereList.Count; i++)
            {
                Vector3 _oldPos = boundingSphereList[i].Center;
                Vector3 _newPos = new Vector3();

                _newPos.X = (position.X - center.X) + sphereCenterList[i].X;
                _newPos.Y = (position.Y - center.Y) + sphereCenterList[i].Y;
                _newPos.Z = 0;
                boundingSphereList[i] = boundingSphereList[i].Transform(Matrix.CreateTranslation(_newPos - _oldPos));
            }

            //Update the general bounding sphere
            Vector3 _opos = generalBoundingSphere.Center;
            Vector3 _npos = new Vector3();
            _npos.X = position.X;
            _npos.Y = position.Y;
            _npos.Z = 0;
            generalBoundingSphere = generalBoundingSphere.Transform(Matrix.CreateTranslation(_npos - _opos));
        }
        
        /// <summary>
        /// Default drawing method that takes into account rotation, translation, and scale.
        /// </summary>
        /// <param name="gameTime"></param>
        public void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        { 
            spriteBatch.Draw(texture,
                    position,
                    null,
                    color,
                    rotation,
                    center,
                    scale,
                    SpriteEffects.None,
                    0f);

            //Draw the bounding spheres
            if(!useBoundingBox && drawBoundingSpheres)
            {
                foreach (BoundingSphere b in boundingSphereList)
                {
                    PrimitiveLine brush = new PrimitiveLine(game.GraphicsDevice);
                    //Create a circle (from 100 lines) with the radius
                    brush.CreateCircle(b.Radius, 100);
                    brush.Position = new Vector2(b.Center.X, b.Center.Y);
                    brush.Render(ref spriteBatch);
                }
                
                PrimitiveLine br = new PrimitiveLine(game.GraphicsDevice);
                //Create a circle (from 100 lines) with the radius
                br.CreateCircle(generalBoundingSphere.Radius, 100);
                br.Position = new Vector2(generalBoundingSphere.Center.X, generalBoundingSphere.Center.Y);
                br.Render(ref spriteBatch);
            }
        }


    }

}
