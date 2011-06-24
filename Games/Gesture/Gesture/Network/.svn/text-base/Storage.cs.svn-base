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
using System.IO;
using System.Diagnostics;
using System.Threading;

namespace Gesture
{
  /// <summary>
  /// Highscores are managed by the Storage class. It allows you to read 
  /// highscores from disk, to add highscores, and to write highscores back to disk.
  /// You can provide the storage device to use yourself, or you can let the component 
  /// deal with this for you.
  /// 
  /// Also, the component will create and install a GamerServicesComponent if you 
  /// haven't already added that to the Game when you initialize it. You do so by 
  /// calling Storage.Attach(yourGame), which does all the initialization 
  /// necessary.
  /// 
  /// Highscores have the following parameters:
  /// - Date -- when the highscore was recorded
  /// - Gamertag -- the gamertag of the player (or "Guest" if not signed in)
  /// - Gametype -- the (optional) type of game for the score
  /// - Score -- the actual score value (used for ranking)
  /// - Statistic -- some integer you choose to tag along with the score; for example "top level achieved"
  /// - Note -- some string you coose to tag along with the score; purely informational; for example "opponent"
  ///
  /// Communication with the component is mostly through call-ins that start operations, 
  /// and events calling back within the Update() function for cmpleted operations. Most 
  /// time-consuming operations are run in a worker thread, to allow multi-tasking with 
  /// your own game loop.
  /// 
  /// Inspecting stored highscore state is done through the QueryHighscores() call, which 
  /// comes in two flavors: One taking a filter operation and returns an enumerable (Linq
  /// style), and one taking parameters and returning the top N matching scores.
  /// 
  /// Highscores2 also supports networked highscore exchange. However, that's done through 
  /// a separate component, built on top of this component. Look at "Network" for those 
  /// features.
  /// 
  /// What do you do if LOW scores are actually BEST?
  /// There's an easy work-around: Store the negative of the score. This will make the 
  /// lowest scores be the highest-valued when sorted. When displaying to the user, flip 
  /// the sign back. This is how it works:
  /// Score 1 better than score 10
  /// Store as -1, -10
  /// -1 is higher than -10, and comes out as "high score"
  /// When displaying display - -1 == 1, then - -10 == 10.
  /// </summary>
  public class Storage : GameComponent
  {
    static Game GameInstance;
    public static Storage Instance;
    //  note: turning autosave on doesn't by itself trigger a save event
    static public bool Autosave;
    /* It's useful to have a delay between detecting that a save is necessary, 
     * and actually saving something. This lets more data come in if it's on the 
     * way, without having to go to the disk twice. The default delay to wait for 
     * more data is 5 seconds (50,000,000 decimicroseconds).
     */
    static public long AutosaveDelay = 50000000;   //  10,000,000 is one second

    /* Attach highscores storage to your game. Call this once, generally in the 
     * constructor of your game, and pass in the game instance. Pass in true if 
     * you want highscores to be auto-saved to disk.
     */
    public static Storage Attach(Game game, bool autosave)
    {
      return AttachInternal(game, autosave, delegate() { return new Storage(); });
    }

    protected delegate Storage FactoryFunction();

    /* AttachInternal may be useful if you create your own subclass of Storage. 
     * You can have your own Attach() function that calls AttachInternal with your 
     * own factory function to create an instance of your class.
     */
    protected static Storage AttachInternal(Game game, bool autosave, FactoryFunction fn)
    {
      if (game == null)
      {
        throw new ArgumentNullException("You must supply a valid game!");
      }
      if (Instance != null)
      {
        Instance.Dispose();
      }
      Timing.Init();
      Autosave = autosave;
      GameInstance = game;
      Instance = fn();
      return Instance;
    }

    bool ownsServices;
    bool disposed;
    bool gettingDevice;
    public bool HasLoaded;

    //  You should change these values during construction of your game 
    //  if you want a different behavior. Changing them later may have unpredictable
    //  consequences.
    public static int MaxHighscoresPerGamertag = 40;
    public static int MaxHighscoresPerGamertagPerGametype = 20;
    public static int MaxHighscoreCountTotal = 2000;

    /* The implementation of Storage is hidden from users, although it is protected
     * so you can derive from it if you want to. If you do, you have to write a new 
     * Attach() function as well, as that function attaches an instance of this 
     * specific class.
     */
    protected Storage()
      : base(GameInstance)
    {
      todo = new System.Threading.AutoResetEvent(false);
      thread = new System.Threading.Thread(this.Worker);
      thread.Start();
      GameInstance.Components.Add(this);
    }

