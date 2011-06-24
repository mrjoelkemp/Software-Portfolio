using Microsoft.Xna.Framework;

namespace Gesture
{
    class LineFormation : Formation
    {
        public LineFormation(int numShips, int shipWidth, int shipHeight, Vector2 pos)
        {
            ID = Defines.GESTURES.LINE;
            minimumShipCount = 2;       //2 Ship minimum
            usedByBothPlayers = true;
            currentNumberOfShips = 0;
            shipOffset = 10 + shipWidth;
            this.fixedPoint = pos;

            this.Update(null, currentNumberOfShips, this.fixedPoint);

            //Set rotations
            rotationList.Add(MathHelper.ToRadians(180));
            rotationList.Add(MathHelper.ToRadians(-90));
            rotationList.Add(MathHelper.ToRadians(90));
            rotationList.Add(MathHelper.ToRadians(0));
        }

        public override void Update(GameTime gameTime, int numShips, Vector2 fixedPoint)
        {
            if (currentNumberOfShips != numShips || this.fixedPoint != fixedPoint)
            {
                //Reset the position list since we'll change the positions
                positionList.Clear();

                int _fx = (int)fixedPoint.X;
                int _fy = (int)fixedPoint.Y;

                //Formation is a straight vertical line
                switch (numShips)
                {
                    case 4:
                        //Top most
                        positionList.Add(new Vector2(_fx, _fy + shipOffset * 2));
                        //Top first from fixed
                        positionList.Add(new Vector2(_fx, _fy + shipOffset));
                        //Bottom first from fixed
                        positionList.Add(new Vector2(_fx, _fy - shipOffset));
                        //Bottom most
                        positionList.Add(new Vector2(_fx, _fy - shipOffset * 2));
                        break;
                    case 3:
                        //Top most
                        positionList.Add(new Vector2(_fx, _fy + shipOffset));
                        //Fixed point
                        positionList.Add(new Vector2(_fx, _fy));
                        //Bottom most
                        positionList.Add(new Vector2(_fx, _fy - shipOffset));
                        break;
                    case 2:
                        //Top most
                        positionList.Add(new Vector2(_fx, _fy + shipOffset));
                        //Bottom most
                        positionList.Add(new Vector2(_fx, _fy - shipOffset));
                        break;

                }

                currentNumberOfShips = numShips;
                this.fixedPoint = fixedPoint;
            }

            base.Update(gameTime, numShips, fixedPoint);
        }
    }
}
