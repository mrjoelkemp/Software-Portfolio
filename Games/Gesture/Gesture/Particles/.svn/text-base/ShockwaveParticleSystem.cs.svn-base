using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace Gesture
{
    public class ShockwaveParticleSystem : ParticleSystem
    {
        public ShockwaveParticleSystem(Game game, int howManyEffects)
            : base(game, howManyEffects)
        { }

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
            minInitialSpeed = 10;
            maxInitialSpeed = 20;

            // acceleration is negative, so particles will accelerate away from the
            // initial velocity.  this will make them slow down, as if from wind
            // resistance. we want the smoke to linger a bit and feel wispy, though,
            // so we don't stop them completely like we do ExplosionParticleSystem
            // particles.
            minAcceleration = -10;
            maxAcceleration = -50;

            // explosion smoke lasts for longer than the explosion itself, but not
            // as long as the plumes do.
            //minLifetime = 1.0f;
            //maxLifetime = 2.5f;
            minLifetime = 1.0f;
            maxLifetime = 1.5f;

            // minScale = 1.0f;
            // maxScale = 2.0f;
            minScale = 1.0f;
            maxScale = 1.5f;

            minNumParticles = 10;
            maxNumParticles = 20;

            minRotationSpeed = -MathHelper.PiOver4;
            maxRotationSpeed = MathHelper.PiOver4;

            spriteBlendMode = SpriteBlendMode.Additive;

            DrawOrder = AlphaBlendDrawOrder;

        }
    }
}
