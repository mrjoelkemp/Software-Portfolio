using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;

namespace Gesture
{
    /// <summary>
    /// Represents the object that manages the fleet of ships in the game.
    /// Managing includes initializing, updating (based on controller input), 
    /// removing, and drawing the fleet. 
    /// 
    /// The ShipManager also interacts with the FormationManager to organize
    /// the ships in different formations.
    /// </summary>
    class ShipManager
    {
        /// <summary>
        /// List of ships that make up the fleet.
        /// </summary>
        public List<Gryffon> shipList;

        /// <summary>
        /// The controller index of the current player.
        /// </summary>
        public PlayerIndex currentPlayerIndex;

        /// <summary>
        /// The number of ships in the fleet.
        /// </summary>
        public int numShips;

        /// <summary>
        /// The number of ships that are available to the player.
        /// </summary>
        public int numActiveShips;

        /// <summary>
        /// Controls all game formations and interacts with the gesture
        /// component to check for the signaling of new gestures/formations.
        /// </summary>
        public FormationManager formationManager;
        
        /// <summary>
        /// Keeps track of the current fleet formation.
        /// </summary>
        public Formation curFormation;

        /// <summary>
        /// The location of the fixed point that defines all formations and movement.
        /// Ship manager captures gamepad input, and it passes the fixed point to the
        /// formation manager.
        /// </summary>
        public Vector2 fixedPoint;


        #region Interpolation Stuff

        /// <summary>
        /// Used to track the elapsed time to guide ship formation position interpolation.
        /// </summary>
        private TimeSpan interpTimeSoFar = TimeSpan.Zero;
        /// <summary>
        /// Tracks whether or not we have initiated a changed in formation.
        /// If true, we will use linear interpolation to change the ship positions.
        /// </summary>
        private bool changedFormations = false;

        #endregion


        public ShipManager(Game game, PlayerIndex playerIndex)
        {
            shipList = new List<Gryffon>();
            numShips = 4;
            numActiveShips = numShips;
            currentPlayerIndex = playerIndex;
            //Initialize ships
            for (int i = 0; i < numShips; i++)
            {
                //Put ships into a default (no) formation
                shipList.Add(new Gryffon(Vector2.Zero, game));
                shipList[i].rotateAboutFixedPoint = true;
                shipList[i].color = (currentPlayerIndex == PlayerIndex.One) ? Color.PowderBlue : Color.Red;
            }

            formationManager = new FormationManager(game, numShips, 
                shipList[0].texture.Width, 
                shipList[0].texture.Height,
                currentPlayerIndex);

            //Set the default location of the fixed point
            fixedPoint = Vector2.Zero;

            //Set the default formation
            curFormation = formationManager.currentFormation;
           
            //Make the current formation public
            Defines.playersGestures.Add(playerIndex, curFormation.ID); 
            //Make the current fusion mode public
            Defines.playerFusionTriggered.Add(playerIndex, formationManager.gestureComponent.fusionGestureMode);
        }

        public void Update(GameTime gameTime, GamePadState currentState)
        {
            UpdateInput(gameTime, currentState);

            //Update the formation manager to check for new formations
            formationManager.Update(gameTime, numActiveShips, fixedPoint);

            //Update our global fusion mode flag
            Defines.playerFusionTriggered[this.currentPlayerIndex] = formationManager.gestureComponent.fusionGestureMode;

            //If the formation manager set a new formation
            if (curFormation.ID != formationManager.currentFormation.ID)
            {
                changedFormations = true;
                //Change our new current formation
                curFormation = formationManager.currentFormation;
                //Update our global formation/gesture
                Defines.playersGestures[this.currentPlayerIndex] = curFormation.ID;
                this.interpTimeSoFar = TimeSpan.Zero;
            }
                       
            this.UpdateShips(gameTime);           
        }

