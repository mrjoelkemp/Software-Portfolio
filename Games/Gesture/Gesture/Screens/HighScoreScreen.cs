using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Audio;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.GamerServices;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using Microsoft.Xna.Framework.Media;
using Microsoft.Xna.Framework.Net;
using Microsoft.Xna.Framework.Storage;
using System.Text;

namespace Gesture
{
    class HighScoreScreen : GameScreen
    {
        #region Initialization
        Texture2D titleTexture;
        //GraphicsDeviceManager graphics;
        SpriteBatch spriteBatch;
        SpriteFont spriteFont;
        ContentManager content;

        Network network;

        /* What's currently being displayed about what's going on on the screen?
         */
        List<Text> events = new List<Text>();

        public HighScoreScreen(Game game)
        {
            //TODO: Add HighScore initialization
            /* Step 1: Attach the storage to the game, and sign up for events for highscores saved/loaded. */
            Storage st = Storage.Attach(game, false);
            st.HighscoresChanged += this.HighscoresChanged;
            st.LoadComplete += new EventHandler(st_LoadComplete);
            st.NewHighscoreFound += new HighscoreEventHandler(st_NewHighscoreFound);
            st.SaveComplete += new EventHandler(st_SaveComplete);
            st.UserRefusedStorage += new EventHandler(st_UserRefusedStorage);
            /* If you don't sign up for StorageDeviceNeeded, the component can do default management of 
             * storage devices using the standard Xna storage device selection dialog.
             */
            if (!st.StartLoading())
            {
                st.ReselectStorage();
            }

            /* Step 2: Attach the network component to the game. This must be done after the storage 
             * component has been attached.
             * */
            Network nw = Network.Attach(game);
            /* ShareSomeHighscores() is the easy way to make networked highscore sharing work. There 
             * are more advanced versions too, especally useful if you also want to support network 
             * play in your game. See the file in question for those.
             */
            nw.ShareSomeHighscores();
            nw.SessionDisconnected += new EventHandler(nw_SessionDisconnected);
            nw.SessionEstablished += new SessionEstablishedHandler(nw_SessionEstablished);
            nw.TryingConnection += new EventHandler(nw_TryingConnection);
            nw.GamerJoined += new GamerEventHandler(nw_GamerJoined);
            nw.GamerLeft += new GamerEventHandler(nw_GamerLeft);
            network = nw;
        }

        

        #region Network Stuff
        void st_UserRefusedStorage(object sender, EventArgs e)
        {
            /* If the user refused to select storage, this event is fired. This means 
             * that the highscores component will not be able to load old scores, or save 
             * new scores, until a storage device is selected. You can call ReselectStorage()
             * to try again sometime later, or provide a StorageDevice yourself.
             * On PC, the storage device selection always succeeds, so this won't be called.
             */
            PrintEvent("User Refused Storage");
        }

        void nw_GamerLeft(object sender, GamerEventArgs e)
        {
            /* If a gamer leaves the highscores network session, you get told about it here. */
            PrintEvent("GamerLeft: " + e.Gamer.Gamertag);
        }

        void nw_GamerJoined(object sender, GamerEventArgs e)
        {
            /* If a gamer joins the highscores network session, you get told about it here. */
            PrintEvent("GamerJoined: " + e.Gamer.Gamertag);
        }

        void nw_TryingConnection(object sender, EventArgs e)
        {
            /* When the networked session matching tries to create a new session, you're told about
             * it here. You can use this to start drawing a small animation in a corner of the screen,
             * for example.
             */
            PrintEvent("Retrying Connection");
        }

        void nw_SessionEstablished(object sender, SessionEstablishedEventArgs e)
        {
            /* When a network session is established for highscores, you're told about it here.
             */
            PrintEvent("Session Established: " + e.Session.Host.Gamertag);
        }

        void nw_SessionDisconnected(object sender, EventArgs e)
        {
            /* The network session for highscores has gone away.
             */
            PrintEvent("Session Disconnected");
            /* At this point, I'd just like to re-start the network logic to share with some other 
             * available session.
             */
            Network.Instance.ShareSomeHighscores();
        }

