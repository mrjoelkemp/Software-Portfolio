using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using System.Collections.Generic;

namespace Gesture
{
    class EnemyBase : AnimatedSprite
    {

        public enum EnemyState
        {
            NORMAL,
            EXPLOSION
        }

        /// <summary>
        /// Health points for the enemy.
        /// </summary>
        public int health;

        /// <summary>
        /// How many points are awarded for killing this enemy.
        /// </summary>
        public int pointValue;

        /// <summary>
        /// Tracks whether or not the enemy is still alive
        /// and can take damage.
        /// </summary>
        public bool isAlive;

        /// <summary>
        /// Speed is a vector to account for speed values particular to axes.
        /// i.e. We might want the speed along the X-axis to be different from 
        ///     the speed along the Y-axis.
        /// </summary>
        public Vector2 speed;

        public List<EnemyBullet> bullets = new List<EnemyBullet>();

        public EnemyBase(Game game) : base(game)          
        { }

        public new void Initialize()
        {
            base.Initialize();
        }

        public virtual void UpdateAnimation(GameTime gameTime)
        {
        }

        public void DecreaseHealth(int damageValue)
        {
            health = (int)MathHelper.Max(health - damageValue, 0f);
        }

        /// <summary>
        /// The enemy will no longer take damage and no longer
        /// be rendered.
        /// </summary>
        public virtual void Die()
        {
            isActive = false;
            isAlive = false;
        }

        /// <summary>
        /// Used to bring the enemy back to life for practice mode.
        /// Allows us to reuse space to prevent garbage collection.
        /// </summary>
        public virtual void ResetAttributes()
        {
            health = 1;
            isActive = true;
            isAlive = true;
        }
    }
}
