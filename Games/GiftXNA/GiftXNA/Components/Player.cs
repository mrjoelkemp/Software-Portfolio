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
        /// The score of the player.
        /// </summary>
        public int score;


        public Player(Game game, PlayerIndex playerIndex)
        {
            score = 0;
            isPlayerActive = true;
            this.playerIndex = playerIndex;
        }

        public void Update(GameTime gameTime, GamePadState currentState)
        {
        }
       
        public void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
        }
    }
}

