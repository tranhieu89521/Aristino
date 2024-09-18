<%-- 
    Document   : head
    Created on : Apr 26, 2022, 10:33:06 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
  <script src="https://kit.fontawesome.com/2669f91611.js" crossorigin="anonymous"></script>
	<style type="text/css">
		*{
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			font-family: 'Poppins', sans-serif;
		}
		header{
			height: 80px;
			background-color: #343a40;
			display: flex;
			justify-content: space-between;
			align-items: center;	
		}
		header .logo{
			color: white;
			margin-left: 20px;
			cursor: pointer;
		}
		header .logo h3{
			font-size: 20px;
		}
		header .user{
			margin-right: 20px;
		}
		header .user a{
			text-decoration: none;
			color: #ffffff80;
			padding: 10px 10px;
		}
		header .user a:hover{
			color: white;
		}
		.row{
			width: 100%;
			height: 100%;
		}
		.row .col-2{
			height: 100%;
			width: 18%;
			background: black;
			float: left;
			clear: both;
		}
		.row .col-2 .sidebar a{
			padding: 20px;
			text-decoration: none;
			color: #ffffff80;
			font-size: 15px;
			display: block;
			width: 100%;
		}
		.row .col-2 .sidebar a:hover{
			color: white;
		}
		.col-10{
			width: 100%;
			height: 100%;
		}
    table{
         text-align: center;
       }
    table img{
         width: 100px;
         height: 80px;
       }
     table .ctcl{
           height: 80px;
           overflow: auto;
     }
     .flex{
         display: flex;
     }
     .flex form{
         margin-left: 745px;
     }
	</style>
