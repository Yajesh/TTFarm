using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

/// <summary>
/// Summary description for TTFarmGATest
/// </summary>
public class TTFarmGATest
{
	public TTFarmGATest()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public void Execute()
    {
        TTFarmGA ga = new TTFarmGA();
        TTFarmDataSetTableAdapters.QueriesTableAdapter queries = new TTFarmDataSetTableAdapters.QueriesTableAdapter();

        long? planID = 0;
        queries.TTFarmGetNextPlanID(ref planID);
       
        ArrayList genes = new ArrayList();
        TTFarmGene g1 = new TTFarmGene();


    }
}
