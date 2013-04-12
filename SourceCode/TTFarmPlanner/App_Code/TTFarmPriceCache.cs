using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
/// <summary>
/// Summary description for TTFarmPriceCache
/// </summary>
public class TTFarmPriceCache
{
    public Hashtable _lookup = new Hashtable();
	public TTFarmPriceCache()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public double Lookup(long cropId, int month)
    {
        if (_lookup.Keys.Count == 0)
        {
        }

        if (_lookup.ContainsKey(cropId))
        {
            Hashtable monthPrice = (Hashtable)_lookup[cropId];
            if (monthPrice.ContainsKey(month))
            {
                return (double)monthPrice[month];
            }
            else
            {
                TTFarmDataSetTableAdapters.QueriesTableAdapter queries = new TTFarmDataSetTableAdapters.QueriesTableAdapter();
                double? price = 0;
                queries.TTFarmGetAvgPriceByMonth(cropId, month, ref price);

                monthPrice.Add(month, price);

                return Convert.ToDouble(price);
            }
        }
        else
        {
            TTFarmDataSetTableAdapters.QueriesTableAdapter queries = new TTFarmDataSetTableAdapters.QueriesTableAdapter();
            double? price = 0;
            queries.TTFarmGetAvgPriceByMonth(cropId, month, ref price);

            Hashtable monthPrice = new Hashtable();
            monthPrice.Add(month, price);

            _lookup.Add(cropId, monthPrice);

            return Convert.ToDouble(price);
        }
    }
}