    StorageDevice device;
    Context context;
    GamerServicesComponent services;

    /* All actions on highscores storage are taken through an active Context.
     * This allows actions to be atomic -- go from one consistent state to another -- 
     * without any intermediate states being visible to the outside.
     */
    protected class Context : IDisposable
    {
      internal Context(StorageDevice dev, string name)
      {
        Trace.WriteLine("Context: creating for: " + name);
        this.dev = dev;
        this.name = name;
      }

      /* On dispose, the state actually commits, and writes to disk.
       */
      public void Dispose()
      {
        Trace.WriteLine("Context: commiting for: " + name);
        if (reader != null)
        {
          reader.Close();
        }
        if (writer != null)
        {
          Trace.WriteLine("Writing to file: " + name + ".tmp");
          using (FileStream fs = File.OpenWrite(Path.Combine(GetContainer().Path, name + ".tmp")))
          {
            fs.Write(wrStream.GetBuffer(), 0, (int)wrStream.Length);
            writer.Close();
          }
          /* Safe save (mostly):
           * - write to a temp file
           * - delete target file
           * - move temp file to target file name
           * This is because rename/move can't clobber an existing file in Windows.
           * Sadly, this means there's a very small window where a crash would leave
           * only the temp file there, not the a file of the desired name.
           */
          try
          {
            /* If the file isn't there, this will fail. But that's OK, because the 
             * whole point was to make sure that no file is in the way of the Move() 
             * call.
             */
            File.Delete(Path.Combine(container.Path, name));
          }
          catch (FileNotFoundException x)
          {
            GC.KeepAlive(x);
          }
          File.Move(Path.Combine(container.Path, name + ".tmp"),
            Path.Combine(container.Path, name));
        }
        if (container != null)
        {
          container.Dispose();
        }
      }

      /* Open a target stream for writing. This stream will buffer in memory 
       * before it goes to disk.
       */
      public BinaryWriter OpenForWrite()
      {
        if (writer == null)
        {
          wrStream = new MemoryStream();
          writer = new BinaryWriter(wrStream);
        }
        else
        {
          Trace.WriteLine(
              "Warning: re-setting writer to beginning (this means you're write-after-writing, which is inefficient)");
          //  reset writing
          wrStream.Position = 0;
          wrStream.SetLength(0);
        }
        return writer;
      }

      /* Open the highscores file for reading. To be efficient, read it all into 
       * memory in one big gulp, and then let the reader read it out of a memory stream.
       */
      public BinaryReader OpenForRead()
      {
        if (reader == null)
        {
          try
          {
            MemoryStream rdStream;
            using (FileStream fs = File.OpenRead(Path.Combine(GetContainer().Path, name)))
            {
              byte[] data = new byte[fs.Length];
              fs.Read(data, 0, data.Length);
              rdStream = new MemoryStream(data);
            }
            reader = new BinaryReader(rdStream);
          }
          catch (FileNotFoundException x)
          {
            GC.KeepAlive(x);
            reader = new BinaryReader(new MemoryStream(new byte[0]));
          }
        }
        else
        {
          reader.BaseStream.Position = 0;
        }
        return reader;
      }

      /* Figure out whether there is a storage container to use on our storage device.
       * The name is taken from the game class itself, which should be safe (each game 
       * should have its own name). On Xbox, each game is isolated anyway.
       */
      StorageContainer GetContainer()
      {
        if (container == null)
        {
          container = dev.OpenContainer(GameInstance.GetType().Name);
        }
        return container;
      }

      string name;
      StorageDevice dev;
      StorageContainer container;
      BinaryReader reader;
      BinaryWriter writer;
      MemoryStream wrStream;
    }

    /* Because I may create the GamerServicesComponent myself (if there isn't one already), 
     * you can ask me for it if you need it, too.
     */
    public GamerServicesComponent GamerServices { get { return services; } set { services = value; ownsServices = false; } }

    /* IsWorking will be set to true or false by the Update() function of this component, 
     * so you can display status information if you so choose.
     */
    public bool IsWorking { get; protected set; }

