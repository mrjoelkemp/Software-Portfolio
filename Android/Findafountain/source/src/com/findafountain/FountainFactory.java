package com.findafountain;

import com.findafountain.ObjectPool.PoolableFactory;

/**
 * Represents a factory of Fountain objects. We use this class in 
 * conjunction with the ObjectPool class to manage and reuse 
 * instantiations of fountain objects.
 * @author Joel
 *
 */
public class FountainFactory implements PoolableFactory<Fountain>
{

	@Override
	public Fountain makeObject()
	{
		return new Fountain();
	}

}
