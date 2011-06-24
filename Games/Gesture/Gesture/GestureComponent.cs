using System;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Input;
using System.Collections.Generic;
using Microsoft.Xna.Framework.Graphics;
namespace Gesture
{
    /// <summary>
    /// Component that recognizes shapes (as a series of directions) 
    /// drawn from the right thumbstick on an Xbox360 controller.
    /// 
    /// When we have a direction, halt further directional input.
    /// When the thumbstick is back at rest, we can accept another direction.
    /// 
    /// Note: The player must draw the shape as individual directions, resting after
    /// each direction.
    /// </summary>
    class GestureComponent
    {
        public PlayerIndex currentPlayerIndex = new PlayerIndex();
        GamePadState currentGamePadState;


        // Assume that we are in one-player mode
        // public bool twoPlayerMode = false;       // UPDATE: Two-player mode controlled by GameplayScreen.cs

        // used for reading button input and storing results
        List<Buttons> queuedButtons = new List<Buttons>();

        // used to determine if determine if we accept normal or fusion gestures
        public bool fusionGestureMode = true;

        // used to determine if button is held down
        public bool buttonHeldDown_A = false;
        public bool buttonHeldDown_B = false;
        public bool buttonHeldDown_X = false;
        public bool buttonHeldDown_Y = false;


        //public int currentShape = Defines.NO_SHAPE;
        /// <summary>
        /// The current shape recognized by the gesture component.
        /// </summary>
        public Defines.GESTURES currentShape = Defines.GESTURES.NORMAL;

        public bool showStats = true;

        #region Right Thumbstick Support
        /* Directional Input based on Right Thumbstick */

        /// <summary>
        /// Controls how many times we accept directional input.
        /// </summary>
        bool isReady = true;
        Vector2 inputDirection;
        List<Vector2> queuedDirections = new List<Vector2>();
        //Directions (based on Xbox360 controller input vector analysis)
        public Vector2 UP_DIRECTION = new Vector2(0, 1);
        public Vector2 LEFT_DIRECTION = new Vector2(-1, 0);
        public Vector2 RIGHT_DIRECTION = new Vector2(1, 0);
        public Vector2 DOWN_DIRECTION = new Vector2(0, -1);
        public Vector2 DIAGONAL_DOWNLEFT_DIRECTION = new Vector2(-0.5f, -0.5f);
        public Vector2 DIAGONAL_UPRIGHT_DIRECTION = new Vector2(0.5f, 0.5f);
        public Vector2 DIAGONAL_DOWNRIGHT_DIRECTION = new Vector2(0.5f, -0.5f);
        public Vector2 DIAGONAL_UPLEFT_DIRECTION = new Vector2(-0.5f, 0.5f);
        //Adjusted diagonal vectors (based on input analysis)
        //NOTE: Older controllers have precision problems with diagonal input!
        public Vector2 DIAGONAL_DOWNLEFT_SKEWED = new Vector2(-0.5f, -1);
        public Vector2 DIAGONAL_DOWNRIGHT_SKEWED = new Vector2(0.5f, 1);
        public Vector2 DIAGONAL_UPLEFT_SKEWED = new Vector2(-0.5f, 1);
        public Vector2 DIAGONAL_UPRIGHT_SKEWED = new Vector2(1, 0.5f);

        //Shapes (as a list of defined directions)
        public List<Vector2> SQUARE_SHAPE = new List<Vector2>();
        public List<Vector2> TRIANGLE_SHAPE = new List<Vector2>();
        public List<Vector2> TRIANGLE_SHAPE_SKEWED = new List<Vector2>();
        public List<Vector2> LINE_SHAPE = new List<Vector2>();
        public List<Vector2> V_SHAPE = new List<Vector2>();
        public List<Vector2> V_SHAPE_SKEWED = new List<Vector2>();
        #endregion

        // Same shapes, but as buttons (No need for skewed directions!)
        public List<Buttons> SQUARE_SHAPE_B = new List<Buttons>();
        public List<Buttons> TRIANGLE_SHAPE_B = new List<Buttons>();
        public List<Buttons> LINE_SHAPE_B = new List<Buttons>();
        public List<Buttons> V_SHAPE_B = new List<Buttons>();
        public List<Buttons> NORMAL_SHAPE_B = new List<Buttons>();

