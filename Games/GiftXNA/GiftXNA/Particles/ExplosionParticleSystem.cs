#region File Description
//-----------------------------------------------------------------------------
// ExplosionParticleSystem.cs
//
// Microsoft XNA Community Game Platform
// Copyright (C) Microsoft Corporation. All rights reserved.
//-----------------------------------------------------------------------------
#endregion

#region Using Statements
using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
#endregion

/// <summary>
/// ExplosionParticleSystem is a specialization of ParticleSystem which creates a
/// fiery explosion. It should be combined with ExplosionSmokeParticleSystem for
/// best effect.
/// </summary>
public class ExplosionParticleSystem : ParticleSystem
{
    public ExplosionParticleSystem(Game game, int howManyEffects)
        : base(game, howManyEffects)
    {}

    /// <summary>
    /// Set up the constants that will give this particle system its behavior and
    /// properties.
    /// </summary>
    protected override void InitializeConstants()
    {
        //textureFilename = "explosionSmall";
        textureFilename = "sparks";

        minInitialSpeed = 10;
        maxInitialSpeed = 20;

        minAcceleration = -30;
        maxAcceleration = -40;

        // explosions should be relatively short lived
        minLifetime = 1.0f;
        maxLifetime = 1.5f;

        minScale = 0.5f;
        maxScale = 1.0f;

        minNumParticles = 3;
        maxNumParticles = 7;

        minRotationSpeed = 0;
        maxRotationSpeed = 0;

        // additive blending is very good at creating fiery effects.
        spriteBlendMode = SpriteBlendMode.AlphaBlend;

        //DrawOrder = AdditiveDrawOrder;
    }

    protected override void InitializeParticle(Particle p, Vector2 where)
    {
        base.InitializeParticle(p, where);
        
        // The base works fine except for acceleration. Explosions move outwards,
        // then slow down and stop because of air resistance. Let's change
        // acceleration so that when the particle is at max lifetime, the velocity
        // will be zero.

        // We'll use the equation vt = v0 + (a0 * t). (If you're not familar with
        // this, it's one of the basic kinematics equations for constant
        // acceleration, and basically says:
        // velocity at time t = initial velocity + acceleration * t)
        // We'll solve the equation for a0, using t = p.Lifetime and vt = 0.
        p.Acceleration = -p.Velocity / p.Lifetime;
    }
}
