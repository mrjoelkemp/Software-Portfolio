using Microsoft.Xna.Framework;
using System.Collections.Generic;
using Microsoft.Xna.Framework.Graphics;
using System;

namespace Gesture
{
    /// <summary>
    /// Contains all system-wide accessible (global) variables for the game.
    /// </summary>
    class Defines
    {
        /// <summary>
        /// Holds the current number of players in the game
        /// </summary>
        public static int NUM_PLAYERS;

        /// <summary>
        /// Bounds of the client's screen
        /// </summary>
        public static Rectangle clientBounds;
        
        /// <summary>
        /// Kootenay Sprite Font.
        /// </summary>
        public static SpriteFont spriteFontKootenay;

        /// <summary>
        /// A universal color for drawing text.
        /// This allows us to change the color across the entire
        /// system and not in individual modules/classes.
        /// </summary>
        public static Color textColor = Color.White;

        /// <summary>
        /// Random number generator used to generate initial pawn positions
        /// </summary>
        public static Random randomGenerator = new Random();

        /// <summary>
        /// Holds the current gesture for each player in the gmae.
        /// In order to access the gesture of a player, just pass in the PlayerIndex of that player.
        /// </summary>
        public static Dictionary<PlayerIndex, Defines.GESTURES> playersGestures = new Dictionary<PlayerIndex,Defines.GESTURES>();

        /// <summary>
        /// Holds which of the players has fusion mode enabled (holding the right thumbstick).
        /// This is used to test if two players have fusion mode enabled, triggering a fusion
        /// gesture/formation for the two players.
        /// </summary>
        public static Dictionary<PlayerIndex, bool> playerFusionTriggered = new Dictionary<PlayerIndex, bool>();
        
        /// <summary>
        /// Controls the addition and rendering of particle systems.
        /// </summary>
        public static ParticleManager particleManager; 
        
        //Controller Attributes
        public const float LEFT_THUMBSTICK_SCALE = 17.0f;
        public const float BUMPER_SCALE = 0.05f;

        /// <summary>
        /// The changing fixed point position of the leader in a fusion formation.
        /// The leader will always be Player One. In a fusion formation, player 2
        /// will not have control of moving the fusion formation.
        /// </summary>
        public static Vector2 LeaderGlobalFixedPoint = Vector2.Zero;

        /// <summary>
        /// Timer for the fusion formations.
        /// This is global so that all players can be synchronized.
        /// </summary>
        public static TimeSpan FusionTimer = TimeSpan.Zero;

        //TODO: Use the enum rather than the constants. Assigning int values is useless.
        public enum GESTURES
        {
            NORMAL,
            LINE,
            SQUARE,
            TRIANGLE,
            V,
            NORMAL_FUSION,
            LINE_FUSION,
            SQUARE_FUSION,
            TRIANGLE_FUSION,
            V_FUSION,
            NONE,
            RESET
        }
    }
}