        void st_SaveComplete(object sender, EventArgs e)
        {
            /* Each time highscores have been successfully saved to disk, this event is called. 
             * This will include after highscores have been received from the network and saved
             * to disk.
             */
            PrintEvent("SaveComplete");
        }

        void st_NewHighscoreFound(object sender, HighscoreEventArgs e)
        {
            /* Whenever a new highscore is found/added, this event is called.
             */
            PrintEvent(String.Format("NewHighscoreFound {0} {1} {2} {3} {4} {5}",
              e.FromNetwork, e.Score.Gamertag, e.Score.Score, e.Score.Gametype,
              e.RankInGametype, e.RankInGamertag));
            /* Re-build the display text if I'm currently viewing the highscores tables.
             */
            if (isHighscores)
            {
                BuildHighscoreTexts();
            }
        }

        void st_LoadComplete(object sender, EventArgs e)
        {
            /* When highscores have been loaded from disk, this event is raised.
             */
            PrintEvent("LoadComplete");
        }

        public void HighscoresChanged(object sender, EventArgs e)
        {
            /* When the active set of highscores changes, this event is raised.
             * Generally, this means that you have to re-display the current set 
             * of scores, if they are currently visible to the user.
             */
            PrintEvent("HighscoresChanged");
            if (isHighscores)
            {
                BuildHighscoreTexts();
            }
        }

        /* A helper function to add some information about what's going on to the scrolling 
         * display of text on the screen. This is used by the demo game to show what's going 
         * on, and probably won't be part of a real game.
         */
        void PrintEvent(string str)
        {
            for (int i = 0; i < events.Count; ++i)
            {
                events[i].Color.A = (byte)(events[i].Color.A - 10);
            }
            Text t = new Text(new Vector2(400, 80 + events.Count * 20), str);
            events.Add(t);
            AddText(t);
            if (events.Count > 25)
            {
                RemoveText(events[0]);
                events.RemoveAt(0);
                for (int i = 0; i < events.Count; ++i)
                {
                    events[i].Pos.Y -= 20;
                }
            }
        }

        #endregion
        
        public override void LoadContent()
        {
            titleTexture = ScreenManager.Game.Content.Load<Texture2D>("misc/title");

            //spriteBatch = new SpriteBatch(GraphicsDevice);

            ///* I name my font resource "Text," so that I know what it's used for. 
            // * The actual font used may be changed without changing the resource name.
            // */
            //spriteFont = Game.Content.Load<SpriteFont>("Text");
            if (content == null)
            {
                content = new ContentManager(ScreenManager.Game.Services, "Content");
            }

            spriteBatch = new SpriteBatch(ScreenManager.GraphicsDevice);
            //spriteBatch = new SpriteBatch(GraphicsDevice);
            spriteFont = content.Load<SpriteFont>("fonts/Kootenay");
            /* Add some informative text to the screen. This is my "main menu."
             */
            AddText(new Text(new Vector2(80, 60), "Highscores Test"));
            AddText(new Text(new Vector2(80, 82), "A) Add Highscore for you"));
            AddText(new Text(new Vector2(80, 104), "B) Add Highscore for random"));
            AddText(new Text(new Vector2(80, 126), "X) View Highscores"));
            AddText(new Text(new Vector2(80, 148), "Y) Save Highscores"));
            AddText(new Text(new Vector2(80, 170), "START) Clear Highscores"));
            AddText(new Text(new Vector2(80, 192), "RB) Trim Highscores"));
            AddText(autosaveText = new Text(new Vector2(80, 214), "LB) Autosave is OFF"));

            /* Make sure the sound effect is loaded so it can be played as soon as the 
             * user does any UI input.
             */
            base.LoadContent();
        }

        /* A random number generator that I can use at will (for non-deterministic things).
         */
        static Random r = new Random();

        /* Text to update when auto-saving
         */
        Text autosaveText;

        /* Input state for gamepad and keyboard. In a real game, that part of the game loop
         * would probably live in its own class/component, rather than in the main game class.
         */
        GamePadState oldGp, curGp;
        KeyboardState oldKb, curKb;

