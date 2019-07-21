<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Networx.Contact" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Networx</title>
    <link rel="stylesheet" type="text/css" href="style.css" />
</head>
  <script type = "text/javascript">
        function ConfirmDelete() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("ARE SURE YOU WANT TO DELETE THIS?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
    <script>
        function ConfirmSubmit() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Are all details correct?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

    </script>

    <script>
        var bannerStatus = 1;
        var bannerTimer = 4000;

        window.onload = function () {
            bannerloop();
        }
        var startBannerLoop = setInterval(function(){
            bannerloop();
        }, bannerTimer);
        
       

        function bannerloop() {
            if (bannerStatus === 1) {
                document.getElementById("imgban2").style.opacity = "0";
                setTimeout(function () {
                document.getElementById("imgban1").style.right = "0px";
                document.getElementById("imgban1").style.zIndex = "1000";
                document.getElementById("imgban2").style.right = "-1200px";
                document.getElementById("imgban2").style.zIndex = "1500";
                document.getElementById("imgban3").style.right = "1200px";
                document.getElementById("imgban3").style.zIndex = "500";
                }, 500);
                setTimeout(function () {
                    document.getElementById("imgban2").style.opacity = "1";
                } , 1000);
                bannerStatus = 2;
            }
             else if (bannerStatus === 2) {
                document.getElementById("imgban3").style.opacity = "0";
                setTimeout(function () {
                document.getElementById("imgban2").style.right = "0px";
                document.getElementById("imgban2").style.zIndex = "1000";
                document.getElementById("imgban3").style.right = "-1200px";
                document.getElementById("imgban3").style.zIndex = "1500";
                document.getElementById("imgban1").style.right = "1200px";
                document.getElementById("imgban1").style.zIndex = "500";
                }, 500);
                setTimeout(function () {
                    document.getElementById("imgban3").style.opacity = "1";
                } , 1000);
                bannerStatus = 3;
            }
             else if (bannerStatus === 3) {
                document.getElementById("imgban1").style.opacity = "0";
                setTimeout(function () {
                document.getElementById("imgban3").style.right = "0px";
                document.getElementById("imgban3").style.zIndex = "1000";
                document.getElementById("imgban1").style.right = "-1200px";
                document.getElementById("imgban1").style.zIndex = "1500";
                document.getElementById("imgban2").style.right = "1200px";
                document.getElementById("imgban2").style.zIndex = "500";
                }, 500);
                setTimeout(function () {
                    document.getElementById("imgban1").style.opacity = "1";
                } , 1000);
                bannerStatus = 1;
            }
            
        }
    </script>


    <div class="main-banner" id="main-banner">
        
        <div class="imgban" id="imgban3"></div>
        
        <div class="imgban" id="imgban2"></div>

        <div class="imgban" id="imgban1"></div>
        
    </div>
    <form id="form1" runat="server">
    <div>
        <asp:HiddenField ID="hfContactID" runat="server" />
        <table class="form">
            <tr>
 
                <TextBox readonly Hidden id="txtID" runat="server"> 
        </TextBox>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server" Text="Mobile"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtMobile" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label3" runat="server" Text="Adddress"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    
                </td>
                <td colspan="2" >
                    <asp:Button ID="btnSave" runat="server" Text="Submit" OnClick="btnSave_Click" onclientclick="ConfirmSubmit()"/>
                    <asp:Button ID="btnUP" runat="server" Text="Update" OnClick="btnUP_Click" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" onclientclick="ConfirmDelete()" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />

                </td>
            </tr>
            <tr>
                
                <td colspan="2">
                    <asp:Label ID="lblSuccessMessage" runat="server" Text="" ForeColor="Green"></asp:Label>
                </td>
                </tr>
                <tr>
                <td>
                    
                </td>
                <td colspan="2">
                    <asp:Label ID="lblErrorMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            
        </table>
        <br />
        <asp:GridView ID="gvContact" runat="server" AutoGenerateColumns="false" class="gvContact">
            <Columns>
                <asp:BoundField DataField="ContactID" HeaderText="ContactID" />
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
                <asp:BoundField DataField="Address" HeaderText="Address" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkView" runat="server" CommandArgument='<%# Eval("ContactID") %>' OnClick="lnk_OnClick">View</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    </form>
</body>
</html>
