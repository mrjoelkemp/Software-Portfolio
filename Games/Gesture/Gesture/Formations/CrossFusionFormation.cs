using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace Gesture
{
    /// <summary>
    /// Represents the "Cross" fusion formation that is triggered by two players
    /// entering fusion mode and signaling for the Line formation.
    /// The Cross fusion formation fires a huge shockwave.
    /// </summary>
    class CrossFusionFormation : FusionFormation
    {        
        public CrossFusionFormation(Game game, int shipWidth, int shipHeight, Vector2 pos)
        {
            //Remember the initial position
            base.fixedPoint = pos;
            base.game = game;
            //Set up the Line Formation
            NormalFormation p1NormalFormation = new NormalFormation(4, shipWidth, shipHeight, pos);
            p1NormalFormation.playerIndex = PlayerIndex.One;
            p1NormalFormation.usedByBothPlayers = false;
           
            //Set up the Line Formation
            LineFormation p2LineFormation = new LineFormation(4, shipWidth, shipHeight, pos);
            p2LineFormation.playerIndex = PlayerIndex.Two;
            p2LineFormation.usedByBothPlayers = false;            

            base.playerFormationList.Add(PlayerIndex.One, p1NormalFormation);
            base.playerFormationList.Add(PlayerIndex.Two, p2LineFormation);

            CrossFusionShockwave swave = new CrossFusionShockwave(game, 1);
            //Change the shockwave's color to green
            swave.color = Color.Green;
            if(!Defines.particleManager.HasTypeAlready(typeof(CrossFusionShockwave)))
                Defines.particleManager.Register(swave);
        }

        public override void Update(GameTime gameTime, Vector2 fixedPoint)
        {
            this.fixedPoint = fixedPoint;

            for (int i = 0; i < base.playerFormationList.Count; i++)
                //Update positions for sub-formations
                playerFormationList[(PlayerIndex)i].Update(gameTime, 4, fixedPoint);
                
            //Fire the powerup 

            //If we haven't fired already
            if (!hasFired)
            {
                //Add a shockwave to be rendered
                Defines.particleManager.AddParticleSystem(typeof(CrossFusionShockwave), this.fixedPoint);
                hasFired = true;
            }
            //Otherwise, we've already fired
            else
            {
                /*
                //Check if the particle system has finished rendering
                if (swave.hasFinishedRendering)
                {
                    //Remove the particle system from the manager
                    GameplayScreen.particleManager.Remove(swave.GetType());
                }*/
            }
            //Update textures
            //base.animatedSprite.Update(gameTime);

            base.Update(gameTime, fixedPoint);
        }

        public override void Draw(ref SpriteBatch spriteBatch, GameTime gameTime)
        {
            base.Draw(ref spriteBatch, gameTime);
        }
    }
}
