using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Audio;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using System;
using System.Collections.Generic;

namespace Gesture
{
    /// <summary>
    /// Represents the player of the game.
    /// </summary>
    class Player
    {
        /// <summary>
        /// Controls which gamepad is associated with this player.
        /// </summary>
        public PlayerIndex playerIndex;

        /// <summary>
        /// Determines if the player is active in the game.
        /// If the player is not active, it shouldn't be updated
        /// nor capturing input.
        /// </summary>
        public bool isPlayerActive;

        /// <summary>
        /// Controls the entire fleet of ships. Any interaction with the 
        /// ships must go through the manager.
        /// </summary>
        public ShipManager shipManager;

        //Constants 
        public const int NUM_SHIPS = 4;
        /// <summary>
        /// The number of lives/continues for the player.
        /// </summary>
        public int lives;

        /// <summary>
        /// The score of the player.
        /// </summary>
        public int score;

        /// <summary>
        /// Number of continues that a player has remaining.
        /// </summary>
        public int continues;

        public Player(Game game, PlayerIndex playerIndex)
        {
            //Initialize the ship manager
            shipManager = new ShipManager(game, playerIndex);
            score = 0;
            lives = 3;
            continues = 5;
            isPlayerActive = true;
            this.playerIndex = playerIndex;
        }

        public void Update(GameTime gameTime, GamePadState currentState)
        {
            shipManager.Update(gameTime, currentState);
        }
       
        public void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            shipManager.Draw(ref spriteBatch, gameTime);
        }
    }
}