        // 'B' Button counter
        public int B_count = 0;

        public GestureComponent(PlayerIndex playerIndex)
        {
            //State which gamepad to look at
            currentPlayerIndex = playerIndex;

            //TODO: Load gesture textures

            // Shape definitions via buttons

            // Button Command: Y A
            LINE_SHAPE_B.Add(Buttons.Y);
            LINE_SHAPE_B.Add(Buttons.A);

            // Button Command: X Y B
            TRIANGLE_SHAPE_B.Add(Buttons.X);
            TRIANGLE_SHAPE_B.Add(Buttons.Y);
            TRIANGLE_SHAPE_B.Add(Buttons.B);

            // Button Command: X A B
            V_SHAPE_B.Add(Buttons.X);
            V_SHAPE_B.Add(Buttons.A);
            V_SHAPE_B.Add(Buttons.B);

            // Button Command: A B Y X
            SQUARE_SHAPE_B.Add(Buttons.A);
            SQUARE_SHAPE_B.Add(Buttons.B);
            SQUARE_SHAPE_B.Add(Buttons.Y);
            SQUARE_SHAPE_B.Add(Buttons.X);
        }


        public void Update(GameTime gameTime)
        {
            // cache Player One's GamePadState
            currentGamePadState = GamePad.GetState(currentPlayerIndex);
            updatePlayerState(currentGamePadState);     // eventually replace line with updateButtonState();
        }
        
        /// <summary>
        /// Keeps track of the input of a given player
        /// </summary>
        /// <param name="currentGamePadState">Contains the GamePad whose state is in question</param>
        public void updatePlayerState(GamePadState currentGamePadState)
        {
            //If the system is ready for another direction
            if (currentGamePadState.IsConnected)
            {
                //Clicking in the right thumbstick resets the gesture input
                if (currentGamePadState.Buttons.RightStick == ButtonState.Pressed)
                {
                    queuedButtons.Clear();
                    currentShape = Defines.GESTURES.NORMAL;
                }

                if (queuedButtons.Count >= 2)
                {
                    currentShape = CheckShape(ref queuedButtons);

                    // if we made a change in gesture, reset the queue for the next gesture
                    if (currentShape != Defines.GESTURES.NORMAL)
                    {
                        queuedButtons.Clear();

                        // Also reset the 'B' Button counter
                        B_count = 0;
                    }
                }
                updateButtonState();
            }
        }
    