    /* Worker is a thread function that actually does highscores grunt work. Putting it 
     * in its own thread, on a CPU core other than the main application, lets the main 
     * application run smoother, with less interruption.
     */
    void Worker()
    {
#if XBOX
      Thread.CurrentThread.SetProcessorAffinity(3);
#endif
      while (!disposed)
      {
        /* Wait for a queued request.
         */
        todo.WaitOne();

        /* First things first: If I don't have a device, I can't do much storage
         * work, so take care of that.
         */
        if (device == null || device.IsConnected == false)
        {
          /* Check for deferred actions sometime later (when presumably I have a 
           * working storage device).
           */
          Queue(delegate()
          {
            CheckDeferredActions();
          }, mainActions);
          continue;
        }

        /* Figure out what to do now.
         */
        Action act = null;
        try
        {
          bool success = true;
          /* Create a context to do work within, to make it transactional (in the 
           * sense that it goes from one consistent state to another consistent state, 
           * with no inconsistent intermediate states leaking to the outside).
           */
          using (context = new Context(device, "Highscores"))
          {
            IsWorking = true;
            while (success)
            {
              /* Look for the next action to run.
               */
              lock (threadActions)
              {
                if (threadActions.Count > 0)
                {
                  act = threadActions[0];
                  threadActions.RemoveAt(0);
                }
              }
              if (act == null)
              {
                /* When I'm out of actions, I'm done for this time around.
                 */
                break;
              }
              /* Perform the action.
               */
              act();
              /* If the action succeeded, it's no longer something failing.
               */
              if (failingAction == act)
              {
                failingAction = null;
              }
              act = null;
              Trace.WriteLine(String.Format("Highscores complete action: {0}", act));
            }
          }
        }
        catch (System.Exception x)
        {
          if (act != null)
          {
            /* If the action failed, and already failed last time, give up.
             */
            if (act == failingAction)
            {
              Trace.WriteLine(String.Format("Action failed twice: {0}; skipping.", act));
              failingAction = null;
            }
            else
            {
              /* If the action failed the first time, re-insert it into the list, 
               * so that I can re-try it one more time. Make a note that this 
               * action was failed, so that if it fails again, I don't have to 
               * keep trying the same failure case forever.
               */
              failingAction = act;
              //  re-do the action later, as it seems to have failed this time
              threadActions.Insert(0, act);
            }
          }
          //  I swallow execptions. At least it won't crash!
          Trace.WriteLine(String.Format("Highscores Exception in Thread: {0}", x));
          Queue(delegate()
          {
            /* Check for more actions later, so that an exception doesn't stall 
             * out the queue of things to do.
             */
            CheckDeferredActions();
          }, mainActions);
        }
        finally
        {
          IsWorking = false;
        }
      }
    }

    //  Keep track of the last action that failed, because it gets re-tried.
    //  If it fails on re-try, don't run it at all. This avoids forever looping 
    //  on bad inputs, but it causes twice-in-a-row problems to abort the action.
    Action failingAction;
    System.Threading.Thread thread;
    System.Threading.AutoResetEvent todo;
    int savingCount;
    int loadingCount;
    long autosaveTime;

    protected override void Dispose(bool disposing)
    {
      if (!disposed)
      {
        disposed = true;
        GameInstance.Components.Remove(this);
        if (ownsServices)
        {
          GameInstance.Components.Remove(services);
          services.Dispose();
        }
        todo.Set();
        thread.Join();
        todo.Close();
        thread = null;
        todo = null;
      }
    }

    public override void Initialize()
    {
      base.Initialize();
      //  look for gamer services, if present
      foreach (GameComponent gc in Game.Components)
      {
        if (typeof(GamerServicesComponent).IsAssignableFrom(gc.GetType()))
        {
          GamerServices = (GamerServicesComponent)gc;
          break;
        }
      }
      //  if not present, add my own
      if (GamerServices == null)
      {
        GamerServices = new GamerServicesComponent(Game);
        GameInstance.Components.Add(GamerServices);
        ownsServices = true;
      }
    }

    /// <summary>
    /// Start using the given storage device.
    /// </summary>
    /// <param name="dev">Where to load/save highscores.</param>
    /// <param name="loadFresh">If true, clear any current scores, and load fresh from the device.
    /// If false, overwrite scores on the device (if any) with current scores.</param>
    public virtual void SetDevice(StorageDevice dev)
    {
      gettingDevice = false;
      device = dev;
      if (dev != null)
      {
        Queue(delegate()
        {
          CheckDeferredActions();
        }, mainActions);
      }
      else
      {
        refusedStorage = true;
        if (UserRefusedStorage != null)
        {
          //  Because I'm telling the user, I will wait until there 
          //  is an attempt to re-select storage before trying again.
          UserRefusedStorage(this, EventArgs.Empty);
        }
      }
    }

