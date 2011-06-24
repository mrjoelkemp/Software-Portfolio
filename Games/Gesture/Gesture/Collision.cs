
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using System;
using System.Collections.Generic;
namespace Gesture
{

    /// <summary>
    /// Handles all collision checks between Sprites.
    /// Functions handle all possibilities of collisions between bounding rectangles
    /// and bounding spheres.
    /// </summary>
    class Collision
    {
        public static bool PlayerWithEnemy(Sprite player, Sprite enemy)
        {
            return IsSpriteCollision(player, enemy);
        }

        public static bool PlayerBulletWithEnemy(PlayerBullet bullet, Sprite enemy)
        {
            return IsSpriteCollision(bullet, enemy);
        }

        public static bool PlayerWithEnemyBullet(Sprite player, EnemyBullet enemyBullet)
        {
            return IsSpriteCollision(player, enemyBullet);
        }
        public static bool PlayerWithPowerup(Sprite player, Sprite powerup)
        {
            return IsSpriteCollision(player, powerup);
        }

        public static bool EnemyWithParticleSystem(ParticleSystem system, Sprite enemy)
        {
            //Get the list of active particles' bounding spheres.
            List<BoundingSphere> pSpheres = system.GetActiveParticlesSpheres();
            
            //Check the particle spheres against the enemy's general bounding sphere

            foreach (BoundingSphere s in pSpheres)
                //If there is a collision
                if (s.Intersects(enemy.generalBoundingSphere))
                {
                    //Check the more detailed spheres
                    foreach (BoundingSphere es in enemy.boundingSphereList)
                        if (s.Intersects(es))
                            return true;
                }
            return false;
        }

        /// <summary>
        /// Handles the universal (bounding box and sphere) collision checks between two passed in sprites.
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns>True if collision occurs, false otherwise.</returns>
        private static bool IsSpriteCollision(Sprite s1, Sprite s2)
        {
            //Bounding Box Collision
            if (s1.useBoundingBox && s2.useBoundingBox)
                //return IntersectRectangles(player.boundingBox, enemy.boundingBox);
                return s1.boundingBox.Intersects(s2.boundingBox);

            //Sphere with box
            else if (!s1.useBoundingBox && s2.useBoundingBox)
            { 
                foreach (BoundingSphere b in s1.boundingSphereList)
                    if (b.Intersects(s2.boundingBox))
                        return true;
            }
            //Box with Sphere
            else if (s1.useBoundingBox && !s2.useBoundingBox)
            {
                //Check general sphere
                if(s1.boundingBox.Intersects(s2.generalBoundingSphere))
                    foreach (BoundingSphere b in s2.boundingSphereList)
                        if (b.Intersects(s1.boundingBox))
                            return true;
            }
            //Sphere with sphere
            else if (!s1.useBoundingBox && !s2.useBoundingBox)
            {
                //Check general bounding spheres for collision
                if (s1.generalBoundingSphere.Intersects(s2.generalBoundingSphere))
                    //If so, check detailed bounding sphere list
                    foreach (BoundingSphere a in s1.boundingSphereList)
                        foreach (BoundingSphere b in s2.boundingSphereList)
                            if (a.Intersects(b))
                                return true;
                
            }
            return false;
    
        }

        /// <summary>
        /// Determines whether two bounding spheres intersect/collide.
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns></returns>
        private bool IntersectSpheres(BoundingSphere a, BoundingSphere b)
        {
            return a.Intersects(b);
        }

        /// <summary>
        /// Determines if there is overlap of the non-transparent pixels
        /// between two sprites.
        /// </summary>
        /// <param name="rectangleA">Bounding rectangle of the first sprite</param>
        /// <param name="dataA">Pixel data of the first sprite</param>
        /// <param name="rectangleB">Bouding rectangle of the second sprite</param>
        /// <param name="dataB">Pixel data of the second sprite</param>
        /// <returns>True if non-transparent pixels overlap; false otherwise</returns>
        private static bool IntersectPixels(Rectangle rectangleA, Color[] dataA,
                                    Rectangle rectangleB, Color[] dataB)
        {
            // Find the bounds of the rectangle intersection
            int top = Math.Max(rectangleA.Top, rectangleB.Top);
            int bottom = Math.Min(rectangleA.Bottom, rectangleB.Bottom);
            int left = Math.Max(rectangleA.Left, rectangleB.Left);
            int right = Math.Min(rectangleA.Right, rectangleB.Right);

            // Check every point within the intersection bounds
            for (int y = top; y < bottom; y++)
            {
                for (int x = left; x < right; x++)
                {
                    // Get the color of both pixels at this point
                    Color colorA = dataA[(x - rectangleA.Left) +
                                         (y - rectangleA.Top) * rectangleA.Width];
                    Color colorB = dataB[(x - rectangleB.Left) +
                                         (y - rectangleB.Top) * rectangleB.Width];

                    // If both pixels are not completely transparent,
                    if (colorA.A != 0 && colorB.A != 0)
                    {
                        // then an intersection has been found
                        return true;
                    }
                }
            }

            // No intersection found
            return false;
        }//end IntersectPixels()

        /// <summary>
        /// Simple rectangle collision detection.
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns></returns>
        private static bool IntersectRectangles(Rectangle a, Rectangle b)
        {
            if(a.Intersects(b))
                return true;

            return false;
        }
    }
}
