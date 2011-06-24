using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Net;
using System.Diagnostics;
using Microsoft.Xna.Framework.GamerServices;
using Microsoft.Xna.Framework.Input;

namespace Gesture
{
  //  Network supports automatic session creation to share highscores with 
  //  other players.
  //  You can also use the same session for networked game communication.
  public class Network : GameComponent
  {

    public static Network Instance;
    static Storage storage;

    /* You don't create this component directly, but instead call Attach() on the 
     * class, passing in your game.
     */
    protected Network(Game game)
      : base(game)
    {
      SignedInGamer.SignedIn += new EventHandler<SignedInEventArgs>(SignedInGamer_SignedIn);
      SignedInGamer.SignedOut += new EventHandler<SignedOutEventArgs>(SignedInGamer_SignedOut);
      game.Components.Add(this);
    }

    /* Start loading highscores (assuming a Storage component is already existing).
     * These scores will be sent across the network (the best 50 of each game type).
     */
    void LoadHighscores()
    {
      HashSet<Highscore> toSend = new HashSet<Highscore>();
      int nPerChunk = Storage.MaxHighscoresPerGamertagPerGametype;
      if (nPerChunk > 50)
      {
        nPerChunk = 50; //  put some limitation on amount of data
      }
      foreach (String s in Storage.Instance.Gametypes)
      {
        //  make sure all the best scores are sent
        foreach (Highscore hs in Storage.Instance.QueryHighscores(
          null, s, null, null, nPerChunk))
        {
          toSend.Add(hs);
        }
        //  make sure all local scores are sent
        foreach (SignedInGamer sig in SignedInGamer.SignedInGamers)
        {
          foreach (Highscore hs in Storage.Instance.QueryHighscores(sig.Gamertag,
            s, null, null, nPerChunk))
          {
            toSend.Add(hs);
          }
        }
      }
      this.toSend.Clear();
      this.toSend.AddRange(toSend);
    }

    /* When no gamers are signed in, the session will no longer be usable.
     */
    void SignedInGamer_SignedOut(object sender, SignedOutEventArgs e)
    {
      if (SignedInGamer.SignedInGamers.Count == 0)
      {
        DisposeSession();
      }
    }

    void DisposeSession()
    {
      if (session != null)
      {
        Trace.WriteLine(String.Format("Disposing session: sessionCloseTime {0} now {1}",
          new DateTime(sessionCloseTime), DateTime.Now));
        session.Dispose();
        session = null;
        sessionDisconnected = true;
      }
      sessionCloseTime = 0;
      IDisposable id = null;
      /* If I'm currently looking for sessions to join, stop that.
       */
      if (findAsync_ != null)
      {
        try
        {
          id = NetworkSession.EndFind(findAsync_);
        }
        catch (System.Exception x)
        {
          Trace.WriteLine("Swallowing EndFind exception: " + x.ToString());
        }
        findAsync_ = null;
        if (id != null)
          id.Dispose();
      }
      /* If I'mcurrently looking to join a session, stop that.
       */
      if (joinAsync_ != null)
      {
        try
        {
          id = NetworkSession.EndJoin(joinAsync_);
        }
        catch (System.Exception x)
        {
          Trace.WriteLine("Swallowing EndJoin exception: " + x.ToString());
        }
        joinAsync_ = null;
        if (id != null)
          id.Dispose();
      }
      /* If I'm currently trying to host a session, stop that.
       */
      if (createAsync_ != null)
      {
        try
        {
          id = NetworkSession.EndCreate(createAsync_);
        }
        catch (System.Exception x)
        {
          Trace.WriteLine("Swallowing EndCreate exception: " + x.ToString());
        }
        createAsync_ = null;
        if (id != null)
          id.Dispose();
      }
    }

    protected override void Dispose(bool disposing)
    {
      DisposeSession();
      base.Dispose(disposing);
    }

    void SignedInGamer_SignedIn(object sender, SignedInEventArgs e)
    {
      if (sessionType != SessionType.None && session == null)
      {
        actOnType = true;
      }
    }

