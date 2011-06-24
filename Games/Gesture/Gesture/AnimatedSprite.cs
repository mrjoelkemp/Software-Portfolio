using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework;

namespace Gesture
{
    class AnimatedSprite : Sprite
    {
        /// <summary>
        /// Holds a list of animations, indexed by an integer ID.
        /// This allows us to define a new type of animation by passing
        /// in an ID and a list of textures for that animation.
        /// 
        /// This makes it easy for us to switch between texture lists.
        /// 
        /// Example: To support Explosion Animation
        /// animationList.Add(Explosion Animation ID, List_of_Textures)
        /// </summary>
        public Dictionary<int, List<Texture2D>> animationList;
        
        /// <summary>
        /// The current frame in the animation. 
        /// </summary>
        public int currentFrame;

        /// <summary>
        /// Elapsed time counters.
        /// </summary>
        public int timeSinceLastFrame;
        public int timeToChangeFrame;

        /// <summary>
        /// Keeps track of the previous animation type to tell when
        /// animations are being switched.
        /// </summary>
        private int previousAnimationID;
        /// <summary>
        /// Keeps track of the current type of animation to render.
        /// </summary>
        public int currentAnimationID;


        public AnimatedSprite(Game game) : base(game)
        {
            animationList = new Dictionary<int, List<Texture2D>>();
            currentFrame = 0;
            timeSinceLastFrame = 0;
            timeToChangeFrame = 5;          //change a frame every 2 updates
            previousAnimationID = 0;
            currentAnimationID = 0;
            
        }

        /// <summary>
        /// Sets the current sprite and calls its
        /// initialize function.
        /// </summary>
        public new void Initialize()
        {
            List<Texture2D> textureList = animationList[currentAnimationID];
            if (textureList.Count > 0)
            {
                base.texture = textureList[currentFrame];
            }
            base.Initialize();
        }

        /// <summary>
        /// Updates the current frame in the animation
        /// </summary>
        /// <param name="gameTime"></param>
        public virtual new void Update(GameTime gameTime)
        {
            UpdateAnimation(gameTime);
            base.Update(gameTime);
        }

        /// <summary>
        /// Updates the frame according to the currently set animation type.
        /// </summary>
        /// <param name="gameTime">Game's time.</param>
        private void UpdateAnimation(GameTime gameTime)
        {
            //Update the time since the last frame
            //NOTE: We multiply by 100 to get the elapsed game time into whole numbers.
            double _elapsed = 100 * gameTime.ElapsedGameTime.TotalSeconds;
            timeSinceLastFrame += (int)_elapsed;

            //If we've changed animations
            if (previousAnimationID != currentAnimationID)
            {
                //Reset the current frame counter
                currentFrame = 0;
                //Remember the type before we change it
                previousAnimationID = currentAnimationID;
            }
            //Otherwise, we're not changing animations
            else
            {
                //If it's time to change the frame
                if (timeSinceLastFrame >= timeToChangeFrame)
                {   
                    //Switch to the next frame (keep it within the range 0 - last frame for current animation.
                    currentFrame = (currentFrame + 1) % animationList[currentAnimationID].Count;
                    timeSinceLastFrame = 0;
                }

            }

            //Update the currentSprite variable
            //Note: We update the sprite after checking for cycling to prevent segmentation fault.
            UpdateCurrentSprite();  
            
        }

        /// <summary>
        /// Updates the current sprite based on the current frame 
        /// in the current animation.
        /// </summary>
        private void UpdateCurrentSprite()
        {
            base.texture = animationList[currentAnimationID][currentFrame];
        }

        /// <summary>
        /// Used to keep track of when the animation has hit the last
        /// frame. This is useful for an animations that might
        /// trigger another animation.
        /// </summary>
        public bool isAnimationDone(int animID)
        {
            //If the animation in question is the current animation
            if (currentAnimationID == animID)
            {
                //Get the list of textures for this animation
                List<Texture2D> textureList = animationList[animID];

                //Check if the current frame is equal to the last
                //Note: currentFrame goes from 0 -> textureList.Count - 1 because of modulus
                if (currentFrame == textureList.Count - 1)
                    return true;
            }

            return false;
        }

        /// <summary>
        /// Draws the current sprite of the current animation.
        /// </summary>
        /// <param name="spriteBatch"></param>
        /// <param name="gameTime"></param>
        public virtual new void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            base.Draw(ref spriteBatch, gameTime);
        }

        #region Accessors
   /*
        public void SetPosition(Vector2 pos)
        {
            currentSprite.position = pos;
        }
        public void SetRotation(float rotation)
        {
            currentSprite.rotation = rotation;
        }

        public Vector2 GetPosition()
        {
            return currentSprite.position;
        }
        public float GetRotation()
        {
            return currentSprite.rotation;
        }
        public Vector2 GetForwardVector()
        {
            return currentSprite.forwardVector;
        }
        public Vector2 GetCenter()
        {
            return currentSprite.center;
        }
 */   
        #endregion

    }
}