        /// <summary>
        /// Used to check the status of button input.
        /// </summary>
        public void updateButtonState()
        {
            // Check Button States
            // Idea: If the button is pressed but the 'flag' is not set, set the 'flag'. If
            // the button is not pressed but 'flag' is still set, unset the 'flag'.

            // First, check fusion Gesture state before checking button states
            if (currentGamePadState.IsButtonDown(Buttons.LeftTrigger) && !fusionGestureMode)
                fusionGestureMode = true;
            else if (currentGamePadState.IsButtonUp(Buttons.LeftTrigger) && fusionGestureMode)
                fusionGestureMode = false;

            // Check 'A' button state
            if (currentGamePadState.IsButtonDown(Buttons.A) && !buttonHeldDown_A)
            {
                queuedButtons.Add(Buttons.A);
                buttonHeldDown_A = true;
            }
            else if (currentGamePadState.IsButtonUp(Buttons.A) && buttonHeldDown_A)
                buttonHeldDown_A = false;

            // Check 'B' Button State	
            if (currentGamePadState.IsButtonDown(Buttons.B) && !buttonHeldDown_B)
            {
                queuedButtons.Add(Buttons.B);
                buttonHeldDown_B = true;

                // Increment counter to cancel formation
                B_count++;

                if (B_count >= 2)
                {
                    queuedButtons.Clear();
                    B_count = 0;
                }
            }
            else if (currentGamePadState.IsButtonUp(Buttons.B) && buttonHeldDown_B)
            {
                buttonHeldDown_B = false;

                if (B_count >= 2)
                {
                    queuedButtons.Clear();
                    B_count = 0;
                }
            }

            // Check 'X' Button State
            if (currentGamePadState.IsButtonDown(Buttons.X) && !buttonHeldDown_X)
            {
                queuedButtons.Add(Buttons.X);
                buttonHeldDown_X = true;
            }
            else if (currentGamePadState.IsButtonUp(Buttons.X) && buttonHeldDown_X)
                buttonHeldDown_X = false;

            // Check 'Y' Button State
            if (currentGamePadState.IsButtonDown(Buttons.Y) && !buttonHeldDown_Y)
            {
                queuedButtons.Add(Buttons.Y);
                buttonHeldDown_Y = true;
            }
            else if (currentGamePadState.IsButtonUp(Buttons.Y) && buttonHeldDown_Y)
                buttonHeldDown_Y = false;

            // if (currentGamePadState.IsButtonDown(Buttons.A | Buttons.B | Buttons.Y | Buttons.X) && !buttonHeldDown)
            // {
            // buttonHeldDown = true;

            // if (currentGamePadState.Buttons.A == ButtonState.Pressed)
            // queuedButtons.Add(Buttons.A);
            // if (currentGamePadState.Buttons.B == ButtonState.Pressed)
            // queuedButtons.Add(Buttons.B);
            // if (currentGamePadState.Buttons.X == ButtonState.Pressed)
            // queuedButtons.Add(Buttons.X);
            // if (currentGamePadState.Buttons.Y == ButtonState.Pressed)
            // queuedButtons.Add(Buttons.Y);
            // }
            // else
            // buttonHeldDown = false;

        }

        public void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            /* Draw some statistics */
            if (showStats) DrawStatistics(ref spriteBatch);
        }

        /// <summary>
        /// Draws some useful debug statistics to the screen.
        /// </summary>
        private void DrawStatistics(ref SpriteBatch spriteBatch)
        {
            // Queued Buttons
            spriteBatch.DrawString(Defines.spriteFontKootenay, "Queue Size: " + queuedButtons.Count.ToString(), Vector2.Zero, Defines.textColor);

            //Shape found
            String _currentShape = "NORMAL";

            // Only two choices: we are or we are not in fusion gesture mode
            if (fusionGestureMode)
            {
                if (currentShape == Defines.GESTURES.LINE) _currentShape = "FUSION_LINE";
                else if (currentShape == Defines.GESTURES.SQUARE) _currentShape = "FUSION_SQUARE";
                else if (currentShape == Defines.GESTURES.TRIANGLE) _currentShape = "FUSION_TRIANGLE";
                else if (currentShape == Defines.GESTURES.V) _currentShape = "FUSION_V";
            }
            else
            {
                /*
                if (currentShape == Defines.GESTURES.LINE) _currentShape = "LINE";
                else if (currentShape == Defines.GESTURES.SQUARE) _currentShape = "SQUARE";
                else if (currentShape == Defines.GESTURES.TRIANGLE) _currentShape = "TRIANGLE";
                else if (currentShape == Defines.GESTURES.V) _currentShape = "V";
                 * */
                _currentShape = currentShape.ToString();
            }
            spriteBatch.DrawString(Defines.spriteFontKootenay, "Shape Found: " + _currentShape, new Vector2(0, 25), Defines.textColor);

            //Input Vector
            //spriteBatch.DrawString(Defines.spriteFontKootenay, "Input Vector: " + inputDirection.ToString(), new Vector2(0, 50), Color.Black);
            //FixDirection(ref inputDirection);
            //spriteBatch.DrawString(Defines.spriteFontKootenay, "Fixed Input: " + inputDirection.ToString(), new Vector2(0, 75), Color.Black);

            //if (GameplayScreen.twoPlayerMode)
            //{
                //spriteBatch.DrawString(Defines.spriteFontKootenay, "Currently in 2-Player Mode", new Vector2(0, 100), Color.Black);

                // Check if trigger is held down for player 1
            if (fusionGestureMode)
                spriteBatch.DrawString(Defines.spriteFontKootenay, "Fusion Mode (Player " + currentPlayerIndex + "): READY!!!", new Vector2(0, 125), Color.Green);
            else
                spriteBatch.DrawString(Defines.spriteFontKootenay, "Fusion Mode (Player " + currentPlayerIndex + "): PRESS TRIGGER!", new Vector2(0, 125), Color.Red);
            /*
                // Check if trigger is held down for player 2
                if (GamePad.GetState(PlayerIndex.Two).IsButtonDown(Buttons.RightTrigger) || 
                    Keyboard.GetState().IsKeyDown(Keys.F)) // use if only one gamepad available
                    spriteBatch.DrawString(Defines.spriteFontKootenay, "Fusion Mode (Player 2): READY!!!", new Vector2(0, 150), Color.Green);
                else
                    spriteBatch.DrawString(Defines.spriteFontKootenay, "Fusion Mode (Player 2): PRESS TRIGGER!", new Vector2(0, 150), Color.Red);
            }
            else
            {
                //spriteBatch.DrawString(Defines.spriteFontKootenay, "Currently in 1-Player Mode", new Vector2(0, 100), Color.Black);

                if (GamePad.GetState(PlayerIndex.One).IsButtonDown(Buttons.RightTrigger))
                    spriteBatch.DrawString(Defines.spriteFontKootenay, "Fusion Mode: READY!!!", new Vector2(0, 125), Color.Green);
                else
                    spriteBatch.DrawString(Defines.spriteFontKootenay, "Fusion Mode: PRESS TRIGGER!", new Vector2(0, 125), Color.Red);
            }*/

        }