    HashSet<string> previousSessionHosts = new HashSet<string>();

    /* To instantiate network highscores, call Network.Attach(yourGame). This 
     * assumes that a Storage component has already been attached to your game.
     */
    public static Network Attach(Game game)
    {
      if (game == null)
      {
        throw new ArgumentNullException("You must pass a valid game to Network.Attach()");
      }
      Storage st = null;
      foreach (GameComponent gc in game.Components)
      {
        if (typeof(Storage).IsAssignableFrom(gc.GetType()))
        {
          st = (Storage)gc;
        }
      }
      if (st == null)
      {
        //  I can't really do it automatically, because there are too many configuration 
        //  options involved -- and disposing the Storage that would happen if the user 
        //  configured storage after I created it would make it extra complicated
        throw new InvalidOperationException("You must attach Storage before you attach Network!");
      }
      storage = st;
      Instance = new Network(game);
      return Instance;
    }

    NetworkSession session;

    /* Return the current NetworkSession. Useful if you want to both share highscores 
     * and run a networked game.
     */
    public NetworkSession CurrentSession()
    {
      return session;
    }
    /* Return the current session, and stop knowing about it for highscores purposes.
     */
    public NetworkSession DetachCurrentSession()
    {
      NetworkSession ret = session;
      session = null;
      return ret;
    }
    /* Given an existing network session, start exchanging highscores over it.
     */
    public void AttachToSession(NetworkSession sess, SessionType type)
    {
      if (session != null)
      {
        throw new InvalidOperationException("Can't AttachToSession() when already having a session!");
      }
      if (sess == null || type == SessionType.None)
      {
        throw new ArgumentException("Bad arguments to AttachToSession()");
      }
      session = sess;
      sessionType = type;
      UpdateVoice();
    }

    /* When sharing highscores, you don't want voice chat to be randomly turned on.
     */
    protected void UpdateVoice()
    {
      foreach (LocalNetworkGamer lg in session.LocalGamers)
      {
        foreach (NetworkGamer ng in session.RemoteGamers)
        {
          //  don't add random voice chat while sharing highscores
          lg.EnableSendVoice(ng, sessionType != SessionType.HighscoresOnly);
        }
      }
    }

    //  Register handlers for packet types 0 .. 249.
    //  Types 250 through 255 are used by highscores internally.
    PacketFunc[] pf = new PacketFunc[250];

    /* Register a function for a given packet code (0 .. 249).
     * The packet code is the value of the first byte of the packet data stream.
     */
    public void SetPacketDispatchFunction(byte code, PacketFunc func)
    {
      if (code >= 250)
      {
        throw new InvalidOperationException("Byte codes 250 through 255 are reserved by highscores.");
      }
      pf[code] = func;
    }

    PacketReader pr = new PacketReader(1024);

