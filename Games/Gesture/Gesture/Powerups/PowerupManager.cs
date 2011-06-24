using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Input;

namespace Gesture
{
    /// <summary>
    /// Class used to maintain and hold powerups
    /// </summary>
    class PowerupManager
    {
        /// <summary>
        /// List used to store the powerups.
        /// </summary>
        public List<AnimatedSprite> powerupList;

        ///// <summary>
        ///// How long the powerup should stay active.
        ///// </summary>
        //public int duration;

        ///// <summary>
        ///// How long the powerup has been alive.
        ///// </summary>
        //private float timeAlive;

        /// <summary>
        /// Whether or not the powerup is alive.
        /// </summary>
        //public bool isAlive;

        ///// <summary>
        ///// The speed at which the powerup travels.
        ///// </summary>
        //public Vector2 speed;

        ///// <summary>
        ///// Time delay till another repair power up appears
        ///// </summary>
        //public int delay;

        public PowerupManager(Game game)
        {
            // Create an empty list for powerups
            powerupList = new List<AnimatedSprite>();
            powerupList.Add(new RepairPowerup(game));   
        }

        public void Add(AnimatedSprite powerup)
        {
            powerupList.Add(powerup);
        }

        public void Update(GameTime gameTime)
        {
            // For every powerup in the game
            for (int i = 0; i < powerupList.Count; i++)
                // Check if its active
                if (powerupList[i].isActive)
                    // If so, update its actions
                    powerupList[i].Update(gameTime);
        }

        /// <summary>
        /// Used to collect and assign actions to the current powerup
        /// </summary>
        /// <param name="powerup"></param>
        /// <param name="player"></param>
        public static void inputManager(AnimatedSprite powerup, ref Player player)
        {
            // Check if the powerup is of type 'RepairPowerup'
            if (!powerup.isActive && powerup is RepairPowerup)
                RepairPowerup.sequence((RepairPowerup)powerup, ref player);       
        }

        public static void collisionMade(AnimatedSprite powerup)
        {
            powerup.isActive = false;
        }

        public void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            // For every powerup in the game
            for (int i = 0; i < powerupList.Count; i++)               
                    // Draw it...
                    powerupList[i].Draw(ref spriteBatch, gameTime);

            spriteBatch.DrawString(Defines.spriteFontKootenay, "Number of powerups Active: " + (powerupList.Count), new Vector2(0, 300), Color.White);
        }

    }
}