    /// <summary>
    /// If any of the I/O functions (StartLoading, StartSaving, AddHighscore) return 
    /// false, you have to call ReselectStorage() or SetDevice() to make them actually 
    /// take effect.
    /// </summary>
    public virtual void ReselectStorage()
    {
      refusedStorage = false;
      device = null;
      Queue(delegate()
      {
        CheckDeferredActions();
      }, mainActions);
    }

    /* Clear all loaded highscores. Return false if there is no storage device.
     * This also clears any pending actions, because they will presumably be 
     * pertaining to the old data/state that went away.
     */
    public virtual bool ClearLoaded()
    {
      Queue(delegate()
      {
        //  clear data
        ClearData();
        //  remove future actions on the thread
        //  note: this might be dangerous, if the main thread 
        //  also attempts to lock both mainActions and threadActions.
        //  So it doesn't do that!
        lock (mainActions)
        {
          threadActions.Clear();
          //  don't run any actions on main, either
          mainActions.Clear();
        }
        lock (this)
        {
          //  these actions won't happen, so don't show them as completing etc
          loadingCount = 0;
          savingCount = 0;
          autosaveTime = 0;
          if (Autosave)
          {
            //  I changed the hiscores, so write that fact to disk
            autosaveTime = Timing.NowTicks + AutosaveDelay;
            savingCount = 1;
          }
        }
        /* HighscoresChanged must be called from the main thread.
         */
        Queue(delegate()
        {
          if (HighscoresChanged != null)
          {
            HighscoresChanged(this, EventArgs.Empty);
          }
        }, mainActions);
      }, threadActions);
      CheckDeferredActions();
      return !refusedStorage;
    }

    /* Start loading scores from disk. If there is no device, return false.
     */
    public virtual bool StartLoading()
    {
      lock (this)
      {
        ++loadingCount;
      }
      /* Queue loading work on the worker thread. When that is done, 
       * queue a completion action on the main thread again.
       */
      Queue(delegate()
      {
        LoadFromStorage();
        lock (this)
        {
          --loadingCount;
          if (loadingCount == 0)
          {
            /* LoadComplete must be signalled on the main thread.
             */
            Queue(delegate()
            {
              if (LoadComplete != null)
              {
                LoadComplete(this, EventArgs.Empty);
              }
              HasLoaded = true;
            }, mainActions);
          }
        }
      }, threadActions);
      CheckDeferredActions();
      return !refusedStorage;
    }

    /* Start saving highscores. Deal with merging multiple requests.
     * Return false if there is no current devcice to save to.
     */
    public virtual bool StartSaving()
    {
      lock (this)
      {
        ++savingCount;
      }
      /* Queue an action on thread actions, which in turn will 
       * queue a completion action on the main thread when done.
       */
      Queue(delegate()
      {
        SaveToStorage();
        lock (this)
        {
          Debug.Assert(savingCount > 0);
          --savingCount;
          if (savingCount == 0)
          {
            /* The SaveComplete event must be called on the main thread.
             */
            Queue(delegate()
            {
              if (SaveComplete != null)
              {
                SaveComplete(this, EventArgs.Empty);
              }
            }, mainActions);
          }
        }
      }, threadActions);
      CheckDeferredActions();
      return !refusedStorage;
    }

    /* All highscores I have loaded go here.
     */
    List<Highscore> highscores = new List<Highscore>();

    /* All game types I have seen go here.
     */
    HashSet<string> gametypes = new HashSet<string>();

    /* Actually write the highscores data to context storage.
     */
    protected virtual void SaveToStorage()
    {
      Context ctx = context;
      BinaryWriter bw = ctx.OpenForWrite();
      bw.Write((int)1); //  version
      bw.Write(GameInstance.GetType().Name);  //  game name
      bw.Write((int)highscores.Count);
      /* A WriteMarshal knows how to write a highscore instance to a stream.
       */
      WriteMarshal wm = new WriteMarshal(bw);
      foreach (Highscore hs in highscores)
      {
        hs.MarshalThrough(wm);
      }
    }

