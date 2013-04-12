<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CropPlan.ascx.cs" Inherits="DesktopModules_CropPlan_CropPlan" %>
<%@ Register assembly="DevExpress.Web.ASPxGridView.v11.2, Version=11.2.10.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.2, Version=11.2.10.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<%@ Register assembly="DevExpress.XtraCharts.v11.2.Web, Version=11.2.10.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts.Web" tagprefix="dxchartsui" %>
<%@ Register assembly="DevExpress.XtraCharts.v11.2, Version=11.2.10.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="cc1" %>
<style type="text/css">
    .style1
    {
        width: 126%;
    }
</style>
<table style="width:100%;">
    <tr>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
                CssFilePath="~/App_Themes/Office2003Olive/{0}/styles.css" 
                CssPostfix="Office2003Olive" DataSourceID="SqlDataCropPlan" KeyFieldName="ID" 
                onrowinserting="ASPxGridView1_RowInserting" ClientInstanceName="GridView">
                <Styles CssFilePath="~/App_Themes/Office2003Olive/{0}/styles.css" 
                    CssPostfix="Office2003Olive">
                    <Header ImageSpacing="5px" SortingImageSpacing="5px">
                    </Header>
                    <LoadingPanel ImageSpacing="10px">
                    </LoadingPanel>
                </Styles>
                <ImagesFilterControl>
                    <LoadingPanel Url="~/App_Themes/Office2003Olive/Editors/Loading.gif">
                    </LoadingPanel>
                </ImagesFilterControl>
                <TotalSummary>
                    <dx:ASPxSummaryItem FieldName="ExpectedIncome" ShowInColumn="Expected Income" 
                        ShowInGroupFooterColumn="Expected Income" SummaryType="Sum" Tag="Total Income" 
                        ValueDisplayFormat="$0.00" />
                </TotalSummary>
                <Images SpriteCssFilePath="~/App_Themes/Office2003Olive/{0}/sprite.css">
                    <LoadingPanelOnStatusBar Url="~/App_Themes/Office2003Olive/GridView/gvLoadingOnStatusBar.gif">
                    </LoadingPanelOnStatusBar>
                    <LoadingPanel Url="~/App_Themes/Office2003Olive/GridView/Loading.gif">
                    </LoadingPanel>
                </Images>
                <Columns>
                    <dx:GridViewCommandColumn VisibleIndex="0">
                        <NewButton Visible="True">
                        </NewButton>
                        <EditButton Visible="True">
                        </EditButton>
                        <DeleteButton Visible="True">
                        </DeleteButton>
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" Visible="False" 
                        VisibleIndex="1">
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="PlanID" Visible="False" VisibleIndex="2">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataComboBoxColumn Caption="Crop" FieldName="CropID" 
                        VisibleIndex="3">
                        <PropertiesComboBox DataSourceID="SqlDataCrops" TextField="Description" 
                            ValueField="ID" ValueType="System.Int32">
                        </PropertiesComboBox>
                    </dx:GridViewDataComboBoxColumn>
                    <dx:GridViewDataTextColumn FieldName="BedsNo" VisibleIndex="4">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="PlantsPerBed" VisibleIndex="5" 
                        Visible="False">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="MaturityDays" VisibleIndex="6">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="PlantingDays" VisibleIndex="7">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="ExpectedHarvestDate" VisibleIndex="8">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="ExpectedYield" VisibleIndex="9">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="ExpectedIncome" VisibleIndex="10">
                        <PropertiesTextEdit DisplayFormatString="$0.00">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                </Columns>
                <Settings ShowFooter="True" />
                <StylesEditors>
                    <ProgressBar Height="25px">
                    </ProgressBar>
                </StylesEditors>
            </dx:ASPxGridView>
        </td>
    </tr>
    <tr>
        <td>
        <table>
        <tr>
        <td>
            <dx:ASPxButton ID="ASPxBtnCalculate" runat="server" Text="Calculate" 
                onclick="ASPxBtnCalculate_Click">
                <ClientSideEvents Click="function(s, e) {
	GridView.PerformCallback(&quot;&quot;);
}" />
            </dx:ASPxButton>
            </td>
        <td></td>
        <td>
            <dx:ASPxButton ID="ASPxButton1" runat="server" onclick="ASPxButton1_Click" 
                Text="Run Optimiser">
            </dx:ASPxButton>
            </td>
        </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td>
        <table>
            <tr>
            <td class="style1">
                <dxchartsui:WebChartControl ID="WebChartControl1" runat="server" 
                    AppearanceNameSerializable="The Trees" DataSourceID="SqlDataSourceChar1Yield" 
                    Height="300px" Width="400px">
                    <titles>
                        <cc1:ChartTitle Text="Yeild Distribution" />
                    </titles>
