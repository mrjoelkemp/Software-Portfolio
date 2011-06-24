using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework;

namespace Gesture
{
    class ChargeBar : AnimatedSprite
    {
        /// <summary>
        /// List to hold the current charge states
        /// </summary>
        List<Texture2D> chargeBar = new List<Texture2D>();

        /// <summary>
        /// Store the amount of charge existing
        /// </summary>
        public static int currentCharge;

        /// <summary>
        /// Store the current number of charge
        /// </summary>
        public static float chargeAmount;

        /// <summary>
        /// The max possible amount of charge
        /// </summary>
        public const int MAX_CHARGE = 10;

        /// <summary>
        /// Store the (x,y) position of the chargebar
        /// </summary>
        public int chargeBar_xpos = 150;
        public int chargeBar_ypos = 160;

        /// <summary>
        /// Key index used in dictionary list
        /// </summary>
        public enum ChargeLevel
        {
            CHARGE
        }

        public ChargeBar(Game game) : base(game)
        {
            // Load up the charge states and add to dictionary list
            chargeBar.Add(game.Content.Load<Texture2D>("chargeBar/chargeBar"));
            chargeBar.Add(game.Content.Load<Texture2D>("chargeBar/chargeBar01"));
            chargeBar.Add(game.Content.Load<Texture2D>("chargeBar/chargeBar02"));
            chargeBar.Add(game.Content.Load<Texture2D>("chargeBar/chargeBar03"));
            chargeBar.Add(game.Content.Load<Texture2D>("chargeBar/chargeBar04"));
            chargeBar.Add(game.Content.Load<Texture2D>("chargeBar/chargeBar05"));
            chargeBar.Add(game.Content.Load<Texture2D>("chargeBar/chargeBar06"));
            chargeBar.Add(game.Content.Load<Texture2D>("chargeBar/chargeBar07"));
            chargeBar.Add(game.Content.Load<Texture2D>("chargeBar/chargeBar08"));
            chargeBar.Add(game.Content.Load<Texture2D>("chargeBar/chargeBar09"));
            chargeBar.Add(game.Content.Load<Texture2D>("chargeBar/chargeBar10"));
            base.animationList.Add((int)ChargeLevel.CHARGE, chargeBar);

            base.Initialize();

            // default with no charge
            currentCharge = 0;
            chargeAmount = 0.0f;
        }

        public override void Update(GameTime gameTime)
        {
            base.Update(gameTime);
        }

        public override void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            // Charge value in percentage
            spriteBatch.DrawString(Defines.spriteFontKootenay,
                "Charge: " + chargeAmount.ToString() + "%", new Vector2(0, 150),
                Defines.textColor);

            // Charge value represented graphically
            spriteBatch.Draw(chargeBar[currentCharge],
                new Rectangle(chargeBar_xpos, chargeBar_ypos, chargeBar[currentCharge].Width, chargeBar[currentCharge].Height),
                Defines.textColor);
        }

        public static void addCharge()
        {
            // Add 0.5% for every enemy killed
            chargeAmount += 0.5f;
            currentCharge = (int)chargeAmount / 10;

            // Check bounds of charge
            if (currentCharge >= MAX_CHARGE)
            {
                chargeAmount = 100.0f;
                currentCharge = 10;
            }
        }
    }
}
