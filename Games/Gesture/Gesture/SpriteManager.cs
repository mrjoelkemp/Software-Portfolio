using System;
using Microsoft.Xna.Framework;
using System.Collections.Generic;
using Microsoft.Xna.Framework.Graphics;

namespace Gesture
{
    class SpriteManager
    {
        /// <summary>
        /// Manages a list of sprites to draw.
        /// </summary>
        public List<AnimatedSprite> spriteList = new List<AnimatedSprite>();

        public SpriteManager(Game game)
        {}

        public void Initialize()
        {
            int _spriteCount = spriteList.Count;

            if (_spriteCount > 0)
                for (int i = 0; i < _spriteCount; i++)
                    spriteList[i].Initialize();
        }

        public void Update(GameTime gameTime)
        {
            int _spriteCount = spriteList.Count;

            if(_spriteCount > 0)
                for (int i = 0; i < _spriteCount; i++)
                    if (spriteList[i].isActive)
                        spriteList[i].Update(gameTime);
        }

        public void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            int _spriteCount = spriteList.Count;

            if (_spriteCount > 0)            
                for (int i = 0; i < _spriteCount; i++)
                    if (spriteList[i].isActive)
                        spriteList[i].Draw(ref spriteBatch, gameTime);
        }

        public void ShowStats(ref SpriteBatch spriteBatch)
        {
            int activeCount = 0;
            for (int i = 0; i < spriteList.Count; i++)
                if (spriteList[i].isActive)
                    activeCount++;

            spriteBatch.DrawString(Defines.spriteFontKootenay, "Sprite Count: " + spriteList.Count, new Vector2(0, 250), Defines.textColor);
            spriteBatch.DrawString(Defines.spriteFontKootenay, "Active SpriteCount: " + activeCount, new Vector2(0, 275), Defines.textColor);
        }
    }
}