    /* Step the network, raise any events that need raising, and do other 
     * periodic housekeeping.
     */
    public override void Update(GameTime gameTime)
    {
      try
      {
        base.Update(gameTime);
        /* A variety of actions set a variety of flags for what might be done here.
         */
        if (sessionCloseTime != 0L && Timing.NowTicks > sessionCloseTime
            && sessionType == SessionType.HighscoresOnly)
        {
          DisposeSession();
        }
        if (sessionDisconnected)
        {
          sessionDisconnected = false;
          OnSessionDisconnected();
        }
        if (tryingAgain)
        {
          tryingAgain = false;
          if (TryingConnection != null)
          {
            TryingConnection(this, EventArgs.Empty);
          }
        }
        if (sessionEstablished)
        {
          sessionEstablished = false;
          OnSessionEstablished();
        }
        /* If there is a session, then handle its communications.
         */
        if (session != null)
        {
          SendSome();
          session.Update();
          if (session == null || session.IsDisposed)
          {
            session = null;
            sessionDisconnected = true;
          }
          else
          {
            NetworkGamer sender;
            foreach (LocalNetworkGamer ng in session.LocalGamers)
            {
              /* Poll each player. Take care of highscores messages, 
               * and dispatch other messages to the user functions.
               */
              while (ng.ReceiveData(pr, out sender) > 0)
              {
                byte b = pr.ReadByte();
                if (b >= 250)
                {
                  /* Dispatch highscores-related packets.
                   */
                  if (sessionType != SessionType.GameOnly)
                  {
                    DoHighscoresPacket(ng, pr, sender, b);
                  }
                  else
                  {
                    Trace.WriteLine(String.Format("Swallowing packet code {0} from {1}", b, sender));
                  }
                }
                else
                {
                  /* Dispatch user-installed packet types
                   */
                  if (pf[b] != null && (sessionType != SessionType.HighscoresOnly))
                  {
                    pf[b](ng, pr, sender, b);
                  }
                  else
                  {
                    Trace.WriteLine(String.Format("Swallowing packet code {0} from {1}", b, sender));
                  }
                }
              }
            }
          }
        }
        /* Did the session type change?
         */
        if (actOnType)
        {
          actOnType = false;
          ActOnSessionTypeDesired();
        }
      }
      catch (System.Exception x)
      {
        Trace.WriteLine("Swallowing exception in Network.Update(): " + x.ToString());
        Trace.WriteLine("Disabling session");
        this.Enabled = false;
        DisposeSession();
      }
    }

    protected virtual void SendSome()
    {
      /* Send some data to each of the gamers in the session.
       */
      foreach (KeyValuePair<Gamer, JoinedGamer> kvp in joinedGamers)
      {
        kvp.Value.SendSome(toSend, session);
      }
    }

    protected virtual void AckFrom(NetworkGamer gamer, short ix)
    {
      /* Dispatch ack of highscores data from a given gamer.
       */
      JoinedGamer jg;
      if (joinedGamers.TryGetValue(gamer, out jg))
      {
        jg.Ack(ix);
      }
    }

    public List<Highscore> toSend = new List<Highscore>();

    /* Start sharing highscores. This will establish a session as necessary, and 
     * read/write highscores with peers that are randomly selected.
     */
    public void ShareSomeHighscores()
    {
      if (session == null)
      {
        //  keep the match set small, to avoid overloading the network
        SetSessionTypeDesired(SessionType.HighscoresOnly, NetworkSessionType.PlayerMatch,
          null, 1, 6);
      }
      else
      {
        throw new InvalidOperationException("Can't ShareSomeHighscores() when already connected.");
      }
    }

    /* Start looking for a session with players, where both game data and highscores 
     * data will be exchanged.
     */
    public void FindAPlayerMatch(int nPlayers)
    {
      if (session == null)
      {
        SetSessionTypeDesired(SessionType.HighscoresAndGame, NetworkSessionType.PlayerMatch,
          null, 1, nPlayers);
      }
      else
      {
        throw new InvalidOperationException("Can't FindAPlayerMatch() when already connected.");
      }
    }

