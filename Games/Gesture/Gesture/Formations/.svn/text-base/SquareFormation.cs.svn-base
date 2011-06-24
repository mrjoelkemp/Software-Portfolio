using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework;

namespace Gesture
{
    class SquareFormation : Formation
    {
        public SquareFormation(int numShips, int shipWidth, int shipHeight, Vector2 pos)
        {
            ID = Defines.GESTURES.SQUARE;
            minimumShipCount = 4;
            usedByBothPlayers = true;
            currentNumberOfShips = 0;
            shipOffset = 10 + shipWidth;
            this.fixedPoint = pos;

            //Populate the position list for 4 ships.
            this.Update(null, numShips, this.fixedPoint);

            //Set rotations
            rotationList.Add(MathHelper.ToRadians(-90));
            rotationList.Add(MathHelper.ToRadians(90));
            rotationList.Add(MathHelper.ToRadians(0));
            rotationList.Add(MathHelper.ToRadians(0));
        }

        /// <summary>
        /// Updates the square formation based on the changing fixed point.
        /// </summary>
        /// <param name="numShips"></param>
        /// <param name="fixedPoint"></param>
        public override void Update(GameTime gameTime, int numShips, Vector2 fixedPoint)
        {
            //If the fixed point has been updated
            //If currentNumberOfShips = 0, then we're setting positions for the first time
            if (this.fixedPoint != fixedPoint || currentNumberOfShips == 0)
            {
                //Reset the position list since we'll change the positions
                positionList.Clear();

                /* Set the positions of the square */
                int _fx = (int)fixedPoint.X;
                int _fy = (int)fixedPoint.Y;

                //Top left
                positionList.Add(new Vector2(_fx - shipOffset, _fy + shipOffset));
                //Top right
                positionList.Add(new Vector2(_fx + shipOffset, _fy + shipOffset));
                //Bottom left
                positionList.Add(new Vector2(_fx - shipOffset, _fy - shipOffset));
                //Bottom right
                positionList.Add(new Vector2(_fx + shipOffset, _fy - shipOffset));

                this.fixedPoint = fixedPoint;
                currentNumberOfShips = numShips;
            }
            base.Update(gameTime, numShips, fixedPoint);
        }
    }
}