        /* Generate an authentic-looking distribution of X-box Live gamertag texts.
         */
        static string[] namePieces = new string[] {
      "Weed", "Pot", "Smoker", "Blunt", "Joint", "420",   //  potheads
      "Westside", "Gangster", "Killer", "805",            //  gees
      "XXX", "Sexy",                                      //  posers
    };
        string GetRandomName()
        {
            return namePieces[r.Next(namePieces.Length)] + " "
              + namePieces[r.Next(namePieces.Length)];
        }

        #endregion

        #region Handle Input
        public override void HandleInput(InputState input)
        {
            if (input.IsNewButtonPress(Buttons.DPadUp))
                ExitScreen();
            

                oldGp = curGp;
                curGp = GamePad.GetState(PlayerIndex.One);
                oldKb = curKb;
                curKb = Keyboard.GetState(PlayerIndex.One);

                //if ((curGp.IsButtonDown(Buttons.A) && !oldGp.IsButtonDown(Buttons.A))
                //  || (curKb.IsKeyDown(Keys.A) && !oldKb.IsKeyDown(Keys.A)))
                if (input.IsNewButtonPress(Buttons.A))
                {
                    /* A adds highscore for currently signed in gamer.
                     */
                    // click.Play();
                    AddHighscore(SignedInGamer.SignedInGamers[PlayerIndex.One]);
                }
                //if ((curGp.IsButtonDown(Buttons.B) && !oldGp.IsButtonDown(Buttons.B))
                //  || (curKb.IsKeyDown(Keys.B) && !oldKb.IsKeyDown(Keys.B)))
                if (input.IsNewButtonPress(Buttons.B))
                {
                    /* B adds a random highscore
                     */
                    // click.Play();
                    AddHighscore();
                }
                //if ((curGp.IsButtonDown(Buttons.X) && !oldGp.IsButtonDown(Buttons.X))
                //  || (curKb.IsKeyDown(Keys.X) && !oldKb.IsKeyDown(Keys.X)))
                if (input.IsNewButtonPress(Buttons.X))
                {
                    /* X toggles display of main menu or highscores.
                     */
                    // click.Play();
                    ToggleHighscores();
                }
                //if ((curGp.IsButtonDown(Buttons.Y) && !oldGp.IsButtonDown(Buttons.Y))
                //  || (curKb.IsKeyDown(Keys.Y) && !oldKb.IsKeyDown(Keys.Y)))
                if (input.IsNewButtonPress(Buttons.Y))
                {
                    /* Y attempts to save scores to disk, and re-selects storage if 
                     * there's no currently active storage.
                     */
                    // click.Play();
                    if (!Storage.Instance.StartSaving())
                    {
                        Storage.Instance.ReselectStorage();
                    }
                }
                //if ((curGp.IsButtonDown(Buttons.Start) && !oldGp.IsButtonDown(Buttons.Start))
                //  || (curKb.IsKeyDown(Keys.Enter) && !oldKb.IsKeyDown(Keys.Enter)))
                if (input.IsNewButtonPress(Buttons.Start) || input.IsNewKeyPress(Keys.Enter))
                {
                    /* Clear anything having to do with higscores. If the user had previously 
                     * refused storage, start asking for new storage.
                     */
                    // click.Play();
                    if (!Storage.Instance.ClearLoaded())
                    {
                        Storage.Instance.ReselectStorage();
                    }
                    /* And update the display of highscores.
                     */
                    if (isHighscores)
                    {
                        BuildHighscoreTexts();
                    }
                }
                //if ((curGp.IsButtonDown(Buttons.LeftShoulder) && !oldGp.IsButtonDown(Buttons.LeftShoulder))
                //  || (curKb.IsKeyDown(Keys.LeftControl) && !oldKb.IsKeyDown(Keys.LeftControl)))
                if (input.IsNewButtonPress(Buttons.LeftShoulder))
                {
                    /* Toggle auto-save on score update. Games that are sensitive to storage latency 
                     * may want to have auto-save off. Games that want the utmost of convenience will 
                     * want it on. A warning, though: when auto-save is on, it may take a little while 
                     * (a few seconds) after a highscore is recorded until it's actually safely saved 
                     * on disk.
                     */
                    // click.Play();
                    Storage.Autosave = !Storage.Autosave;
                    autosaveText.Str = "LB) Autosave is " + (Storage.Autosave ? "ON" : "OFF");
                }
                //if ((curGp.IsButtonDown(Buttons.RightShoulder) && !oldGp.IsButtonDown(Buttons.RightShoulder))
                //  || (curKb.IsKeyDown(Keys.RightControl) && !oldKb.IsKeyDown(Keys.RightControl)))
                if (input.IsNewButtonPress(Buttons.RightShoulder))
                {
                    /* Filter highscores. This purges some highscores older than a week, and purges 
                     * highscores older than three months more.
                     */
                    // click.Play();
                    Storage.Instance.KeepSomeHighscores(null);
                }
                //if ((curGp.IsButtonDown(Buttons.DPadLeft) && !oldGp.IsButtonDown(Buttons.DPadLeft))
                //  || (curKb.IsKeyDown(Keys.Left) && !oldKb.IsKeyDown(Keys.Left)))
                if (input.IsNewButtonPress(Buttons.DPadLeft))
                {
                    /* Toggle game type leftwards when displaying highscores.
                     */
                    // click.Play();
                    if (isHighscores)
                    {
                        if (gametypeFilter == -1)
                            gametypeFilter = gametypes.Length;
                        --gametypeFilter;
                        BuildHighscoreTexts();
                    }
                }
                //if ((curGp.IsButtonDown(Buttons.DPadRight) && !oldGp.IsButtonDown(Buttons.DPadRight))
                //  || (curKb.IsKeyDown(Keys.Right) && !oldKb.IsKeyDown(Keys.Right)))
                if (input.IsNewButtonPress(Buttons.DPadRight))
                {
                    /* Toggle game type rightwards when displaying highscores.
                     */
                    // click.Play();
                    if (isHighscores)
                    {
                        ++gametypeFilter;
                        if (gametypeFilter == gametypes.Length)
                            gametypeFilter = -1;
                        BuildHighscoreTexts();
                    }
}
            //if (curGp.IsButtonDown(Buttons.Back) || curKb.IsKeyDown(Keys.Escape))
            //{
            //    /* Back or Excape exits the game. Obviously, no real game would do this.
            //     */
            //    // click.Play();
            //    Exit();
            //}


            base.HandleInput(input);
        }
        #endregion