    /* Start loading scores from storage.
     */
    protected virtual void LoadFromStorage()
    {
      /* Create a local variable to make the closures use this, not whatever 
       * the later value is of the member.
       */
      Context ctx = context;
      lock (highscores)
      {
        BinaryReader br = ctx.OpenForRead();
        highscores.Clear();
        gametypes.Clear();
        try
        {
          if (br.BaseStream.Length != 0)
          {
            int ver = br.ReadInt32();
            if (ver != 1)
            {
              throw new InvalidDataException("The highscores file is not version 1!");
            }
            string str = br.ReadString();
            if (str != GameInstance.GetType().Name)
            {
              throw new InvalidDataException("The highscores file is for another game!");
            }
            int n = br.ReadInt32();
            /* ReadMarshal knows how to read a highscore instance from a stream
             */
            ReadMarshal rm = new ReadMarshal(br);
            for (int i = 0; i != n; ++i)
            {
              Highscore hs = new Highscore();
              hs.MarshalThrough(rm);
              highscores.Add(hs);
              /* Build the list of game types opportunistically */
              gametypes.Add(hs.Gametype);
            }
          }
        }
        finally
        {
          //  always signal that highscores have loaded, so that a bad 
          //  file will be overwritten by new data if needed
          Queue(delegate()
          {
            if (HighscoresChanged != null)
            {
              HighscoresChanged(this, EventArgs.Empty);
            }
          }, mainActions);
        }
      }
    }

    /* I got some new highscore. Sort it into my tables, and kick off an 
     * auto-save if necessary. Make sure I don't save too many scores. There's 
     * one allowance for "network" scores, and another allowance for "non-network" 
     * scores, on the theory that players want to see their own scores even if 
     * they are worse than the worst network score received.
     */
    protected virtual void HighscoreReceived(Highscore data, bool fromNetwork)
    {
      int nGamertag = 0;
      int nGametype = 0;
      int nGamertagGametype = 0;
      int rankInGamertag = 0;
      int rankInGametype = 0;
      int rankInGamertagGametype = 0;
      Highscore lowestGamertag = null;
      Highscore lowestGametype = null;
      Highscore lowestGamertagGametype = null;
      Highscore oldestDate = null;

      lock (highscores)
      {
        gametypes.Add(data.Gametype);

        foreach (Highscore hs in highscores)
        {
          if (oldestDate == null || oldestDate.Date > hs.Date)
          {
            oldestDate = hs;
          }
          if (hs.Gamertag == data.Gamertag)
          {
            if (hs.Score > data.Score)
            {
              rankInGamertag++;
            }
            if (lowestGamertag == null || lowestGamertag.Score > hs.Score)
            {
              lowestGamertag = hs;
            }
            ++nGamertag;
          }
          if (hs.Gametype == data.Gametype)
          {
            if (hs.Score > data.Score)
            {
              rankInGametype++;
            }
            if (lowestGametype == null || lowestGametype.Score > hs.Score)
            {
              lowestGametype = hs;
            }
            ++nGametype;
          }
          if (hs.Gamertag == data.Gamertag && hs.Gametype == data.Gametype)
          {
            if (hs.Score > data.Score)
            {
              rankInGamertagGametype++;
            }
            if (lowestGamertagGametype == null || lowestGamertagGametype.Score > hs.Score)
            {
              lowestGamertagGametype = hs;
            }
            ++nGamertagGametype;
          }
        }
        if (lowestGamertag == null || data.Score > lowestGamertag.Score ||
          lowestGametype == null || data.Score > lowestGametype.Score ||
          lowestGamertagGametype == null || data.Score > lowestGamertagGametype.Score)
        {
          highscores.Add(data);
          if (nGamertag == MaxHighscoresPerGamertag)
          {
            highscores.Remove(lowestGamertag);
          }
          if (nGamertagGametype == MaxHighscoresPerGamertagPerGametype)
          {
            if (lowestGamertag != lowestGamertagGametype)
            {
              highscores.Remove(lowestGamertagGametype);
            }
          }
          Queue(delegate()
          {
            MaybeAutosave();
            if (NewHighscoreFound != null)
            {
              HighscoreEventArgs h = new HighscoreEventArgs();
              h.FromNetwork = fromNetwork;
              h.RankInGamertag = rankInGamertag;
              h.RankInGamertagAndGametype = rankInGamertagGametype;
              h.RankInGametype = rankInGametype;
              h.Score = data;
              NewHighscoreFound(this, h);
            }
          }, mainActions);
        }
        if (highscores.Count >= MaxHighscoreCountTotal)
        {
          MaybeAutosave();
          highscores.Remove(oldestDate);
        }
      }
    }

