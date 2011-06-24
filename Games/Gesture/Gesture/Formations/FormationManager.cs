using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace Gesture
{
    /// <summary>
    /// Represents the class that manages all of the games formation objects.
    /// </summary>
    class FormationManager
    {

        #region Fields

        /// <summary>
        /// A local copy of the main game object.
        /// </summary>
        Game game;

        /// <summary>
        /// Keeps track of the player controlling this formation manager.
        /// </summary>
        PlayerIndex currentPlayerIndex;

        //Formation (refers to a recognized shape)
        public Defines.GESTURES currentFormationID = Defines.GESTURES.NORMAL;
        public Defines.GESTURES previousFormationID = Defines.GESTURES.NORMAL;

        //Formations
        /// <summary>
        /// Dictionary that holds a list of formations indexed by their formation ID. 
        /// This allows us to quickly find a formation based on an ID; making the process
        /// of changing the current formation seamless and ultra-fast!
        /// </summary>
        public Dictionary<Defines.GESTURES, Formation> formationList;
        /// <summary>
        /// Dictionary that holds a list of fusion formations indexed by their formation ID.
        /// </summary>
        public Dictionary<Defines.GESTURES, FusionFormation> fusionFormationList;

        /// <summary>
        /// Keeps track of the current regular formation.
        /// </summary>
        public Formation currentFormation;
        /// <summary>
        /// Keeps track of the current fusion formation.
        /// </summary>
        public FusionFormation currentFusionFormation;

        /// <summary>
        /// Whether or not there is an active fusion formation.
        /// </summary>
        public bool inFusionMode = false;


        /// <summary>
        /// Keeps track of the current number of ships in the fleet.
        /// </summary>
        public int currentNumberOfShips;

        /// <summary>
        /// Keeps track of the fixed point that all formations are defined about.
        /// </summary>
        public Vector2 globalFixedPoint;
        private bool drawFixedPoint;

        /// <summary>
        /// Keeps track of the rotation for the formation. 
        /// All ships in the fleet will rotate about the fixed point by the 
        /// globalRotation amount.
        /// </summary>
        public float globalRotation;

        /// <summary>
        /// Captures gestures triggered by the player.
        /// </summary>
        public GestureComponent gestureComponent;

        #endregion

        /// <summary>
        /// Creates all of the games formation objects with ship 
        /// pre-defined positions based on the number of ships to be used.
        /// </summary>
        /// <param name="numShips">The number of ships that will be used within the formations.</param>
        /// <param name="shipWidth">The width of the ship that will be used in spacing the ships.</param>
        /// <param name="shipHeight">The height of the ship that will be used in spacing the ships.</param>
        public FormationManager(Game game, int numShips, int shipWidth, int shipHeight, PlayerIndex playerIndex)
        {
            this.game = game;
            this.currentPlayerIndex = playerIndex;

            currentNumberOfShips = numShips;
            globalFixedPoint = Vector2.Zero;
            drawFixedPoint = false;


            //Initialize the global fixed point to the bottom middle of the screen.
            globalRotation = 0;

            /* Initialize the different formations (positions, rotations, and bounding rectangles) */
            formationList = new Dictionary<Defines.GESTURES,Formation>();
    
            //TODO: Stop using the formation variables and just populate the formation list.
            formationList.Add(Defines.GESTURES.NORMAL, new NormalFormation(numShips, shipWidth, shipHeight, globalFixedPoint));
            formationList.Add(Defines.GESTURES.SQUARE, new SquareFormation(numShips, shipWidth, shipHeight, globalFixedPoint));
            formationList.Add(Defines.GESTURES.V, new VFormation(numShips, shipWidth, shipHeight, globalFixedPoint));
            formationList.Add(Defines.GESTURES.LINE, new LineFormation(numShips, shipWidth, shipHeight, globalFixedPoint));
            formationList.Add(Defines.GESTURES.TRIANGLE, new TriangleFormation(numShips, shipWidth, shipHeight, globalFixedPoint));
            formationList.Add(Defines.GESTURES.RESET, formationList[Defines.GESTURES.NORMAL]);

            fusionFormationList = new Dictionary<Defines.GESTURES, FusionFormation>();
            fusionFormationList.Add(Defines.GESTURES.LINE_FUSION, new CrossFusionFormation(game, shipWidth, shipHeight, globalFixedPoint));
           
            //Set current formation to the default Normal Formation.
            currentFormation = formationList[Defines.GESTURES.NORMAL];
            gestureComponent = new GestureComponent(playerIndex);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="gameTime"></param>
        public void Update(GameTime gameTime, int numShips, Vector2 fixedPoint)
        {
            //Store the changed fixed point
            globalFixedPoint = fixedPoint;

            /* 
             * Note: We only want to check for new formation changes when we aren't
             * in fusion mode. If we are in fusion mode, then we check for formations when
             * the fusion timer has expired.
             */
            if (!inFusionMode)
            {
                //Update the gesture component to check for new formations
                gestureComponent.Update(gameTime);

                //Check for new gestures
                currentFormationID = gestureComponent.currentShape;
                if (currentFormationID != previousFormationID)
                    //Update formation positions
                    UpdateFormation();

                //Update the positions of the ships based on the player's fixed point
                currentFormation.Update(gameTime, numShips, globalFixedPoint);


            }
            //Otherwise, we're in a fusion formation
            else
            {
                //Only player one can manipulate the global fusion timer
                if(currentPlayerIndex == PlayerIndex.One)
                    Defines.FusionTimer -= gameTime.ElapsedGameTime;

                if (Defines.FusionTimer <= TimeSpan.Zero)
                    inFusionMode = false;

                currentFusionFormation.Update(gameTime, globalFixedPoint);
                currentFormation = currentFusionFormation.playerFormationList[currentPlayerIndex];
            }


             

        }

        /// <summary>
        /// Updates the current formation to the newly recognized system gesture.
        /// </summary>
        public void UpdateFormation()
        {
            //If the player is triggering a fusion
            if (Defines.playerFusionTriggered[this.currentPlayerIndex])
            {
                //If there is a second player and that player is also in fusion mode
                if (Defines.playersGestures.Count > 1)
                {   
                    //Get the index of the other player
                    PlayerIndex _otherPlayer = (this.currentPlayerIndex == PlayerIndex.One) ? PlayerIndex.Two : PlayerIndex.One;

                    //If the other player is in fusion mode and their formation isn't a Normal formation
                    if (Defines.playerFusionTriggered[_otherPlayer])
                    {
                        //Check the ID of the gesture
                        switch (currentFormationID)
                        {
                            case Defines.GESTURES.LINE:
                                currentFormationID = Defines.GESTURES.LINE_FUSION;
                                break;
                            case Defines.GESTURES.SQUARE:
                                currentFormationID = Defines.GESTURES.SQUARE_FUSION;
                                break;
                            case Defines.GESTURES.TRIANGLE:
                                currentFormationID = Defines.GESTURES.TRIANGLE_FUSION;
                                break;
                            case Defines.GESTURES.V:
                                currentFormationID = Defines.GESTURES.V_FUSION;
                                break;
                        }
                        currentFusionFormation = fusionFormationList[currentFormationID];

                        //Set the current formation to the fusion formation for this player
                        currentFormation = currentFusionFormation.playerFormationList[currentPlayerIndex];
                        //Set up the formation manager for a fusion formation.
                        this.StartFusionMode();
                    }


                }
                //Otherwise we need a single-player fusion mode.
                else if (Defines.playersGestures.Count == 1)
                {
                    //TODO: Implement single-player fusion triggering.
                }

            }
            //Otherwise, we're not triggering a fusion, 
            //  so just find the regular formation 
            else
                currentFormation = formationList[currentFormationID];

            //Set ID to remember gesture
            previousFormationID = currentFormationID;
        }

        /// <summary>
        /// Helper to set up the formation manager for a fusion formation.
        /// </summary>
        private void StartFusionMode()
        {
            inFusionMode = true;
            if(this.currentPlayerIndex == PlayerIndex.One)
                Defines.FusionTimer = TimeSpan.FromSeconds(5);
        }

        /// <summary>
        /// Draws the global fixed point for debug purposes.
        /// </summary>
        /// <param name="spriteBatch"></param>
        /// <param name="gameTime"></param>
        public void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            if (drawFixedPoint)
            {
                //Draw the global fixed point           
                PrimitiveLine brush = new PrimitiveLine(game.GraphicsDevice);
                //Create a circle (from 100 lines) with the radius
                int _radius = 5;
                brush.CreateCircle(_radius, 100);
                //Minus off the radius to get the circle centered on the fixed point
                brush.Position.X = globalFixedPoint.X;
                brush.Position.Y = globalFixedPoint.Y;
                brush.Render(ref spriteBatch);
            }

            //Print some gesture stats
            if (gestureComponent.showStats)
                gestureComponent.Draw(ref spriteBatch, gameTime);

        }

    }
}
