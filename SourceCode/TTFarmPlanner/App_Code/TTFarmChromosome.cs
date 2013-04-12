using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

/// <summary>
/// Summary description for Chromosome
/// </summary>
public class TTFarmChromosome
{
    public ArrayList genes = new ArrayList();
    public double totalIncome = 0;

    public TTFarmChromosome Clone()
    {
        TTFarmChromosome clone = new TTFarmChromosome();
        clone.totalIncome = totalIncome;

        foreach (TTFarmGene g in genes)
        {
            clone.genes.Add(g.Clone());
        }

        return clone;
    }

    public void Add(TTFarmGene g)
    {
        genes.Add(g);
    }

    public void SortByDate()
    {
        IComparer s = new SortByDate();
        genes.Sort(s);
    }

    public TTFarmChromosome()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}