    /* This hook is called after things change, to see whether it's time to 
     * auto-save. Also handles coalescing multiple calls right after each other.
     */
    void MaybeAutosave()
    {
      if (Autosave)
      {
        lock (this)
        {
          if (savingCount == 0)
          {
            ++savingCount;
            autosaveTime = Timing.NowTicks + AutosaveDelay;
          }
        }
      }
    }

    /* Clear all highscores data.
     */
    protected virtual void ClearData()
    {
      lock (highscores)
      {
        highscores.Clear();
        gametypes.Clear();
      }
    }

    /// <summary>
    /// If this returns false, you will have to call ReselectStorage, or SetDevice(), 
    /// before any data will be written to disk.
    /// </summary>
    /// <param name="data"></param>
    public virtual bool AddHighscore(Highscore data, bool fromNet)
    {
      Trace.WriteLine(String.Format("AddHighscore({0}, {1}, {2}, {3}, {4}, {5})",
        data.Date, data.Gamertag, data.Gametype, data.Score, data.Statistic, data.Note));
      Queue(delegate()
      {
        HighscoreReceived(data, fromNet);
      }, threadActions);
      CheckDeferredActions();
      return !refusedStorage;
    }

    public delegate void Action();

    /* Things to do on the worker thread are pushed into this queue list.
     */
    List<Action> threadActions = new List<Action>();

    /* Things to do on the main thread are pushed into this queue list.
     */
    List<Action> mainActions = new List<Action>();

    /* Queue some action into some queue. This is thread safe, in the sense that 
     * the queue is locked, and won't be manipulated by more than one thread at 
     * the same time. Watch out for deadlocks if you hold other locks when calling 
     * this function, though.
     */
    protected void Queue(Action act, List<Action> queue)
    {
      lock (queue)
      {
        queue.Add(act);
      }
    }

    /* Check the queue of actions to see if there are any deferred actions to run.
     * However, first verify that there is storage. An action will remain deferred 
     * until storage is selected by the user.
     */
    protected virtual void CheckDeferredActions()
    {
      if (device == null || !device.IsConnected)
      {
        if (!refusedStorage)
        {
          Queue(delegate()
          {
            StartGettingStorageDevice();
          }, mainActions);
        }
      }
      else
      {
        refusedStorage = false;
        //  I have a device -- run through the todo list, if there is one
        todo.Set();
      }
    }

    /* Start asking the user for a storage device. This is asynchronous, and will 
     * complete (with success or failure) sometime later.
     */
    protected virtual void StartGettingStorageDevice()
    {
      if (!gettingDevice || retryGettingStorageDevice)
      {
        retryGettingStorageDevice = false;
        gettingDevice = true;
        if (StorageDeviceNeeded != null)
        {
          StorageDeviceNeeded(this, EventArgs.Empty);
        }
        else
        {
          if (Guide.IsVisible)
          {
            retryGettingStorageDevice = true;
          }
          else
          {
            try
            {
              Guide.BeginShowStorageDeviceSelector(SelectedStorage, null);
            }
            catch (System.Exception x)
            {
              Console.WriteLine("Swallowing BeginShow... exception: " + x.ToString());
              retryGettingStorageDevice = true;
            }
          }
        }
      }
    }

    bool retryGettingStorageDevice = false;
    bool refusedStorage = false;

    /* Completion on the storage selection request.
     */
    protected virtual void SelectedStorage(IAsyncResult ar)
    {
      StorageDevice dev = Guide.EndShowStorageDeviceSelector(ar);
      Queue(delegate()
      {
        SetDevice(dev);
      }, mainActions);
    }

    /// <summary>
    /// Query the highscores table and return matcing entries.
    /// </summary>
    /// <param name="gamertag">If not null, then entries must be for this gamertag.</param>
    /// <param name="gametype">If not null, then entries must have this gametype.</param>
    /// <param name="statistic">It not null, then entries must have greater than or equal to this statistic value.</param>
    /// <param name="score">It not null, then entries must have greater than or equal to this score.</param>
    /// <param name="nMax">Return at most this many values (the top N values will be returned)</param>
    /// <returns>An array of the top N entries matching the given criteria.</returns>
    public Highscore[] QueryHighscores(string gamertag, string gametype, int? statistic, int? score, int nMax)
    {
      List<Highscore> ret = new List<Highscore>();
      lock (highscores)
      {
        foreach (Highscore hs in highscores)
        {
          if ((gamertag == null || hs.Gamertag == gamertag) &&
            (gametype == null || hs.Gametype == gametype) &&
            (!statistic.HasValue || hs.Statistic >= statistic.Value) &&
            (!score.HasValue || hs.Score >= score.Value))
          {
            ret.Add(hs);
          }
        }
      }
      ret.Sort(Orderer);
      if (ret.Count > nMax)
      {
        ret.RemoveRange(nMax, ret.Count - nMax);
      }
      return ret.ToArray();
    }

