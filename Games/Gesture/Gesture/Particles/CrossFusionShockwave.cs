using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace Gesture
{
    public class CrossFusionShockwave : ParticleSystem
    {
        public CrossFusionShockwave(Game game, int howManyEffects)
            : base(game, howManyEffects)
        {
            isCollidable = true;
            damage = 10;
            blocksBullets = true;
            blocksLasers = true;
        }

        /// <summary>
        /// Set up the constants that will give this particle system its behavior and
        /// properties.
        /// </summary>
        protected override void InitializeConstants()
        {
            textureFilename = "effects/shockwave/shockwave";

            // less initial speed than the explosion itself
            //minInitialSpeed = 20;
            //maxInitialSpeed = 200;
            minInitialSpeed = 0;
            maxInitialSpeed = 10;

            // acceleration is negative, so particles will accelerate away from the
            // initial velocity.  this will make them slow down, as if from wind
            // resistance. we want the smoke to linger a bit and feel wispy, though,
            // so we don't stop them completely like we do ExplosionParticleSystem
            // particles.
            minAcceleration = 0;
            maxAcceleration = 0;

            // explosion smoke lasts for longer than the explosion itself, but not
            // as long as the plumes do.
            //minLifetime = 1.0f;
            //maxLifetime = 2.5f;
            minLifetime = 1.0f;
            maxLifetime = 2.0f;

            minScale = 2.0f;
            maxScale = 2.0f;

            minNumParticles = 2;
            maxNumParticles = 2;

            minRotationSpeed = 0;
            maxRotationSpeed = 0;

            spriteBlendMode = SpriteBlendMode.Additive;

            DrawOrder = AlphaBlendDrawOrder;

        }
    }
}
