using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

/// <summary>
/// Summary description for TTFarmGene
/// </summary>
public class TTFarmGene
{
    public long cropID = 0;
    public long noBeds = 0;
    public DateTime plantDate = DateTime.Now;
    public DateTime havestDate = DateTime.Now;
    public int maturityDays = 0;
    public double yieldRate = 0;
    public double expYield = 0;
    public double income = 0;
    public TTFarmPriceCache cache = null;

    public TTFarmGene Clone()
    {
        TTFarmGene clone = new TTFarmGene();
        clone.cropID = cropID;
        clone.noBeds = noBeds;
        clone.plantDate = plantDate;
        clone.havestDate = havestDate;
        clone.maturityDays = maturityDays;
        clone.yieldRate = yieldRate;
        clone.expYield = expYield;
        clone.income = income;
        clone.cache = cache;

        return clone;
    }

    public TTFarmGene()
	{
	}

    public double CaluclateIncome()
    {
        havestDate = plantDate.AddDays(maturityDays);

        //TTFarmDataSetTableAdapters.QueriesTableAdapter queries = new TTFarmDataSetTableAdapters.QueriesTableAdapter();
        //double? price = 0;
        //queries.TTFarmGetAvgPriceByMonth(cropID, havestDate.Month, ref price);

        double price = cache.Lookup(cropID, havestDate.Month);

        expYield = noBeds * yieldRate;
        income = noBeds * yieldRate * price;

        return income;
    }
}

public class SortByDate : IComparer
{
    public int Compare(object x1, object y1)
    {
        TTFarmGene x = (TTFarmGene)x1;
        TTFarmGene y = (TTFarmGene)y1;

        if (x.plantDate < y.plantDate)
        {
            return -1;
        }
        else if (x.plantDate > y.plantDate)
        {
            return 1;
        }

        return 0;
    }
}