        #region Update
        public override void Update(GameTime gameTime, bool otherScreenHasFocus, bool coveredByOtherScreen)
        {
            /* Move the "current state" to "old state" for input,
          * and read new input.
          */
          
            /* Updating the base Game will update the components, which takes care of 
             * periodic tasks needed by Storage and Networking.
             */            
            base.Update(gameTime, otherScreenHasFocus, coveredByOtherScreen);
        }
        #endregion

        #region Draw Stuff
        /* True if in highscores display mode.
         */
        bool isHighscores;
        /* Texts displayed for the current highscores screen
         */
        List<Text> hiscoreText = new List<Text>();
        /* Filter what highscores are visible. -1 means all types.
         */
        int gametypeFilter = -1;

        /* Given the current highscore state, build a number of text items to display the 
         * scores on the screen. The text items are drawn inside the draw callback by this
         * game.
         */
        void BuildHighscoreTexts()
        {
            hiscoreText.Clear();
            /* Find the scores I want to display, based on filtering.
             */
            Highscore[] scores = Storage.Instance.QueryHighscores(null,
              gametypeFilter == -1 ? null : gametypes[gametypeFilter], null, null, 20);
            hiscoreText.Add(new Text(new Vector2(200, 60), gametypeFilter == -1 ? "All Highscores"
              : gametypes[gametypeFilter] + " Highscores"));
            /* For each score found, create the different columns of display text.
             */
            for (int i = 0; i < scores.Length; ++i)
            {
                Highscore hs = scores[i];
                hiscoreText.Add(new Text(new Vector2(80, 100 + 20 * i), hs.Date.ToShortDateString()));
                hiscoreText.Add(new Text(new Vector2(260, 100 + 20 * i), hs.Gamertag));
                hiscoreText.Add(new Text(new Vector2(460, 100 + 20 * i), hs.Gametype));
                hiscoreText.Add(new Text(new Vector2(660, 100 + 20 * i), hs.Score.ToString()));
                hiscoreText.Add(new Text(new Vector2(800, 100 + 20 * i), hs.Statistic.ToString()));
                hiscoreText.Add(new Text(new Vector2(850, 100 + 20 * i), hs.Note));
            }
        }