    /* The swiss army knife of starting session matching. This will allow you to pass in a 
     * number of filter values (up to 6) as well as various parameters relating to what kind 
     * of session you want. The convenience functions use this function under the hood.
     * type - whether you want to share high scores, or play game, or both
     * nType - system link, playermatch, etc (typically, always playermatch)
     * matchParams - an array of up to 6 integers, which will be matched by other players. 
     *   Can be used for "desired game type" etc. Can be null.
     * localPlayerCount - how many local players you want to have space for
     * totalPlayerCount - how many players total you want to have space for
     */
    public virtual void SetSessionTypeDesired(SessionType type, NetworkSessionType nType, int[] matchParams,
      int localPlayerCount, int totalPlayerCount)
    {
      if (matchParams != null && matchParams.Length > 6)
      {
        throw new InvalidOperationException("Too many matchParams in SetSessionTypeDesired() (6 is max)");
      }
      if (session != null)
      {
        if (type == SessionType.None)
        {
          DisposeSession();
        }
      }
      else
      {
        if (type != SessionType.None)
        {
          netType = nType;
          NetworkSessionProperties props = new NetworkSessionProperties();
          int nProps = 0;
          props[nProps] = (int)type;
          ++nProps;
          if (type != SessionType.HighscoresOnly)
          {
            if (matchParams != null)
            {
              foreach (int val in matchParams)
              {
                props[nProps] = val;
                ++nProps;
              }
            }
          }
          //  minimize the risk that two people using the same sample project GUID find 
          //  the same session during development
          if (type != SessionType.GameOnly)
          {
            props[nProps] = StableHash(Game.GetType().Name);
            Trace.WriteLine(String.Format("hash code is: {0:x}", props[nProps]));
            ++nProps;
          }
          /* Provide some useful defaults. 0/0 means "I want one other player to play with."
           */
          if (totalPlayerCount == 0)
          {
            if (localPlayerCount == 0)
            {
              totalPlayerCount = 1;
            }
            else
            {
              totalPlayerCount = (localPlayerCount == 1) ? 2 : localPlayerCount + 4;
            }
          }
          /* 0 means "all the current local players"
           */
          if (localPlayerCount == 0)
          {
            for (int i = 0; i != 4; ++i)
            {
              GamePadState gps = GamePad.GetState((PlayerIndex)i);
              if (gps.IsConnected)
              {
                ++localPlayerCount;
              }
            }
            if (SignedInGamer.SignedInGamers.Count > localPlayerCount)
            {
              localPlayerCount = SignedInGamer.SignedInGamers.Count;
            }
            totalPlayerCount += localPlayerCount;
          }
          saveLocalPlayerCount = localPlayerCount;
          saveTotalPlayerCount = totalPlayerCount;
          saveMatchParams = matchParams;
          saveProps = props;
          if (SignedInGamer.SignedInGamers.Count > 0)
          {
            /* remember that I want a new kind of network session
             */
            actOnType = true;
          }
        }
      }
      sessionType = type;
    }

    IAsyncResult findAsync_;

    protected virtual void ActOnSessionTypeDesired()
    {
      /* Kick off a new find of network session information.
       */
      Debug.Assert(findAsync_ == null);
      findAsync_ = NetworkSession.BeginFind(netType, saveLocalPlayerCount, saveProps, OnSessionsFound, null);
      Debug.Assert(findAsync_.CompletedSynchronously == false);
    }

    NetworkSessionType netType;
    int saveLocalPlayerCount;
    int saveTotalPlayerCount;
    int[] saveMatchParams;
    NetworkSessionProperties saveProps;
    bool actOnType;

    /* Completion of looking for sessions.
     */
    protected virtual void OnSessionsFound(IAsyncResult ar)
    {
      findAsync_ = null;
      AvailableNetworkSessionCollection availableSessions = NetworkSession.EndFind(ar);
      if (availableSessions.Count != 0)
      {
        /* Pick one of the available sessions.
         */
        List<AvailableNetworkSession> toChooseFrom = new List<AvailableNetworkSession>();
        Trace.WriteLine(String.Format("Found {0} potential network sessions.", availableSessions.Count));
        foreach (AvailableNetworkSession ans in availableSessions)
        {
          if (ans.OpenPublicGamerSlots < saveLocalPlayerCount
            && ans.OpenPublicGamerSlots < SignedInGamer.SignedInGamers.Count)
          {
            //  full
            continue;
          }
          if (sessionType != SessionType.HighscoresOnly || !previousSessionHosts.Member(ans.HostGamertag))
          {
            //  this seems like an OK session, use that!
            toChooseFrom.Add(ans);
          }
        }
        if (toChooseFrom.Count > 0)
        {
          //  pick one at random
          AvailableNetworkSession ans = toChooseFrom[rand.Next(toChooseFrom.Count)];
          previousSessionHosts.Add(ans.HostGamertag);
          Trace.WriteLine(String.Format("Connecting to session hosted by '{0}'", ans.HostGamertag));
          ConnectToSession(ans);
          return;
        }
        else
        {
          /* I went through all the possible sessions, so now I can re-start looking 
           * at hosts I've previously talked to.
           */
          previousSessionHosts.Clear();
        }
      }
      //  OK, nothing matched -- try to create something for others to find
      Trace.WriteLine("Creating session because no available session was suitable.");
      Debug.Assert(createAsync_ == null);
      createAsync_ = NetworkSession.BeginCreate(netType, saveLocalPlayerCount, saveTotalPlayerCount,
        0, saveProps, OnSessionCreated, null);
      Debug.Assert(createAsync_.CompletedSynchronously == false);
    }