<SeriesTemplate><ViewSerializable>
    <cc1:Pie3DSeriesView>
    </cc1:Pie3DSeriesView>
</ViewSerializable>
<LabelSerializable>
    <cc1:Pie3DSeriesLabel LineVisible="True">
        <fillstyle>
            <optionsserializable>
                <cc1:SolidFillOptions />
            </optionsserializable>
        </fillstyle>
        <pointoptionsserializable>
            <cc1:PiePointOptions>
            </cc1:PiePointOptions>
        </pointoptionsserializable>
    </cc1:Pie3DSeriesLabel>
</LabelSerializable>
<LegendPointOptionsSerializable>
    <cc1:PiePointOptions>
    </cc1:PiePointOptions>
</LegendPointOptionsSerializable>
</SeriesTemplate>

<FillStyle><OptionsSerializable>
<cc1:SolidFillOptions></cc1:SolidFillOptions>
</OptionsSerializable>
</FillStyle>
                    <seriesserializable>
                        <cc1:Series ArgumentDataMember="Description" Name="Yield" 
                            SynchronizePointOptions="False" ValueDataMembersSerializable="ExpectedYield">
                            <viewserializable>
                                <cc1:Pie3DSeriesView>
                                </cc1:Pie3DSeriesView>
                            </viewserializable>
                            <labelserializable>
                                <cc1:Pie3DSeriesLabel LineVisible="True">
                                    <fillstyle>
                                        <optionsserializable>
                                            <cc1:SolidFillOptions />
                                        </optionsserializable>
                                    </fillstyle>
                                    <pointoptionsserializable>
                                        <cc1:PiePointOptions>
                                        </cc1:PiePointOptions>
                                    </pointoptionsserializable>
                                </cc1:Pie3DSeriesLabel>
                            </labelserializable>
                            <legendpointoptionsserializable>
                                <cc1:PiePointOptions PointView="Argument">
                                </cc1:PiePointOptions>
                            </legendpointoptionsserializable>
                        </cc1:Series>
                    </seriesserializable>
                    <diagramserializable>
                        <cc1:SimpleDiagram3D RotationMatrixSerializable="1;0;0;0;0;0.5;-0.866025403784439;0;0;0.866025403784439;0.5;0;0;0;0;1">
                        </cc1:SimpleDiagram3D>
                    </diagramserializable>
                </dxchartsui:WebChartControl>
            </td>

<td>
    <dxchartsui:WebChartControl ID="WebChartControl2" runat="server" 
        AppearanceNameSerializable="The Trees" DataSourceID="SqlDataSourceChar2Income" 
        Height="300px" Width="400px">
        <titles>
            <cc1:ChartTitle Text="Expected Income per Month" />
        </titles>
<SeriesTemplate><ViewSerializable>
<cc1:SideBySideBarSeriesView></cc1:SideBySideBarSeriesView>
</ViewSerializable>
<LabelSerializable>
<cc1:SideBySideBarSeriesLabel LineVisible="True">
<FillStyle><OptionsSerializable>
<cc1:SolidFillOptions></cc1:SolidFillOptions>
</OptionsSerializable>
</FillStyle>
<PointOptionsSerializable>
<cc1:PointOptions></cc1:PointOptions>
</PointOptionsSerializable>
</cc1:SideBySideBarSeriesLabel>
</LabelSerializable>
<LegendPointOptionsSerializable>
<cc1:PointOptions></cc1:PointOptions>
</LegendPointOptionsSerializable>
</SeriesTemplate>

<FillStyle><OptionsSerializable>
<cc1:SolidFillOptions></cc1:SolidFillOptions>
</OptionsSerializable>
</FillStyle>
        <seriesserializable>
            <cc1:Series ArgumentDataMember="Month" ArgumentScaleType="Numerical" 
                Name="Income" ValueDataMembersSerializable="ExpectedIncome">
                <viewserializable>
                    <cc1:SideBySideBarSeriesView>
                    </cc1:SideBySideBarSeriesView>
                </viewserializable>
                <labelserializable>
                    <cc1:SideBySideBarSeriesLabel LineVisible="True">
                        <fillstyle>
                            <optionsserializable>
                                <cc1:SolidFillOptions />
                            </optionsserializable>
                        </fillstyle>
                        <pointoptionsserializable>
                            <cc1:PointOptions>
                                <valuenumericoptions format="FixedPoint" />
                            </cc1:PointOptions>
                        </pointoptionsserializable>
                    </cc1:SideBySideBarSeriesLabel>
                </labelserializable>
                <legendpointoptionsserializable>
                    <cc1:PointOptions>
                        <valuenumericoptions format="FixedPoint" />
                    </cc1:PointOptions>
                </legendpointoptionsserializable>
            </cc1:Series>
        </seriesserializable>
        <diagramserializable>
            <cc1:XYDiagram>
                <axisx visibleinpanesserializable="-1">
                    <range sidemarginsenabled="True" />
                </axisx>
                <axisy visibleinpanesserializable="-1">
                    <range sidemarginsenabled="True" />
                </axisy>
            </cc1:XYDiagram>
        </diagramserializable>
    </dxchartsui:WebChartControl>
