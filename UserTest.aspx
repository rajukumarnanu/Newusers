<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserTest.aspx.cs" Inherits="TESTUSERS.users.UserTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     
    <script src="jquery-3.5.1.min.js" type="text/javascript"></script> 

    <style>
        table {
            margin: 0 auto;
            font-size: small;
            border: 1px solid black;
            font-family: 'Verdana';
        }

        h1 {
            text-align: center;
            color: #006600;
            font-size: xx-large;
            font-family: 'Verdana';
        }

        td {
            background-color: #E4F5D4;
            border: 1px solid black;
        }

        th,
        td {
            font-weight: bold;
            border: 1px solid black;
            padding: 10px;
            text-align: center;
        }

        td {
            font-weight: lighter;
        }


        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 80%; /* Could be more or less, depending on screen size */
        }

        /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
    </style>


     <script>
           
                function validate() {
                    alert("1");
                    var _id = document.getElementById("id").value;
                    var _userId = document.getElementById("userid").value;
                    var _uname = document.getElementById("uname").value;
                    var _email = document.getElementById("email").value;
                     
                    let usersdata = {
                        id: _id,
                        userid: _userId,
                        uname: _uname,
                        email: _email,
                    };
                    alert(usersdata.id);
                    
                     
                    //alert("4");
                    $.ajax({
                        type: "POST",                        
                        url: "UserTest.aspx/PostData",
                        contentType: "application/json",
                        dataType: 'json',
                        data: JSON.stringify({
                            id: _id,
                            userid: _userId,
                            uname: _uname,
                            email: _email,
                        }),
                        success: function (response) {
                            var names = response.d;
                            alert(names + 'success');
                        }
                        , failure: function (response) {
                            alert(response.d);

                        }
                    });
  

                }
          

                function myFunction(chk) {

                    alert(chk);
                     $.ajax({
                        type: "Post",                        
                        url: "UserTest.aspx/GetData",
                        contentType: "application/json",
                        dataType: 'json',
                        data: JSON.stringify({
                            id: chk, 
                        }),
                        success: function (response) {
                            var names = response.d;
                            alert(d + 'success');
                        }
                        , failure: function (response) {
                            alert(response.d);

                        }
                    });


                    document.getElementById("view").style.visibility = "visible";


                    //var checkBox = document.getElementById("myCheck" + chk);

                    //if (checkBox.checked == true) {

                    //    document.getElementById("EDIT").style.visibility = "visible";
                    //} else {

                    //    document.getElementById("EDIT").style.visibility = "hidden";
                    //}
                }

                function View() {

                    var modal = document.getElementById("myModal");
                        modal.style.display = "block";


                    var vtest = document.getElementById("view");

                    if (vtest.value == 'Add+') {

                        document.getElementById("view").style.visibility = "visible";
                        vtest.value = 'Add-';
                    } else {

                        document.getElementById("view").style.visibility = "hidden";
                        vtest.value = 'Add+';
                    }
                }
                 


         function CreateTableFromJSON() { 

              $(document).ready(function () {

                    $.getJSON("https://jsonplaceholder.typicode.com/users", 
                        function (data) {
                            var _test = '';

                            $.each(data, function (key, value) {

                                _test += '<tr>';
                                _test += '<td> <input type="checkbox" id="myCheck' + value.id + '" onclick="myFunction(' + value.id + ')">' +
                                    '</td>';

                                _test += '<td id=' + value.name + value.id +'>' +
                                    value.name + '</td>';
                                
                                _test += '<td id=' + value.username + value.id +'>' +
                                    value.username + '</td>';

                                _test += '<td id=' + value.email + value.id +' >' +
                                    value.email + '</td>';

                                _test += '</tr>';
                            });

                            $('#table').append(_test);
                        });
             });


                                    }
                                 


            </script>
</head>
<body OnLoad="CreateTableFromJSON()">
    <form id="form1" runat="server">
        <div>

             <div id="myModal" class="modal">

                <!-- Modal content -->
                <div class="modal-content">
                    <span class="close">&times;</span>
                   

                        <div id="view">
                            <label for="id">id:</label><br/>
                            <input type="text" id="id" name="id" value="1001"/><br/>


                            <label for="userid">User id:</label><br/>
                            <input type="text" id="userid" name="userid" value="testuser"/><br/>

                            <label for="uname">user name:</label><br>
                            <input type="text" id="uname" name="uname" value="testusername"/><br/>
                            <label for="email">Email-id:</label><br/>
                            <input type="text" id="email" name="email" value="test@email.com"/><br/><br/>

                        </div>

                    

                    <input type="button" value="Submit"  onclick='validate()'/>



                </div>

            </div>


            <input id="Add" type="button" value="Add+" onclick='View()'/>
            <input id="EDIT" type="button" value="EDIT"  />

        </div>



        <div>

               <table id='table' style="width:850px" class="display">
            <tr>
                <th>Check</th>
                <th>Userid</th>
                <th>Username</th>
                <th>Email</th>

            </tr>
                    
                   </table>


            <p id="showData"></p>
        </div>
    </form>


    
    <script>
         


        // Get the modal
        var modal = document.getElementById("myModal");

        // Get the button that opens the modal
        var btn = document.getElementById("EDIT");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks on the button, open the modal
        btn.onclick = function () {
            modal.style.display = "block";
        }

        // When the user clicks on <span> (x), close the modal
        span.onclick = function () {
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }


    </script>


</body>
</html>
