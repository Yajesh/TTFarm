using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

/// <summary>
/// Summary description for TTFramScheduleItem
/// </summary>
public class TTFramScheduleItem
{
    public DateTime dt;
    public int quantity;

	public TTFramScheduleItem()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}

public class SISortByDate : IComparer
{
    public int Compare(object x1, object y1)
    {
        TTFramScheduleItem x = (TTFramScheduleItem)x1;
        TTFramScheduleItem y = (TTFramScheduleItem)y1;

        if (x.dt < y.dt)
        {
            return -1;
        }
        else if (x.dt > y.dt)
        {
            return 1;
        }

        return 0;
    }
}