</td>
            </tr>

        </table>
        
        </td>
    </tr>
</table>
<asp:SqlDataSource ID="SqlDataCropPlan" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    DeleteCommand="DELETE FROM [TTFarmCropPlan] WHERE [ID] = @ID" 
    InsertCommand="INSERT INTO [TTFarmCropPlan] ([PlanID], [CropID], [BedsNo], [PlantsPerBed], [MaturityDays], [PlantingDays], [ExpectedHarvestDate], [ExpectedYield], [ExpectedIncome]) VALUES (@PlanID, @CropID, @BedsNo, @PlantsPerBed, @MaturityDays, @PlantingDays, @ExpectedHarvestDate, @ExpectedYield, @ExpectedIncome)" 
    SelectCommand="SELECT * FROM [TTFarmCropPlan] WHERE ([PlanID] = @PlanID)" 
    UpdateCommand="UPDATE [TTFarmCropPlan] SET [PlanID] = @PlanID, [CropID] = @CropID, [BedsNo] = @BedsNo, [PlantsPerBed] = @PlantsPerBed, [MaturityDays] = @MaturityDays, [PlantingDays] = @PlantingDays, [ExpectedHarvestDate] = @ExpectedHarvestDate, [ExpectedYield] = @ExpectedYield, [ExpectedIncome] = @ExpectedIncome WHERE [ID] = @ID">
    <SelectParameters>
        <asp:SessionParameter DefaultValue="0" Name="PlanID" 
            SessionField="TTFarmCropPlanID" Type="Int64" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int64" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="PlanID" Type="Int64" />
        <asp:Parameter Name="CropID" Type="Int64" />
        <asp:Parameter Name="BedsNo" Type="Int32" />
        <asp:Parameter Name="PlantsPerBed" Type="Int32" />
        <asp:Parameter Name="MaturityDays" Type="Int32" />
        <asp:Parameter Name="PlantingDays" Type="DateTime" />
        <asp:Parameter Name="ExpectedHarvestDate" Type="DateTime" />
        <asp:Parameter Name="ExpectedYield" Type="Double" />
        <asp:Parameter Name="ExpectedIncome" Type="Double" />
        <asp:Parameter Name="ID" Type="Int64" />
    </UpdateParameters>
    <InsertParameters>
        <asp:Parameter Name="PlanID" Type="Int64" />
        <asp:Parameter Name="CropID" Type="Int64" />
        <asp:Parameter Name="BedsNo" Type="Int32" />
        <asp:Parameter Name="PlantsPerBed" Type="Int32" />
        <asp:Parameter Name="MaturityDays" Type="Int32" />
        <asp:Parameter Name="PlantingDays" Type="DateTime" />
        <asp:Parameter Name="ExpectedHarvestDate" Type="DateTime" />
        <asp:Parameter Name="ExpectedYield" Type="Double" />
        <asp:Parameter Name="ExpectedIncome" Type="Double" />
    </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataCrops" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT * FROM [TTFarmCommodities]"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceChar1Yield" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT c.Description, MONTH(p.ExpectedHarvestDate) AS Month, p.ExpectedYield FROM dbo.TTFarmCropPlan p INNER JOIN dbo.TTFarmCommodities c ON p.CropID=c.ID WHERE p.PlanID=@PlanID ORDER BY Month">
    <SelectParameters>
        <asp:SessionParameter DefaultValue="0" Name="PlanID" 
            SessionField="TTFarmChartPlanID" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSourceChar2Income" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT MONTH(p.ExpectedHarvestDate) AS Month, p.ExpectedIncome FROM dbo.TTFarmCropPlan p INNER JOIN dbo.TTFarmCommodities c ON p.CropID=c.ID WHERE p.PlanID=@PlanID ORDER BY Month">
    <SelectParameters>
        <asp:SessionParameter DefaultValue="0" Name="PlanID" 
            SessionField="TTFarmChartPlanID" />
    </SelectParameters>
</asp:SqlDataSource>


