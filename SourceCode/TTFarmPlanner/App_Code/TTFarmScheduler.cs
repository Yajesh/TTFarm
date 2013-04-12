using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

/// <summary>
/// Summary description for TTFarmScheduler
/// </summary>
public class TTFarmScheduler
{
    protected ArrayList _schedule = new ArrayList();
    protected  int _currentCapacity = 0;
	public TTFarmScheduler(int maxCapacity)
	{
        _currentCapacity = maxCapacity;
		//
		// TODO: Add constructor logic here
		//
	}

    public int GetCurrentCapacity()
    {
        return _currentCapacity;
    }

    public void Update(DateTime dt)
    {
        ArrayList removeFromList = new ArrayList();
        foreach(TTFramScheduleItem d in _schedule)
        {
            if(d.dt<=dt)
            {
                _currentCapacity += d.quantity;
                removeFromList.Add(d);
            }

        }

        foreach(TTFramScheduleItem d in removeFromList)
        {
            _schedule.Remove(d);
        }

        IComparer c = new SISortByDate();
        _schedule.Sort(c);
    }

    public DateTime GetNextDate()
    {
        if (_schedule.Count > 0)
        {
            return ((TTFramScheduleItem)_schedule[0]).dt;
        }

        return DateTime.Now;
    }

    public void Schedule(DateTime dt, int quantity)
    {
        TTFramScheduleItem i = new TTFramScheduleItem();
        i.dt = dt;
        i.quantity = quantity;
        _currentCapacity -= quantity;
        _schedule.Add(i);
    }
}
