using System;
using System.Collections.Generic;
using System.Linq;
using DotNetNuke.Entities.Modules;
using System.Collections;

public partial class DesktopModules_CropPlan_CropPlan : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Session["TTFarmCropPlanID"] = Request.QueryString["planid"];
        this.Session["TTFarmChartPlanID"] = Request.QueryString["planid"];
        
    }
    protected void ASPxGridView1_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
    {
        e.NewValues["PlanID"] = this.Session["TTFarmCropPlanID"];
    }
    protected void ASPxBtnCalculate_Click(object sender, EventArgs e)
    {
        TTFarmDataSetTableAdapters.TTFarmCropPlanTableAdapter tableAdapter = new TTFarmDataSetTableAdapters.TTFarmCropPlanTableAdapter();
        TTFarmDataSet.TTFarmCropPlanDataTable table = tableAdapter.GetData();

        TTFarmDataSetTableAdapters.QueriesTableAdapter queries = new TTFarmDataSetTableAdapters.QueriesTableAdapter();

        foreach(TTFarmDataSet.TTFarmCropPlanRow r in table)
        {
            if (r.PlanID == Convert.ToInt64(this.Session["TTFarmCropPlanID"]))
            {
                if (!r.IsBedsNoNull() &&  !r.IsPlantingDaysNull())
                {
                    double? maturityDays = 0.0;
                    double? expectedYieldRt = 0.0;
                    queries.TTFarmGetCropInfo(r.CropID, ref maturityDays, ref expectedYieldRt);

                    
                    if(!r.IsMaturityDaysNull())
                    {
                        maturityDays = r.MaturityDays;
                    }

                    DateTime expectedHarvestDate;
                    if (r.IsExpectedHarvestDateNull())
                    {
                        expectedHarvestDate = r.PlantingDays.AddDays(Convert.ToDouble(maturityDays));
                    }
                    else 
                    {
                        expectedHarvestDate = r.ExpectedHarvestDate;
                    }

                    double expectedYield = 0;
                    if (r.IsExpectedYieldNull())
                    {
                        expectedYield = r.BedsNo * 1* Convert.ToDouble(expectedYieldRt);
                    }
                    else
                    {
                        expectedYield = Convert.ToDouble(r.ExpectedYield);
                    }
                    double expectedIncome = 0;
                    //if (r.IsExpectedIncomeNull())
                    //{
                        double? price = 0;
                        queries.TTFarmGetAvgPriceByMonth(r.CropID, expectedHarvestDate.Month, ref price);
                        expectedIncome = expectedYield * Convert.ToDouble(price);
                    //}
                    //else
                    //{
                    //    expectedIncome = Convert.ToDouble(r.ExpectedIncome);
                    //}
                    queries.TTFarmUpdateCropPlan(r.PlanID, r.CropID, Convert.ToInt32(maturityDays), expectedHarvestDate, expectedYield, expectedIncome);
                }


            }
        }
        Response.Redirect("CropPlan.aspx?planid=" + this.Session["TTFarmCropPlanID"]);
    }
    protected void ASPxButton1_Click(object sender, EventArgs e)
    {
        TTFarmDataSetTableAdapters.TTFarmCropPlanTableAdapter tableAdapter = new TTFarmDataSetTableAdapters.TTFarmCropPlanTableAdapter();
        TTFarmDataSet.TTFarmCropPlanDataTable table = tableAdapter.GetData();

        TTFarmDataSetTableAdapters.QueriesTableAdapter queries = new TTFarmDataSetTableAdapters.QueriesTableAdapter();
        TTFarmGA ga = new TTFarmGA();

        long? planID = 0;
        queries.TTFarmGetNextPlanID(ref planID);

        ArrayList genes = new ArrayList();

        foreach (TTFarmDataSet.TTFarmCropPlanRow r in table)
        {
            if (r.PlanID == Convert.ToInt64(this.Session["TTFarmCropPlanID"]))
            {
                TTFarmGene g1 = new TTFarmGene();
                g1.cropID = r.CropID;
                genes.Add(g1);
            }
        }

        ga.Execute(genes, 100, Convert.ToInt32(planID)+1);

        Response.Redirect("CropPlan.aspx?planid=" + Convert.ToString(planID+1));

    }
}
