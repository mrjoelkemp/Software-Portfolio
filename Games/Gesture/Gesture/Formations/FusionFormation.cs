using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace Gesture
{
    class FusionFormation
    {

        /// <summary>
        /// Reference to the main game object.
        /// </summary>
        protected Game game;

        /// <summary>
        /// For each player, there will be an appropriate formation with 
        /// positions specific to that player to form the fusion formation.
        /// </summary>
        public Dictionary<PlayerIndex, Formation> playerFormationList;

        /// <summary>
        /// Whether or not the fusion formation is capable of movement.
        /// </summary>
        public bool isMovable;

        /// <summary>
        /// Whether or not the fusion formation is capable of rotation.
        /// </summary>
        public bool isRotatable;

        /// <summary>
        /// Whether or not the fusion formation is active/alive in game.
        /// </summary>
        public bool isAlive;

        /// <summary>
        /// The maximum amount of time the fusion formation lasts.
        /// </summary>
        public float duration;

        /// <summary>
        /// The time that has elapsed since the formation has been triggered.
        /// </summary>
        protected float timeActive;

        /// <summary>
        /// Copy of the fixed point.
        /// Specifies the location of the fusion formation.
        /// </summary>
        protected Vector2 fixedPoint;

        /// <summary>
        /// Holds the animation that is the power for the fusion formation.
        /// TODO: Replace this with a Visual Effects child.
        /// </summary>
        //public AnimatedSprite animatedSprite;

        /// <summary>
        /// Whether or not the fusion particle firing has taken place.
        /// </summary>
        protected bool hasFired;
        /// <summary>
        /// Whether or not the firing (if we've fired) has finished.
        /// </summary>
        protected bool hasFinishedFiring;

        public FusionFormation()
        {
            playerFormationList = new Dictionary<PlayerIndex, Formation>();
            duration = 0;
            timeActive = 0;
            //animatedSprite = new AnimatedSprite();
            isRotatable = false;
            isMovable = true;
            isAlive = true;
            hasFired = false;
            hasFinishedFiring = false;
        }



        public virtual void Update(GameTime gameTime, Vector2 fixedPoint)
        {
        }

        public virtual void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {

        }
    }
}