    IAsyncResult createAsync_;
    static Random rand = new Random();

    /* A session has actually been created (or failed to be created)
     */
    protected virtual void OnSessionCreated(IAsyncResult ar)
    {
      createAsync_ = null;
      try
      {
        session = NetworkSession.EndCreate(ar);
        if (session == null)
        {
          TryAgain();
        }
        else
        {
          //  After a while, close and try again, if I haven't gotten any players.
          //  There might be someone else waiting for me to connect.
          //  Wait online between 300 and 600 seconds, which works out to 5 - 10 minutes.
          sessionCloseTime = Timing.NowTicks + (rand.Next(300) + 300) * 10000000L;
          sessionEstablished = true;
          UpdateVoice();
        }
      }
      catch (Microsoft.Xna.Framework.Net.NetworkException nex)
      {
        Trace.WriteLine(String.Format("Swallowing network exception: {0}", nex));
        session = null;
      }
    }

    IAsyncResult joinAsync_;

    /* Call this internally when a connection to a given available session is desired.
     */
    protected virtual void ConnectToSession(AvailableNetworkSession sess)
    {
      Trace.WriteLine("Connecting to session host: {0}", sess.HostGamertag);
      Debug.Assert(joinAsync_ == null);
      joinAsync_ = NetworkSession.BeginJoin(sess, OnSessionConnected, null);
      Debug.Assert(joinAsync_.CompletedSynchronously == false);
    }

    /* Hook called when the current session has been disconnected.
     */
    protected virtual void OnSessionDisconnected()
    {
      toSend.Clear();
      if (SessionDisconnected != null)
      {
        SessionDisconnected(this, null);
      }
    }

    /* Called internally when a connection has been established to a session.
     */
    protected virtual void OnSessionConnected(IAsyncResult ar)
    {
      joinAsync_ = null;
      session = NetworkSession.EndJoin(ar);
      if (session == null)
      {
        TryAgain();
      }
      else
      {
        sessionEstablished = true;
        UpdateVoice();
      }
    }

    /* Call this internally when you've found nothing to join, but want to try 
     * again.
     */
    protected virtual void TryAgain()
    {
      tryingAgain = true;
      //  OK, try again
      SetSessionTypeDesired(sessionType, netType, saveMatchParams, saveLocalPlayerCount, saveTotalPlayerCount);
    }

    /* Hook called when I am hosting a session, and that session has started 
     * being available to others.
     */
    protected virtual void OnSessionEstablished()
    {
      session.GamerJoined += new EventHandler<GamerJoinedEventArgs>(session_GamerJoined);
      session.GamerLeft += new EventHandler<GamerLeftEventArgs>(session_GamerLeft);
      UpdateVoice();
      if (SessionEstablished != null)
      {
        SessionEstablishedEventArgs se = new SessionEstablishedEventArgs();
        se.Session = session;
        SessionEstablished(this, se);
      }
    }

    static GamerEventArgs gea = new GamerEventArgs();

    /* Event handler for gamer left; forward to the game if it's listening.
     */
    void session_GamerLeft(object sender, GamerLeftEventArgs e)
    {
      Trace.WriteLine(String.Format("Gamer left: {0}", e.Gamer.Gamertag));
      joinedGamers.Remove(e.Gamer);
      if (GamerLeft != null)
      {
        gea.Gamer = e.Gamer;
        gea.Joined = false;
        GamerLeft(this, gea);
      }
    }

