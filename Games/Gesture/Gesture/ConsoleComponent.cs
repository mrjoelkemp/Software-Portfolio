using System;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework;

namespace Gesture
{
    /// <summary>
    /// Prints debug text to the screen as GUI text.
    /// </summary>
    class ConsoleComponent
    {
        public Vector2 textPosition;
        public Rectangle textRectangle;

        public ConsoleComponent()
        {

        }

        public ConsoleComponent(Rectangle clientBounds)
        {
            textPosition = Vector2.Zero;
            textRectangle = new Rectangle(0, 0, 400, clientBounds.Height);
        }

        public void Draw(String text, ref SpriteFont spriteFont, ref SpriteBatch spriteBatch)
        {
            spriteBatch.DrawString(spriteFont, text, textPosition, Defines.textColor);
            //Set up the text position for the next incoming string.
            textPosition.Y += 25;   //25 Pixels is a good offset.
            MathHelper.Clamp(textPosition.X, 0, textRectangle.Width);
            MathHelper.Clamp(textPosition.Y, 0, textRectangle.Height);

        }
    }
}