        /// <summary>
        /// Updates all active ships in the list by updating positions,
        /// rotations, forward vectors, etc.
        /// </summary>
        /// <param name="gameTime">Current game time</param>
        private void UpdateShips(GameTime gameTime)
        {
            //Update ships  
            for (int i = 0; i < numShips; i++)
                //If the sprite is not dead
                if (shipList[i].isAlive)
                {
                    //Update the point about which ships rotate
                    shipList[i].rotationFixedPoint = formationManager.globalFixedPoint;
                    //Update the ship's rotation
                    shipList[i].rotationAboutFixedPoint = formationManager.globalRotation;
                    //Rotate ship textures to the global rotation plus the formation's rotation 
                    //TODO: Interpolate rotations
                    shipList[i].rotation = formationManager.globalRotation + curFormation.rotationList[i];
                    //Update forward vector based on rotation
                    shipList[i].forwardVector.X = (float)Math.Sin(shipList[i].rotation);
                    shipList[i].forwardVector.Y = -(float)Math.Cos(shipList[i].rotation);

                    //Update ship position based on formation information
     
                    //If we're changing formations then use interpolation
                    if (changedFormations)
                    {
                        //Get the new interpolated position
                        Vector2 _shipPos = shipList[i].position;
                        Vector2 _formPos = curFormation.positionList[i];
                        Vector2 _newPosition = this.GetInterpolatedPosition(ref _shipPos, ref _formPos, curFormation.delay, gameTime);
                        
                        if (_newPosition == curFormation.positionList[i])
                            //We're done interpolating
                            changedFormations = false;
                        else                           
                            shipList[i].position = _newPosition;
                    }
                    //Otherwise, there was no formation change
                    else
                        //Update the position to the position of the current formation
                        shipList[i].position = curFormation.positionList[i];
                    
                    shipList[i].Update(gameTime);
                }
        }

        /// <summary>
        /// Returns the (linearly) interpolated vector based on the passed delay.
        /// </summary>
        /// <param name="source">Source position.</param>
        /// <param name="dest">Destination position.</param>
        /// <param name="delay">Delay that will influence the amount of interpolation points.</param>
        /// <param name="gameTime">Current game time.</param>
        /// <returns>The interpolated vector.</returns>
        private Vector2 GetInterpolatedPosition(ref Vector2 source, ref Vector2 dest, TimeSpan delay, GameTime gameTime)
        {
            Vector2 _interpPosition = Vector2.Zero;
            this.interpTimeSoFar+= gameTime.ElapsedGameTime;

            // Clamp at max time, so we don't over-extend beyond destination  
            if (this.interpTimeSoFar >= delay)
            {
                this.interpTimeSoFar = delay;
            }   
            
            // Calculate our interpolated position  
            float _lerpAmount = (float)this.interpTimeSoFar.Ticks / delay.Ticks;

            Vector2.Lerp(ref source, ref dest, _lerpAmount, out _interpPosition); 

            return _interpPosition;
        }

