using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Gesture
{
  /* There is a good hash table in the desktop framework, but not in the compact framework.
   * Thus, I write my own, not super-tuned, but better than a linear search through an array,
   * or bending a Dictionary<> to the same use.
   */
  public class HashSet<T> : IEnumerable<T> where T : class
  {
    Link[] hashArray;

    /* Create a new hash set with a default number of buckets.
     */
    public HashSet()
      : this(256)
    {
    }

    /* Create a new hash set with a given number of buckets. The number 
     * must be a power of two (16, 32, 128, 1024, etc), and should be 
     * roughly equal to the number of elements you expect to store, divided 
     * by some small constant (like 1 or 2).
     */
    public HashSet(int cap)
    {
      if ((cap <= 0) ||
        (cap & (cap - 1)) != 0)
      {
        throw new ArgumentException("Capacity must be a power of two");
      }
      hashArray = new Link[cap];
    }

    /* Data is stored in this container structure, which is also used for 
     * chaining to other data items in the same bucket.
     */
    class Link
    {
      internal int hash;
      internal T t;
      internal Link next;
    }

    /* Remove all items in the table, and reset it to a default state.
     */
    public void Clear()
    {
      hashArray = new Link[256];
    }

    /* Test whether a given data item is a member of the set.
     */
    public bool Member(T t)
    {
      int hc = t.GetHashCode();
      int ix = hc & (hashArray.Length - 1);
      Link l = hashArray[ix];
      while (l != null)
      {
        if (l.hash == hc && (object)l.t == (object)t)
        {
          return true;
        }
        l = l.next;
      }
      return false;
    }

    /* Add a data member to the set. If it's already in the set, the set 
     * is not changed. Return true if the item is new, false if it was 
     * already in the set.
     */
    public bool Add(T t)
    {
      int hc = t.GetHashCode();
      int ix = hc & (hashArray.Length - 1);
      return MaybeInsert(ref hashArray[ix], hc, t);
    }

    /* Helper function for adding an element to a bucket chain (linked list), 
     * assuming the element is not already in that chain.
     */
    static bool MaybeInsert(ref Link l, int hc, T t)
    {
      if (l == null)
      {
        l = new Link();
        l.hash = hc;
        l.t = t;
        return true;
      }
      if (l.hash == hc && (object)l.t == (object)t)
      {
        return false;
      }
      //  tail recursion, please?
      return MaybeInsert(ref l.next, hc, t);
    }

    /* A value enumerator that attempts to not generate garbage when 
     * iterating over all the values in the set.
     */
    struct ValueEnumerator : IEnumerator<T>
    {
      internal ValueEnumerator(Link[] a)
      {
        ar = a;
        n = 0;
        l = null;
      }
      Link[] ar;
      int n;
      Link l;

      #region IEnumerator<T> Members

      public T Current
      {
        get { return l.t; }
      }

      #endregion

      #region IDisposable Members

      public void Dispose()
      {
      }

      #endregion

      #region IEnumerator Members

      object System.Collections.IEnumerator.Current
      {
        get { return l.t; }
      }

      public bool MoveNext()
      {
        if (l != null)
        {
          l = l.next;
        }
        while (l == null && n < ar.Length)
        {
          l = ar[n];
          ++n;
        }
        return l != null;
      }

      public void Reset()
      {
        l = null;
        n = 0;
      }

      #endregion
    }

    #region IEnumerable<T> Members

    /* Support iteration of the set.
     */
    public IEnumerator<T> GetEnumerator()
    {
      return new ValueEnumerator(hashArray);
    }

    #endregion

    #region IEnumerable Members

    /* Support iteration of the set (old-style).
     */
    System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator()
    {
      return new ValueEnumerator(hashArray);
    }

    #endregion
  }
}