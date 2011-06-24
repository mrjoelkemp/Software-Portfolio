
using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Input;
using Microsoft.Xna.Framework.Graphics;
namespace Gesture
{
    /// <summary>
    /// Maintains and controls a list of players in the game.
    /// </summary>
    class PlayerManager
    {
        public List<Player> playerList;
        
        /// <summary>
        /// Pointer to the Game object. We only need this when
        /// constructing the player objects.
        /// </summary>
        private Game gamePointer;

        public PlayerManager(Game game)
        {
            playerList = new List<Player>();
            this.gamePointer = game;
        }

        /// <summary>
        /// Adds a player to the list of managed players.
        /// </summary>
        /// <param name="playerIndex">Index of the game pad associated with this player.</param>
        public void AddPlayer(PlayerIndex playerIndex)
        {
            //Create a new player object
            Player newPlayer = new Player(this.gamePointer, playerIndex);

            //Add the new player to our list of players
            playerList.Add(newPlayer);
        }

        /// <summary>
        /// Helper to properly position the players at the bottom of the screen.
        /// </summary>
        public void SetInitialPositions()
        {
            //Initialize the player's fixed point to the bottom middle of the screen
            //The location of the bottom middle of the client bounds
            int bottomOffset = 100;   //Safe distance from bottom of the screen
            int fleetOffset = Defines.clientBounds.Width / 4;
            Vector2 bottomMiddleScreen = new Vector2();

            bottomMiddleScreen.X = Defines.clientBounds.Center.X;
            bottomMiddleScreen.Y = Defines.clientBounds.Height - bottomOffset;

            //Check the number of players
            switch (playerList.Count)
            {
                //Single Player Game
                case 1:
                    playerList[0].shipManager.fixedPoint.X = fleetOffset;
                    playerList[0].shipManager.fixedPoint.Y = bottomMiddleScreen.Y;
                    break;
                //Two-player game
                case 2:
                    playerList[0].shipManager.fixedPoint.X = fleetOffset;
                    playerList[0].shipManager.fixedPoint.Y = bottomMiddleScreen.Y;

                    playerList[1].shipManager.fixedPoint.X = Defines.clientBounds.Width - fleetOffset;
                    playerList[1].shipManager.fixedPoint.Y = bottomMiddleScreen.Y;
                    break;
            }
        }

        /// <summary>
        /// Updates all the active players in the game.
        /// </summary>
        /// <param name="gameTime">Elapsed game time</param>
        public void Update(GameTime gameTime)
        {
            //For every player that we maintain
            for(int i = 0; i < playerList.Count; i++)
            {
                //If the player is active in the game
                if(playerList[i].isPlayerActive)
                {
                    //Update the player 
                    playerList[i].Update(gameTime, GamePad.GetState(playerList[i].playerIndex));
                }
            }
        }

        /// <summary>
        /// Draws the active players.
        /// </summary>
        /// <param name="spriteBatch"></param>
        /// <param name="gameTime"></param>
        public void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            //For all players that we manage
            for (int i = 0; i < playerList.Count; i++)
                //If the current player is active
                if (playerList[i].isPlayerActive)
                {
                    //Draw that player
                    playerList[i].Draw(ref spriteBatch, gameTime);
                    //Draw that player's score
                    spriteBatch.DrawString(Defines.spriteFontKootenay, "Player " + playerList[i].playerIndex + " Score: " + playerList[i].score, new Vector2(Defines.clientBounds.Width / 2 - 200*(i+2), 0), Defines.textColor);
                }
        }
    }
}
