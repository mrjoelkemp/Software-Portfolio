using Microsoft.Xna.Framework;

namespace Gesture
{
    class NormalFormation : Formation
    {
        /// <summary>
        /// Constructor that takes in a number of 
        /// </summary>
        /// <param name="numShips"></param>
        public NormalFormation(int numShips, int shipWidth, int shipHeight, Vector2 pos)
        {
            ID = Defines.GESTURES.NORMAL;
            minimumShipCount = 1;
            usedByBothPlayers = true;
            currentNumberOfShips = 0;
            shipOffset = 10 + shipWidth;
            this.fixedPoint = pos;

            //Populate the position list for 4 ships.
            this.Update( null,numShips, fixedPoint);

            for (int i = 0; i < numShips; i++)
                //Add rotations for each ship
                rotationList.Add(MathHelper.ToRadians(0));
        }

        public override void Update(GameTime gameTime, int numShips, Vector2 fixedPoint)
        {
            //If the number of ships in the fleet have changed or the fixed point has been updated
            if (this.currentNumberOfShips != numShips || this.fixedPoint != fixedPoint)
            {
                //Reset the position list since we'll change the positions
                positionList.Clear();

                int _fx = (int)fixedPoint.X;
                int _fy = (int)fixedPoint.Y;

                switch (numShips)
                {
                    case 4:
                        //Left most position
                        positionList.Add(new Vector2(_fx - 2 * shipOffset, _fy));
                        //Position from left of fixed point. 
                        positionList.Add(new Vector2(_fx - shipOffset, _fy));
                        //Second position from the right of the fixed point
                        positionList.Add(new Vector2(_fx + shipOffset, _fy));
                        //Right most position
                        positionList.Add(new Vector2(_fx + 2 * shipOffset, _fy));
                        break;
                    case 3:
                        //Position from left of fixed point. 
                        positionList.Add(new Vector2(_fx - shipOffset, _fy));
                        //Center position
                        positionList.Add(new Vector2(_fx, _fy));
                        //Second position from the right of the fixed point
                        positionList.Add(new Vector2(_fx + shipOffset, _fy));
                        break;
                    case 2:
                        //Left most position
                        positionList.Add(new Vector2(_fx - shipOffset, _fy));
                        //Right most position
                        positionList.Add(new Vector2(_fx + shipOffset, _fy));
                        break;
                    case 1:
                        //Center position
                        positionList.Add(new Vector2(_fx, _fy));
                        break;

                }
                //Set the new number of ships we currently have
                currentNumberOfShips = numShips;
                //Remember the location of the fixed point so we don't needlessly update when staying still
                this.fixedPoint = fixedPoint;
            }
            base.Update(gameTime, numShips, fixedPoint);
        }
    }

}
