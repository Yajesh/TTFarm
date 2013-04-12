<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CropPlanner.ascx.cs" Inherits="DesktopModules_CropPlanner_CropPlanner" %>
<%@ Register assembly="DevExpress.Web.ASPxGridView.v11.2, Version=11.2.10.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxEditors.v11.2, Version=11.2.10.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
    CssFilePath="~/App_Themes/Office2003Olive/{0}/styles.css" 
    CssPostfix="Office2003Olive" DataSourceID="SqlDataCropPlans" KeyFieldName="ID" 
    Width="100%">
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
    <Images SpriteCssFilePath="~/App_Themes/Office2003Olive/{0}/sprite.css">
        <LoadingPanelOnStatusBar Url="~/App_Themes/Office2003Olive/GridView/gvLoadingOnStatusBar.gif">
        </LoadingPanelOnStatusBar>
        <LoadingPanel Url="~/App_Themes/Office2003Olive/GridView/Loading.gif">
        </LoadingPanel>
    </Images>
    <Columns>
        <dx:GridViewCommandColumn VisibleIndex="0">
            <EditButton Visible="True">
            </EditButton>
            <NewButton Visible="True">
            </NewButton>
            <DeleteButton Visible="True">
            </DeleteButton>
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1">
            <EditFormSettings Visible="False" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="UserID" VisibleIndex="2">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="PlanName" VisibleIndex="3">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataDateColumn FieldName="DateCreated" VisibleIndex="4">
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataDateColumn FieldName="LastModified" VisibleIndex="5">
        </dx:GridViewDataDateColumn>
    </Columns>
    <StylesEditors>
        <ProgressBar Height="25px">
        </ProgressBar>
    </StylesEditors>
</dx:ASPxGridView>
<asp:SqlDataSource ID="SqlDataCropPlans" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    DeleteCommand="DELETE FROM [TTFarmCropPlans] WHERE [ID] = @ID" 
    InsertCommand="INSERT INTO [TTFarmCropPlans] ([UserID], [PlanName], [DateCreated], [LastModified]) VALUES (@UserID, @PlanName, @DateCreated, @LastModified)" 
    SelectCommand="SELECT * FROM [TTFarmCropPlans] WHERE ([UserID] = @UserID)" 
    UpdateCommand="UPDATE [TTFarmCropPlans] SET [UserID] = @UserID, [PlanName] = @PlanName, [DateCreated] = @DateCreated, [LastModified] = @LastModified WHERE [ID] = @ID">
    <SelectParameters>
        <asp:SessionParameter DefaultValue="0" Name="UserID" 
            SessionField="TTFarmCurrentUserID" Type="Int64" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int64" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="UserID" Type="Int64" />
        <asp:Parameter Name="PlanName" Type="String" />
        <asp:Parameter Name="DateCreated" Type="DateTime" />
        <asp:Parameter Name="LastModified" Type="DateTime" />
        <asp:Parameter Name="ID" Type="Int64" />
    </UpdateParameters>
    <InsertParameters>
        <asp:Parameter Name="UserID" Type="Int64" />
        <asp:Parameter Name="PlanName" Type="String" />
        <asp:Parameter Name="DateCreated" Type="DateTime" />
        <asp:Parameter Name="LastModified" Type="DateTime" />
    </InsertParameters>
</asp:SqlDataSource>
