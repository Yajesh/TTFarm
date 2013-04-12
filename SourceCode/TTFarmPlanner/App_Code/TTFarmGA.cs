using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
/// <summary>
/// Summary description for TTFarmGA
/// </summary>
using System.Runtime.InteropServices;
public class TTFarmGA
{
    protected Random _randGen = new Random(1000);
    protected TTFarmChromosome _best = null;
	public TTFarmGA()
	{
        
	}

    protected ArrayList Initialize(ArrayList genes, int maxBeds)
    {
        ArrayList chromosomes = new ArrayList();
        TTFarmPriceCache priceCache = new TTFarmPriceCache();

        TTFarmDataSetTableAdapters.QueriesTableAdapter queries = new TTFarmDataSetTableAdapters.QueriesTableAdapter();

        foreach (TTFarmGene g in genes) 
        {
            double? maturityDays = 0.0;
            double? expectedYieldRt = 0.0;
            queries.TTFarmGetCropInfo(g.cropID, ref maturityDays, ref expectedYieldRt);

            g.maturityDays = Convert.ToInt32(maturityDays);
            g.yieldRate = Convert.ToInt32(expectedYieldRt);


        }

        for (int i = 0; i < 100; i++)
        {
            TTFarmChromosome chromosome = new TTFarmChromosome();
            foreach (TTFarmGene g in genes)
            {
                TTFarmGene g1 = new TTFarmGene();
                g1.cropID = g.cropID;
                g1.maturityDays = g.maturityDays;
                g1.yieldRate = g.yieldRate;

                g1.noBeds = _randGen.Next(maxBeds) + 1;
                g1.plantDate = DateTime.Now.AddDays(_randGen.Next(270) + 1);
                g1.cache = priceCache;

                chromosome.Add(g1);
            }
            chromosomes.Add(chromosome);
        }

        return chromosomes;
    }

    public TTFarmChromosome Select(ArrayList chromosomes, double v)
    {
        TTFarmChromosome retVal = null;
        double sum = 0;
        foreach (TTFarmChromosome c in chromosomes)
        {
            sum += c.totalIncome;
            if (sum >= v)
            {
                retVal = c;
                break;
            }
        }

        return retVal;
    }

    public ArrayList NextGeneration(ArrayList chromosomes, int maxBeds)
    {
        ArrayList newGeneration = new ArrayList();
        double total = 0;
        foreach (TTFarmChromosome c in chromosomes)
        {
            total += c.totalIncome;
        }

        for (int i = 0; i < 40; i++)
        {
            TTFarmChromosome c1 = Select(chromosomes, _randGen.NextDouble()*total).Clone();
            TTFarmChromosome c2 = Select(chromosomes, _randGen.NextDouble() * total).Clone();

            
            for(int j = 0; j<c1.genes.Count; j++)
            {
                if (j % 2 == 0)
                {
                    ((TTFarmGene)c2.genes[j]).plantDate = ((TTFarmGene)c1.genes[j]).plantDate;
                }
                else
                {
                    ((TTFarmGene)c1.genes[j]).plantDate = ((TTFarmGene)c2.genes[j]).plantDate;
                }
            }

            newGeneration.Add(c1);
            newGeneration.Add(c2);
        }

        for (int i = 0; i < 20; i++)
        {
            TTFarmChromosome c1 = Select(chromosomes, _randGen.NextDouble() * total).Clone();

            for (int j=0; j < c1.genes.Count; j++ )
            {
                if (_randGen.NextDouble() < 0.5)
                {
                    ((TTFarmGene)c1.genes[j]).noBeds = ((TTFarmGene)c1.genes[j]).noBeds + 5;
                    if (((TTFarmGene)c1.genes[j]).noBeds>maxBeds)
                    {
                        ((TTFarmGene)c1.genes[j]).noBeds = maxBeds;
                    }
                }
            }

            newGeneration.Add(c1);
        }

        return newGeneration;
    }

    public void Evaluate(ArrayList chromosomes, int maxBeds)
    {
        foreach (TTFarmChromosome chromosome in chromosomes)
        {
            TTFarmScheduler scheduler = new TTFarmScheduler(maxBeds);
            chromosome.SortByDate();

            int currentCapacity = maxBeds;
            for (int i = 0; i < chromosome.genes.Count; i++)
            {
                TTFarmGene ge = (TTFarmGene)chromosome.genes[i];

                DateTime dt = ge.plantDate;
                scheduler.Update(dt);

                while (ge.noBeds > scheduler.GetCurrentCapacity())
                {
                    dt= scheduler.GetNextDate();
                    scheduler.Update(dt);
                }

                ge.plantDate = dt;

                chromosome.totalIncome += ge.CaluclateIncome();

                if (_best != null)
                {
                    if (_best.totalIncome < chromosome.totalIncome)
                    {
                        _best = chromosome.Clone();
                    }
                }
                else
                {
                    _best = chromosome.Clone();
                }

                scheduler.Schedule(ge.havestDate, (int)ge.noBeds);
            }

        }
    }

    public void Execute(ArrayList genes, int maxBeds, int newPlanID)
    {
        ArrayList chromosomes = Initialize(genes, maxBeds);

        for (int i = 1; i < 100; i++)
        {
            Evaluate(chromosomes, maxBeds);
            chromosomes = NextGeneration(chromosomes, maxBeds);
        }

        TTFarmDataSetTableAdapters.QueriesTableAdapter queries = new TTFarmDataSetTableAdapters.QueriesTableAdapter();
        for(int i=0; i<_best.genes.Count; i++)
        {
            TTFarmGene g = (TTFarmGene)_best.genes[i];
            queries.TTFarmInsertPlan(newPlanID, g.cropID, (int)g.noBeds, -1, g.maturityDays, g.plantDate, g.havestDate, g.expYield, g.income);
        }

    }


}
