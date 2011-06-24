using Microsoft.Xna.Framework;

namespace Gesture
{
    class TriangleFormation : Formation
    {
        /// <summary>
        /// The middle ship should rotate about a 90 degree forward angle (i.e. viewing ray). 
        /// Tracks if the ship has hit the bounds of the viewing ray and the
        /// rotation needs to be flipped in the opposite direction.
        /// </summary>
        bool shipRotationFlipRight = false;

        public TriangleFormation(int numShips, int shipWidth, int shipHeight, Vector2 pos)
        {
            ID = Defines.GESTURES.TRIANGLE;
            minimumShipCount = 3;       //2 Ship minimum
            usedByBothPlayers = true;
            currentNumberOfShips = 0;
            shipOffset = 10 + shipWidth;
            this.fixedPoint = pos;

            this.Update(null, currentNumberOfShips, this.fixedPoint);

            //Set rotations
            //TODO: Fix rotations for triangle formation
            rotationList.Add(MathHelper.ToRadians(0));
            rotationList.Add(MathHelper.ToDegrees(0));
            rotationList.Add(MathHelper.ToRadians(-45));
            rotationList.Add(MathHelper.ToRadians(45));

        }

        public override void Update(GameTime gameTime, int numShips, Vector2 fixedPoint)
        {
            if (currentNumberOfShips != numShips || this.fixedPoint != fixedPoint)
            {
                //Reset
                positionList.Clear();

                int _fx = (int)fixedPoint.X;
                int _fy = (int)fixedPoint.Y;

                switch (numShips)
                {
                    //TODO: Populate positions
                    case 4:
                        //Top Most
                        positionList.Add(new Vector2(_fx, _fy - shipOffset));
                        //Fixed Point
                        positionList.Add(new Vector2(_fx, _fy));
                        //Bottom Left
                        positionList.Add(new Vector2(_fx - shipOffset, _fy + shipOffset));
                        //Bottom Right
                        positionList.Add(new Vector2(_fx + shipOffset, _fy + shipOffset));
                        break;
                    case 3:
                        //Top Most
                        positionList.Add(new Vector2(_fx, _fy - shipOffset));
                        //Bottom Left
                        positionList.Add(new Vector2(_fx - shipOffset, _fy + shipOffset));
                        //Bottom Right
                        positionList.Add(new Vector2(_fx + shipOffset, _fy + shipOffset));
                        break;
                }

                currentNumberOfShips = numShips;
                this.fixedPoint = fixedPoint;
            }

            //Update rotation for middle ship if numShips == 4
            if (numShips == 4 && gameTime != null)
            {
                float _currentRotation = rotationList[1];
                //If it's not time to flip the rotation
                if (!shipRotationFlipRight)
                {
                    //Rotate ship counterclockwise
                    _currentRotation -= Defines.BUMPER_SCALE;
                    if (_currentRotation <= MathHelper.ToRadians(-45))
                        shipRotationFlipRight = true;
                }
                //We should flip the rotation clockwise
                else
                {
                    //Rotate ship clockwise
                    _currentRotation += Defines.BUMPER_SCALE;
                    if (_currentRotation >= MathHelper.ToRadians(45))
                        shipRotationFlipRight = false;
                }

                //Set the new rotation
                rotationList[1] = _currentRotation;
            }

            base.Update(gameTime, numShips, fixedPoint);
        }
    }
}
