using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Security;

public partial class DesktopModules_CropPlanner_CropPlanner : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DotNetNuke.Entities.Users.UserInfo uInfo =  DotNetNuke.Entities.Users.UserController.GetCurrentUserInfo();

        this.Session["TTFarmCurrentUserID"] = uInfo.UserID;
    }
}
