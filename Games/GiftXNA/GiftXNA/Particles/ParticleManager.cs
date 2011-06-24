using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using System;

/// <summary>
/// Controls the creation, updating, drawing, and removal of all the game's
/// particle systems.
/// </summary>
public class ParticleManager
{
    /// <summary>
    /// Pointer to the current game instance.
    /// </summary>
    private Game game;

    /// <summary>
    /// Keeps track of the types of particle systems 
    /// registered to the system. Serves as a list of ID's.
    /// </summary>
    private List<Type> particleSystemTypes;

    public ParticleManager(Game game)
    {
        //particleSystemList = new List<ParticleSystem>();
        particleSystemTypes = new List<Type>();
        this.game = game;
    }

    /// <summary>
    /// Allows a new particle system to be managed by the particle
    /// manager.
    /// </summary>
    /// <param name="psystem"></param>
    public void Register(ParticleSystem psystem)
    {
        //Remember the type of the passed particle system
        particleSystemTypes.Add(psystem.GetType());
        //Add the new particle system to the game's components
        game.Components.Add(psystem);
    }

    /// <summary>
    /// Helper to determine if the manager is already managing a
    /// system with the type passed in.
    /// </summary>
    /// <param name="particleType"></param>
    /// <returns></returns>
    public bool HasTypeAlready(Type particleType)
    {
        return particleSystemTypes.Exists(delegate(Type x) { return x == particleType; });
    }

    /// <summary>
    /// Removes a particle system from the manager's particle
    /// system list. 
    /// </summary>
    /// <param name="particleSystemType">The Type of the particle system to be removed.</param>
    public void Remove(Type particleSystemType)
    {
        //Remove the id from our list
        particleSystemTypes.Remove(particleSystemType);
        //Remove the particle system from the game's components.
        Object particleSystem = game.Services.GetService(particleSystemType);
        game.Components.Remove((IGameComponent)particleSystem);
        
    }

    /// <summary>
    /// Helper to find the index of a particle system, identified by type, 
    /// in the game's component list.
    /// </summary>
    /// <param name="type"></param>
    /// <returns></returns>
    private int FindParticleIndexFromType(Type type)
    {
        //Find the particle system with that type
        //Get index of particle system in game component list
        int index = 0;
        for (int i = 0; i < game.Components.Count; i++)
            if (game.Components[i].GetType() == type)
            {
                index = i;
                break;
            }
        return index;
    }

    /// <summary>
    /// Get the list of registered particle systems that are
    /// collidable with other objects.
    /// </summary>
    /// <returns>A list of collidable particle systems.</returns>
    public List<ParticleSystem> GetCollidableParticleSystems()
    {
        List<ParticleSystem> result = new List<ParticleSystem>();

        for (int i = 0; i < this.particleSystemTypes.Count; i++)
        {
            //Find the index of the particle system type
            int _index = this.FindParticleIndexFromType(particleSystemTypes[i]);
            //Get that particle system
            ParticleSystem _system = (ParticleSystem)game.Components[_index];
            //If it's collidable
            if (_system.isCollidable)
                //Add it to the results list.
                result.Add(_system);
        }

        return result;
    }

    /// <summary>
    /// Add a particle to be rendered.
    /// </summary>
    /// <param name="type">The typeof particle system class. </param>
    /// <param name="where"></param>
    public void AddParticleSystem(Type type, Vector2 where)
    {
        int index = FindParticleIndexFromType(type);
        ((ParticleSystem)game.Components[index]).AddParticles(where);
    }

    public void Update(GameTime gameTime)
    {

    }

    public void Draw(SpriteBatch spriteBatch, GameTime gameTime)
    {
        /*
        // draw some instructions on the screen
        string message = string.Format(
            "Free particles:\n" +
            "    ExplosionParticleSystem:      {1}\n" +
            "    ExplosionSmokeParticleSystem: {2}\n" +
            "    SmokePlumeParticleSystem:     {3}\n" +
            "    ShockwaveParticleSystem:     {4}",
            null, explosion.FreeParticleCount,
            smoke.FreeParticleCount, smokePlume.FreeParticleCount, shockwave.FreeParticleCount);

        spriteBatch.DrawString(Defines.spriteFontKootenay, message, new Vector2(0, 500), Defines.textColor);
        */
    }
}
