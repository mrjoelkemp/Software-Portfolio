using Microsoft.Xna.Framework;
namespace Gesture
{
    /// <summary>
    /// Base class for all game bullets.
    /// </summary>
    abstract class BulletBase : Sprite
    {
        /// <summary>
        /// The damage points for the bullet.
        /// </summary>
        public int damage;

        /// <summary>
        /// Speed at which the bullet travels.
        /// </summary>
        public Vector2 speed;


        public BulletBase(Game game)
            : base(game)
        {

        }

    }
}