        /// <summary>
        /// Checks for controller input related to the ships.
        /// </summary>
        private void UpdateInput(GameTime gameTime, GamePadState currentState)
        {
            //We capture joystick input (keyboard as well for testing)
            KeyboardState keyState = Keyboard.GetState();
            Vector2 _movementVector = Vector2.Zero;

            #region Xbox 360 Controller Input Support
            //If the Xbox 360 Controller is connected
            if (currentState.IsConnected)
            {

                //Rotation by left and right bumpers
                if (currentState.Buttons.RightShoulder == ButtonState.Pressed)
                    formationManager.globalRotation += Defines.BUMPER_SCALE;
                else if (currentState.Buttons.LeftShoulder == ButtonState.Pressed)
                    formationManager.globalRotation -= Defines.BUMPER_SCALE;

                float _lts = Defines.LEFT_THUMBSTICK_SCALE;
 
                //Scale our direction by how hard the trigger is down. Fully held is 50% increase.
                float _speedIncrease = (_lts * 0.50f) * currentState.Triggers.Left;
                float modifiedThumbstickScale = _lts + _speedIncrease;

                //Compute the thumbstick position change
                //_movementVector = new Vector2((currentState.ThumbSticks.Left.X * modifiedThumbstickScale) * ((float)gameTime.ElapsedGameTime.TotalSeconds * modifiedThumbstickScale),
                //    -(currentState.ThumbSticks.Left.Y * modifiedThumbstickScale) * ((float)gameTime.ElapsedGameTime.TotalSeconds * modifiedThumbstickScale));
                _movementVector = new Vector2();
                _movementVector.X = currentState.ThumbSticks.Left.X * modifiedThumbstickScale;
                _movementVector.Y =  -(currentState.ThumbSticks.Left.Y * modifiedThumbstickScale);
                _movementVector.X *= (modifiedThumbstickScale * (float)gameTime.ElapsedGameTime.TotalSeconds);
                _movementVector.Y *= (modifiedThumbstickScale * (float)gameTime.ElapsedGameTime.TotalSeconds);
                
                //If we're not in repair or fusion mode, shoot normally
                if (!RepairPowerup.repairModeEnabled && !formationManager.inFusionMode)
                {
                    //Tell the ships to shoot when right trigger is down
                    if (currentState.Triggers.Right == 1)
                        for (int i = 0; i < shipList.Count; i++)
                            shipList[i].Shoot();
                }
                    
            }
            #endregion

            #region Keyboard Input Support
            /*
             Testing: Keyboard input active 
             Layout:
                W S A D         = Up Down Left Right
                Left Control    = Rotate Anti-Clockwise
                Right Control   = Rotate Clockwise
                Spacebar        = Shoot
             */
            Vector2 shipSpeed = shipList[0].speed * 5;

            if (keyState.IsKeyDown(Keys.Left) || keyState.IsKeyDown(Keys.A))
            {
                _movementVector.X -= shipSpeed.X;// *(float)gameTime.ElapsedGameTime.TotalSeconds;
            }
            else if (keyState.IsKeyDown(Keys.Right) || keyState.IsKeyDown(Keys.D))
            {
                _movementVector.X += shipSpeed.X;// *(float)gameTime.ElapsedGameTime.TotalSeconds;
            }
            else if (keyState.IsKeyDown(Keys.Up) || keyState.IsKeyDown(Keys.W))
            {
                _movementVector.Y -= shipSpeed.Y;// *(float)gameTime.ElapsedGameTime.TotalSeconds;
            }
            else if (keyState.IsKeyDown(Keys.Down) || keyState.IsKeyDown(Keys.S))
            {
                _movementVector.Y += shipSpeed.Y;// *(float)gameTime.ElapsedGameTime.TotalSeconds;
            }
            else if (keyState.IsKeyDown(Keys.LeftControl))   //Rotate Anti-clockwise
            { }
            else if (keyState.IsKeyDown(Keys.RightControl)) //Rotate Clockwise
            { }

            /* 
             Note: We don't nest the spacebar conditional so we can move (directional) and shoot at the same time!
             */
            if (keyState.IsKeyDown(Keys.Space) == true)         //Shoot
            {
                //Tell the ships to shoot
                for (int i = 0; i < shipList.Count; i++)
                    shipList[i].Shoot();
            }



            #endregion

            //Update the location of the global fixed point based on the input
            //If the formation manager is in fusion mode and we're player two
            if (currentPlayerIndex == PlayerIndex.Two && formationManager.inFusionMode)
            {
                fixedPoint = Defines.LeaderGlobalFixedPoint;
            }
            //Otherwise, if we're player one in fusion mode
            else if (currentPlayerIndex == PlayerIndex.One && formationManager.inFusionMode)
            {
                //Change the fixed point according to the controller input
                fixedPoint.X += _movementVector.X;
                fixedPoint.Y += _movementVector.Y;
                //Set the system-wide variable that is used for Fusion Formations.
                Defines.LeaderGlobalFixedPoint = fixedPoint;

            }
            else
            {
                //Change the fixed point according to the controller input
                fixedPoint.X += _movementVector.X;
                fixedPoint.Y += _movementVector.Y;
            }   
           
            //DEBUG: Generate a shockwave at the fixed point location when the user presses D-Up
            //TODO: Remove this code
            
            if (currentState.IsConnected)
                if(currentState.IsButtonDown(Buttons.DPadUp))
                    Defines.particleManager.AddParticleSystem(typeof(ShockwaveParticleSystem), fixedPoint);

            if (keyState.IsKeyDown(Keys.Z))
                Defines.particleManager.AddParticleSystem(typeof(CrossFusionShockwave), fixedPoint);
            //TODO: Clamp fixed point so that it doesn't go off screen
        }

        /// <summary>
        /// Draw the ships in the fleet.
        /// </summary>
        /// <param name="spriteBatch"></param>
        /// <param name="gameTime"></param>
        public void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            //Draw ships
            for (int i = 0; i < shipList.Count; i++)
            {
                //Cache ship sprite
                Gryffon curShip = shipList[i];

                if (curShip.isActive)
                {
                    curShip.Draw(ref spriteBatch, gameTime);

                    //Draw some identifier to keep track of ships
                    spriteBatch.DrawString(Defines.spriteFontKootenay, i.ToString(), curShip.position, Defines.textColor);
                }
            }

            //Draw the formation manager's global fixed point
            formationManager.Draw(ref spriteBatch, gameTime);
        }
    }
}
