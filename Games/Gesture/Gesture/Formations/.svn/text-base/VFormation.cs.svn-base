using Microsoft.Xna.Framework;

namespace Gesture
{
    class VFormation : Formation
    {
        public VFormation(int numShips, int shipWidth, int shipHeight, Vector2 pos)
        {
            ID = Defines.GESTURES.V;
            minimumShipCount = 4;       //2 Ship minimum
            usedByBothPlayers = true;
            currentNumberOfShips = 0;
            shipOffset = 10 + shipWidth;
            this.fixedPoint = pos;

            this.Update(null, numShips, this.fixedPoint);

            //Set rotations
            for (int i = 0; i < numShips; i++)
                rotationList.Add(MathHelper.ToRadians(0));
        }

        public override void Update(GameTime gameTime, int numShips, Vector2 fixedPoint)
        {
            if (this.fixedPoint != fixedPoint || currentNumberOfShips == 0)
            {
                //Reset
                positionList.Clear();

                /* Set positions */
                int _fx = (int)fixedPoint.X;
                int _fy = (int)fixedPoint.Y;

                //Top Left
                positionList.Add(new Vector2(_fx - shipOffset, _fy - shipOffset));
                //Top Right
                positionList.Add(new Vector2(_fx + shipOffset, _fy - shipOffset));
                //Bottom Left Middle
                positionList.Add(new Vector2(_fx - shipOffset/2, _fy + shipOffset));
                //Bottom Right Middle
                positionList.Add(new Vector2(_fx + shipOffset/2, _fy + shipOffset));


                currentNumberOfShips = numShips;
                this.fixedPoint = fixedPoint;
            }
            
            base.Update(gameTime, numShips, fixedPoint);
        }

    }
}