        /* Switch between highscores display and main screen display.
         */
        void ToggleHighscores()
        {
            isHighscores = !isHighscores;
            if (isHighscores)
            {
                BuildHighscoreTexts();
                displayText = hiscoreText;
            }
            else
            {
                displayText = texts;
            }
        }

        /* Add a random highscore. Used to populate the table for testing. 
         * If there is no signed in gamer, use the word "Guest."
         */
        void AddHighscore(SignedInGamer g)
        {
            AddHighscore((g == null) ? "Guest" : g.Gamertag, false);
        }

        /* Add a random highscore. Used to populate the highscores table for 
         * testing purposes. This version uses a randomly generated "gamertag" name.
         */
        void AddHighscore()
        {
            AddHighscore(GetRandomName(), true);
        }

        /* This game has four game types, 0 through 3.
         * This array has one entry for each type to display the name of each type.
         */
        static string[] gametypes = new string[] {
      "Deathmatch", "Politics", "Group Hugs", "S & M"
    };

        /* Record a random highscore for the given name, assuming a source of either 
         * network or local. Network vs Local matters because a certain number of 
         * local scores are always remembered, even if the network scores are all 
         * much higher.
         */
        void AddHighscore(string name, bool network)
        {
            int stat = r.Next(10) + 1;
            Highscore hs = new Highscore(
              new DateTime(Timing.NowTicks - (r.Next() & 0xffff) * 1000000000L),
              name, gametypes[r.Next(gametypes.Length)], r.Next(10000) * 10 * stat, stat,
              "note");
            Storage.Instance.AddHighscore(hs, network);
        }

        /* Texts used by the main screen.
         */
        List<Text> texts = new List<Text>();

        /* What texts are actually being displayed (highscores, or main screen)
         */
        List<Text> displayText;

        /* Draw the currently active texts to screen.
         */
        public void DrawTexts()
        {
            if (displayText == null)
                displayText = texts;
            spriteBatch.Begin();
            foreach (Text t in displayText)
            {
                spriteBatch.DrawString(spriteFont, t.Str, t.Pos, t.Color);
            }
            spriteBatch.End();
        }

        /* Add a text item to the main screen.
         */
        public void AddText(Text t)
        {
            texts.Add(t);
        }

        /* Remove a text item from the main screen.
         */
        public void RemoveText(Text t)
        {
            texts.Remove(t);
        }

        #endregion

        public override void Draw(GameTime gameTime)
        {
            Viewport viewport = ScreenManager.GraphicsDevice.Viewport;
            Vector2 viewportSize = new Vector2(viewport.Width, viewport.Height);

            // title
            Vector2 titlePosition = new Vector2(
                (viewportSize.X - titleTexture.Width) / 2f,
                viewportSize.Y * 0.18f);
            titlePosition.Y -= (float)Math.Pow(TransitionPosition, 2) * titlePosition.Y;
            Color titleColor = Color.White;

            ScreenManager.SpriteBatch.Begin();
            ScreenManager.SpriteBatch.Draw(titleTexture, titlePosition,
                new Color(titleColor.R, titleColor.G, titleColor.B, TransitionAlpha));

            /* Draw the currently active text.
             */
            DrawTexts();

            /* The highscores and network components don't currently draw anything, but 
             * other components might. Also, at some point in the future, the components 
             * may start drawing overlays to show diagnostic information.
             */

            ScreenManager.SpriteBatch.End();
            base.Draw(gameTime);
        }

        public override void UnloadContent()
        {
            if (spriteBatch != null)
            {
                spriteBatch.Dispose();
                spriteBatch = null;
            }

            content.Unload();
            base.UnloadContent();
        }
    }
}

    /* Text represents one line of coherent text on the screen. Multiple 
     * columns on a single row would be expressed as multiple Text instances.
     */
    public class Text
    {
        public Text(Vector2 p, string s)
        {
            Pos = p;
            Str = s;
        }
        public Color Color = Color.White;
        public Vector2 Pos;
        public string Str;
    }