    /* Given all highscores, return the set of scores that fulfills the given 
     * query filter predicate.
     */
    public IEnumerable<Highscore> QueryHighscores(HighscoreFilter filter)
    {
      //  Painfully, I have to create a copy, because the array 
      //  may be separately modified by the worker thread, and I 
      //  can't hold the lock while yield returning
      Highscore[] hslist;
      lock (highscores)
      {
        hslist = highscores.ToArray();
      }
      foreach (Highscore hs in hslist)
      {
        if (filter(hs))
        {
          yield return hs;
        }
      }
    }

    /* If you want to trim down the number of highscores, then call 
     * KeepSomeHighscores() and pass in a filter that returns TRUE for 
     * the highscores you want to keep. If you pass in NULL, a default 
     * filter that keeps about half the highscores will be used. This 
     * algorithm automatically keeps all highscores that are younger 
     * than a week. It's appropriate to call this function after you've 
     * first loaded highscores in your game, for example.
     */
    public void KeepSomeHighscores(HighscoreFilter toKeep)
    {
      Random r = new System.Random();
      DateTime now = DateTime.Now;
      List<Highscore> keepers = new List<Highscore>();
      lock (highscores)
      {
        foreach (Highscore hs in highscores)
        {
          if (toKeep == null)
          {
            /* highscores from the last week are kept */
            double threshold = 0;
            /* highscores older than a week have a 2:3 chance */
            if (hs.Date.Ticks < now.Ticks - 10000000L * 60L * 60L * 24L * 7L)
            {
              threshold = 0.333f;
            }
            /* highscores older than 13 weeks (approx 3 months) have a higher 
             * chance of going away.
             */
            if (hs.Date.Ticks < now.Ticks - 10000000L * 60L * 60L * 24L * 7L * 13L)
            {
              threshold = 0.75f;
            }
            if (r.NextDouble() >= threshold)
            {
              keepers.Add(hs);
            }
          }
          else
          {
            if (toKeep(hs))
            {
              keepers.Add(hs);
            }
          }
        }
        highscores.Clear();
        highscores.AddRange(keepers);
      }
      if (HighscoresChanged != null)
      {
        HighscoresChanged(this, EventArgs.Empty);
      }
    }

    public delegate bool HighscoreFilter(Highscore hs);

    class HighscoreOrdering : Comparer<Highscore>
    {
      public override int Compare(Highscore x, Highscore y)
      {
        if (x.Score > y.Score) return -1;
        if (x.Score < y.Score) return 1;
        return 0;
      }
    }

    /* The HighscoreOrdering class is used to sort high scores by score. If you want to 
     * sort highscores by "lowest is best," the easiest solution is to store the negative 
     * value of the score, and then negate the value when you display it.
     */
    static HighscoreOrdering Orderer = new HighscoreOrdering();

    /* Raised when there is no storage device, and one is needed because of requests.
     */
    public event EventHandler StorageDeviceNeeded;

    /* Raised when the set of highscores available has changed.
     */
    public event EventHandler HighscoresChanged;

    /* Raised when a particlar new highscore has been seen.
     */
    public event HighscoreEventHandler NewHighscoreFound;

    /* Raised when the component has finished loading highscores from disk.
     */
    public event EventHandler LoadComplete;

    /* Raised when the component has finished writing highscores to disk.
     */
    public event EventHandler SaveComplete;

    /* Raised when the user clicked cancel/back on the "select storage" display.
     */
    public event EventHandler UserRefusedStorage;

    /* Return true if the component is currently in the act of saving scores.
     */
    public bool IsSaving { get { return savingCount > 0; } }

    /* Return true if the component is currently in the act of loading scores.
     */
    public bool IsLoading { get { return loadingCount > 0; } }