    /* Event handler for gamer joined; forward to the game if it's listening.
     */
    void session_GamerJoined(object sender, GamerJoinedEventArgs e)
    {
      Trace.WriteLine(String.Format("Gamer joined: {0}", e.Gamer.Gamertag));
      if (e.Gamer.IsLocal)
      {
        return;
      }
      if (session != null)
      {
        UpdateVoice();
        if (sessionType == SessionType.HighscoresOnly)
        {
          //  stay open for five minutes, or until the host kills it
          sessionCloseTime = Timing.NowTicks + 300 * 10000000L;
        }
        if (toSend.Count == 0 && storage.HasLoaded)
        {
          LoadHighscores();
        }
      }
      if (sessionType == SessionType.HighscoresAndGame || 
        sessionType == SessionType.HighscoresOnly)
      {
        if (e.Gamer is NetworkGamer)
        {
          NetworkGamer ng = e.Gamer as NetworkGamer;
          if (!ng.IsLocal)
          {
            joinedGamers.Add(e.Gamer, new JoinedGamer(ng));
          }
        }
      }
      if (GamerJoined != null)
      {
        gea.Gamer = e.Gamer;
        gea.Joined = true;
        GamerJoined(this, gea);
      }
    }

    Dictionary<Gamer, JoinedGamer> joinedGamers = new Dictionary<Gamer, JoinedGamer>();

    /* A NetworkGamer that's joined to one of my sessions is a JoinedGamer.
     * JoinedGamer implements the send/ack protocol for trickling highscore
     * data to the other end. Each gamer has a different connection, so each 
     * gamer has a separate list of data to send, and a separate "clear to 
     * send" state flag.
     */
    class JoinedGamer
    {
      internal JoinedGamer(NetworkGamer ng)
      {
        gamer = ng;
        ix = 0;
        clearToSend = true;
        pmw = new PacketMarshalWriter();
        pmw.Writer = new PacketWriter();
      }

      NetworkGamer gamer;
      int ix;
      bool clearToSend;
      PacketMarshalWriter pmw;

      /* The other end has acknowledged receipt of the data.
       */
      internal void Ack(short data)
      {
        Trace.WriteLine(String.Format("Got ack {0} when state {1} from {2}", data, ix, gamer));
        if (data >= ix)
        {
          ix = data;
          clearToSend = true;
        }
      }

      /* SendSome will send some of the available data, without flooding the 
       * other end with bytes. The other end will acknowledge when the data 
       * has gotten there, which will be the go-ahead for me to send more data.
       */
      internal bool SendSome(List<Highscore> scores, NetworkSession sess)
      {
        if (ix >= scores.Count || !clearToSend)
        {
          return false;
        }
        clearToSend = false;
        /* send at most 10 items at once
         */
        int i = scores.Count - ix;
        if (i > 10)
          i = 10;
        Trace.WriteLine(String.Format("SendSome to {0} sending {1} at {2}", gamer, i, ix));
        pmw.Writer.Write((byte)HighscoreItems);
        pmw.Writer.Write((short)(ix + i));
        pmw.Writer.Write((byte)i);
        for (int j = 0; j < i; ++j)
        {
          scores[ix + j].MarshalThrough(pmw);
        }
        sess.LocalGamers[0].SendData(pmw.Writer, SendDataOptions.Reliable, gamer);
        pmw.Writer.Flush();
        pmw.Writer.Seek(0, System.IO.SeekOrigin.Begin);
        return false;
      }
    }

    /* An implementation of the marshal interface for reading data.
     */
    class PacketMarshalReader : Marshal
    {
      public PacketReader Reader;

      public void Marshal(string name, ref DateTime date)
      {
        date = new DateTime(Reader.ReadInt64());
      }

      public void Marshal(string name, ref string txt)
      {
        txt = Reader.ReadString();
      }

      public void Marshal(string name, ref int val)
      {
        val = Reader.ReadInt32();
      }
    }
    PacketMarshalReader PMR = new PacketMarshalReader();

    /* An implementation of the marshal interface for writing data.
     */
    class PacketMarshalWriter : Marshal
    {
      public PacketWriter Writer;

      public void Marshal(string name, ref DateTime date)
      {
        Writer.Write((long)date.Ticks);
      }

