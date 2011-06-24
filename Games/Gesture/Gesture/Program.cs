using System;

namespace Gesture
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        static void Main(string[] args)
        {
            using (ProjectGesture game = new ProjectGesture())
            {
                game.Run();
            }
        }
    }
}

