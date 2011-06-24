using System;
using Microsoft.Xna.Framework;
using System.Collections.Generic;
using Microsoft.Xna.Framework.Graphics;

namespace Gesture
{
    /// <summary>
    /// Represents a formation assumed by a set of objects.
    /// </summary>
    class Formation
    {
        /// <summary>
        /// Used to identify the formation. ID assumes a value from the
        /// global list of formation (Normal fire, V fire, etc)
        /// identifiers (found in Defines.cs)
        /// </summary>
        public Defines.GESTURES ID;

        /// <summary>
        /// The central point for the formation. 
        /// Formations are defined about the fixed point.
        /// </summary>
        public Vector2 fixedPoint;

        /// <summary>
        /// A list of positions that define where ships should 
        /// be placed for a given formation.
        /// </summary>
        public List<Vector2> positionList;
        /// <summary>
        /// A list of rotations that define the direction that ships
        /// should face in the formation.
        /// </summary>
        public List<float> rotationList;
        /// <summary>
        /// Used for visual effects in fusion gestures!
        /// </summary>
        AnimatedSprite animatedSprite;

        /// <summary>
        /// Dictates the minimum number of ships necessary to
        /// trigger this formation.
        /// </summary>
        public int minimumShipCount;

        /// <summary>
        /// Used to check if the number of ships in the formation have changed.
        /// </summary>
        public int currentNumberOfShips;

        /// <summary>
        /// Controlles which player can activate this gesture.
        /// Fusion Gestures alter formations for each player; so
        /// we need to know which player is trying to use this formation.
        /// </summary>
        public PlayerIndex playerIndex;
        
        /// <summary>
        /// Determines if both players can use this formation.
        /// This is useful when we don't want to set the playerIndex to just
        /// a single player.
        /// </summary>
        public bool usedByBothPlayers;

        /// <summary>
        /// A defined distance that separates the ships.
        /// </summary>
        public int shipOffset;

        /// <summary>
        /// How long the ships take to get into formation.
        /// </summary>
        public TimeSpan delay;

        /// <summary>
        /// Whether or not players can move in this formation.
        /// This allows Fusion formations to disable movement, if necessary.
        /// </summary>
        public bool isMovable;

        public Formation()
        {
            //animatedSprite = new AnimatedSprite();
            rotationList = new List<float>();
            positionList = new List<Vector2>();
            fixedPoint = new Vector2();
            //Formation takes 2 seconds for ships to assume positions.
            delay = TimeSpan.FromSeconds(5);

            //Defaulted to player 1
            playerIndex = PlayerIndex.One;
            //Formation can be used by any player by default
            usedByBothPlayers = true;
            isMovable = true;
        }

        /// <summary>
        /// Updates the formation's position and rotation list based on 
        /// the number of ships passed in.
        /// 
        /// This allows us to revise formations in case ships are lost.
        /// We also need the location of the global fixed point so that
        /// our formation positions change accoringly.
        /// </summary>
        /// <param name="numShips">Current number of ships that are active.</param>
        /// <param name="fixedPoint">Location of the global fixed point</param>
        public virtual void Update(GameTime gameTime, int numShips, Vector2 fixedPoint)
        { }

        
        /// <summary>
        /// Draws the animation associated with this formation.
        /// </summary>
        /// <param name="spriteBatch"></param>
        /// <param name="gameTime"></param>
        public virtual void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        { }

    }//end Formation


    class Square : Formation
    {

    }

    class Line : Formation
    {

    }

    class V : Formation
    {

    }

    class Triangle : Formation
    {

    }
}