      public void Marshal(string name, ref string txt)
      {
        Writer.Write(txt);
      }

      public void Marshal(string name, ref int val)
      {
        Writer.Write((int)val);
      }
    }
    PacketMarshalWriter PMW = new PacketMarshalWriter();
    PacketWriter packetWriter = new PacketWriter(1024);

    /* Given a highscores packet sent to a local player, handle that.
     * The packet itself is in the PacketReader r.
     */
    protected virtual void DoHighscoresPacket(LocalNetworkGamer to, PacketReader r, 
      NetworkGamer from, byte type)
    {
      PMR.Reader = r;
      byte n = 0;
      short tok = 0;
      switch (type)
      {
        case HighscoreItems:
          if (!from.IsLocal)
          {
            tok = r.ReadInt16();
            n = r.ReadByte();
            Trace.WriteLine(String.Format("Received {0} highscores in a packet from {1} (token {2})",
              n, from, tok));
            //  this happens during runtime, so I better not do too many scores at one time
            for (int i = 0; i != n; ++i)
            {
              Highscore hs = new Highscore();
              hs.MarshalThrough(PMR);
              Storage.Instance.AddHighscore(hs, true);
            }
            SendAck(tok, from);
          }
          break;
        case HighscoreItemsAck:
          tok = r.ReadInt16();
          Trace.WriteLine(String.Format("Received ack for pos {0} from {1}", tok, from));
          AckFrom(from, tok);
          break;
        default:
          Trace.WriteLine(String.Format("Swallowing packet type {0} from {1}", type, from));
          break;
      }
    }

    /* When I'm done processing received highscores, send an Ack to the other 
     * end so he/she can send more data.
     */
    protected virtual void SendAck(short tok, NetworkGamer from)
    {
      packetWriter.Write((byte)HighscoreItemsAck);
      packetWriter.Write((short)tok);
      session.LocalGamers[0].SendData(packetWriter, SendDataOptions.Reliable, from);
      packetWriter.Flush();
      packetWriter.Seek(0, System.IO.SeekOrigin.Begin);
    }

    /* StableHash will always give the same output hash code for the 
     * same input string, no matter what the runtime version or byte order 
     * or phase of the moon is. This is important to match up games by 
     * string (name).
     */
    public static int StableHash(string data)
    {
      int n = data.Length * 31;
      for (int i = 0; i != data.Length; ++i)
      {
        n = n * 1928377 + data[i] + 5;
      }
      return n;
    }

    /* packet type 250 */
    const byte HighscoreItems = 250;
    /* packet type 251 */
    const byte HighscoreItemsAck = 251;

    /* Flags for behavior picked up during Update()
     */
    bool tryingAgain;
    bool sessionEstablished;
    bool sessionDisconnected;
    long sessionCloseTime;
    SessionType sessionType;

    /* Event fired when the component is trying to make a connection.
     */
    public event EventHandler TryingConnection;

    /* Event fired when the component has created a session (host or client).
     */
    public event SessionEstablishedHandler SessionEstablished;

    /* Event fired when a session has disconnected (host or client).
     */
    public event EventHandler SessionDisconnected;

    /* Event fired when a gamer has joined the session
     */
    public event GamerEventHandler GamerJoined;

    /* Event fired when a gamer has left the session
     */
    public event GamerEventHandler GamerLeft;
  }

  /* What kind of data to send within a session.
   */
  public enum SessionType
  {
    None,
    HighscoresOnly,
    GameOnly,
    HighscoresAndGame
  }
  public delegate void PacketFunc(LocalNetworkGamer player, PacketReader reader, NetworkGamer sender, byte type);

  public class SessionEstablishedEventArgs : EventArgs
  {
    public NetworkSession Session;
  }
  public delegate void SessionEstablishedHandler(object sender, SessionEstablishedEventArgs e);

  public class GamerEventArgs : EventArgs
  {
    public Gamer Gamer;
    public bool Joined;
  }
  public delegate void GamerEventHandler(object sender, GamerEventArgs e);
}