    /* Return all the known game types, as seen by different highscores and 
     * the AddGameType() function.
     */
    public string[] Gametypes { get { return gametypes.ToArray<string>(); } }

    //  If you want to pre-populate your scores with a given type.
    public void AddGameType(string type)
    {
      gametypes.Add(type);
    }

    /* The component is updated by the game each frame. This allows it to 
     * run actions queued for the main thread and call event handlers.
     */
    public override void Update(GameTime time)
    {
      if (retryGettingStorageDevice)
      {
        StartGettingStorageDevice();
      }
      base.Update(time);
      try
      {
        //  try to bite off all the actions I can
        //  however, stop executing for this step if one action throws an error
        while (mainActions.Count > 0)
        {
          Action a = mainActions[0];
          mainActions.RemoveAt(0);
          a();
        }
        if (autosaveTime != 0 && Timing.NowTicks > autosaveTime)
        {
          Trace.WriteLine("Starting auto-save");
          lock (this)
          {
            autosaveTime = 0;
            --savingCount;
          }
          StartSaving();
        }
      }
      catch (Exception x)
      {
        Trace.WriteLine(String.Format("Action exception in Highscores: {0}", x));
      }
    }

  }

  /* Highscore actually stores the information about a specific players' 
   * specific score playing a specific game mode and additional counter 
   * (useful for 'level achieved' or 'number of bonus rounds' or whatnot).
   */
  public class Highscore
  {
    public Highscore()
    {
    }

    public Highscore(PlayerIndex ix, int score)
      : this((Gamer.SignedInGamers[ix] == null) ?
        "Guest" : Gamer.SignedInGamers[ix].Gamertag, score)
    {
    }

    public Highscore(string gamertag, int score)
      : this(DateTime.Now, gamertag, "", score, 0, "")
    {
    }

    public Highscore(DateTime date, string gamertag, string gametype,
      int score, int statistic, string note)
    {
      Date = date;
      Gamertag = gamertag;
      Gametype = gametype;
      Score = score;
      Statistic = statistic;
      Note = note;
    }

    public DateTime Date;
    public string Gamertag;
    public string Gametype;
    public int Score;
    public int Statistic;
    public string Note;

    /* Support I/O of a Highscore instance
     */
    public virtual void MarshalThrough(Marshal m)
    {
      m.Marshal("Date", ref Date);
      m.Marshal("Gamertag", ref Gamertag);
      m.Marshal("Gametype", ref Gametype);
      m.Marshal("Score", ref Score);
      m.Marshal("Statistic", ref Statistic);
      m.Marshal("Note", ref Note);
    }
  }

  /* All the marshalers go through this interface, so that a visitor for a 
   * data structure gets a consistent interface and reading and writing can 
   * happen through the same visitor.
   */
  public interface Marshal
  {
    void Marshal(string name, ref DateTime date);
    void Marshal(string name, ref string txt);
    void Marshal(string name, ref int val);
  }

  /* Givn a stream, WriteMarshal can marshal highscore data to that stream
   */
  public class WriteMarshal : Marshal
  {
    public WriteMarshal(BinaryWriter bw)
    {
      writer = bw;
    }
    BinaryWriter writer;
    public void Marshal(string name, ref DateTime date)
    {
      writer.Write(date.Ticks);
    }
    public void Marshal(string name, ref string txt)
    {
      writer.Write(txt);
    }
    public void Marshal(string name, ref int val)
    {
      writer.Write(val);
    }
  }

  /* Given a stream, ReadMarshal can marshal highscore data from that stream 
   * and into highscore objects.
   */
  public class ReadMarshal : Marshal
  {
    public ReadMarshal(BinaryReader br)
    {
      reader = br;
    }
    BinaryReader reader;
    public void Marshal(string name, ref DateTime date)
    {
      date = new DateTime(reader.ReadInt64());
    }
    public void Marshal(string name, ref string txt)
    {
      txt = reader.ReadString();
    }
    public void Marshal(string name, ref int val)
    {
      val = reader.ReadInt32();
    }
  }

  /* When a highscore changes, you get HighscoreEventArgs, which lets 
   * you inspect the data pertaining to the specific highscore.
   */
  public class HighscoreEventArgs : EventArgs
  {
    public Highscore Score;
    public bool FromNetwork;
    public int RankInGamertag;
    public int RankInGametype;
    public int RankInGamertagAndGametype;
  }
  public delegate void HighscoreEventHandler(object sender, HighscoreEventArgs e);
}