         /// <summary>
        /// Check if a shape has been created from the queue of inputted buttons
        /// </summary>
        /// <param name="queuedButtons">The queue of buttons to be checked</param>
        /// <returns> The shape that was generated shaped</returns>
        private Defines.GESTURES CheckShape(ref List<Buttons> queuedButtons)
        {
            // Assume that no shape has been generated
            Defines.GESTURES _resultGesture = Defines.GESTURES.NORMAL;

            // NOTE: Start with the "longest" shape [Shape that requires most inputs...then work in decreasing amount of input]
            // This allows us to check if we wanted a square (and not immediately substitute it for a triangle or V)

            // Check for square formation
            if (CheckShape(ref queuedButtons, ref SQUARE_SHAPE_B) == SQUARE_SHAPE_B.Count)
                _resultGesture = Defines.GESTURES.SQUARE;

             // Check for V formation
            else if (CheckShape(ref queuedButtons, ref V_SHAPE_B) == V_SHAPE_B.Count && queuedButtons.Count <= V_SHAPE_B.Count)
                _resultGesture = Defines.GESTURES.V;

             // Check for triangle formation
            else if (CheckShape(ref queuedButtons, ref TRIANGLE_SHAPE_B) == TRIANGLE_SHAPE_B.Count)
                _resultGesture = Defines.GESTURES.TRIANGLE;

            // Check for line formation
            else if (CheckShape(ref queuedButtons, ref LINE_SHAPE_B) == LINE_SHAPE_B.Count && queuedButtons.Count <= LINE_SHAPE_B.Count)
                _resultGesture = Defines.GESTURES.LINE;

            return _resultGesture;
        }



        //TODO: Create method to determine shape via button input
        /// <summary>
        /// Check to see if the buttons inputted from the controller matches any of the predefined shapes.
        /// </summary>
        /// <param name="queuedButtons"> List of inputted buttons </param>
        /// <param name="shapeButtons"> Predefined shape to be compared against </param>
        public int CheckShape(ref List<Buttons> queuedButtons, ref List<Buttons> shapeButtons)
        {
            // Used to keep track of number of matched buttons
            int _matchedButtons = 0;

            // Cache the size of queue and shape
            int queueSize = queuedButtons.Count;
            int shapeSize = shapeButtons.Count;

            // Begin check via double 'for' loop
            for (int i = 0; i < shapeSize; i++)
                for (int j = 0; j < queueSize; j++)
                    // If a match was found...
                    if (queuedButtons[j] == shapeButtons[i])
                    {
                        _matchedButtons++;
                        break;
                    }

            return _matchedButtons;
        }

    }
}
