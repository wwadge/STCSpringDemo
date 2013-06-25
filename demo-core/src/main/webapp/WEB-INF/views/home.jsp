<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page session="false"%>
<html>
<head>

<script type="text/javascript"
	src="https://www.google.com/jsapi?key=ABQIAAAAiRnI39gW-hIxUgL_OQLmCRQGCTt7unRE4iokDwBRaJeSOI8HVRQyQwsLBUscU1XFztbkTP0Wvt0_qA"></script>
<script type="text/javascript">
	google.load("jquery", "1.7.1");
    google.load("jqueryui", "1.8");
</script>

</head>

<script type="text/javascript">

function deleteAppointment(appointmentId){
	// delete from the database
	$.post("deleteAppointment", "appointmentId="+appointmentId, function() {
		// and delete from the html upon success
		$("#rowId"+appointmentId).empty();
	});
	return false;
}

function addAppointment(){
	window.location.replace("addAppointment?customerId="+$('#customerList').val());
	return false;
}

$(document).ready(function(){
	
	
	
	// Populate customer list
	$.getJSON("getCustomerList", function (data) {
		$.each(data, function(i, item) {
	        $("#customerList").append(new Option(item.name, item.id));
        });
      });
	
	$('#customerList').on('change', function() {
		var custId = $(this).val();
		$.getJSON("getCustomerAppointments", 'custId='+custId, function (data) {
			$("#appointmentList > tbody").empty(); // delete the contents

			$.each(data, function(i, item) {
		        $("#appointmentList").append("<tr id=rowId"+item.id+"><td colspan=3>"+item.startDate+" - "+item.endDate+"<a href='javascript:deleteAppointment("+item.id+");'>Delete</a></td></tr>");
	        });
	      });
		  
		});
	
	
});

</script>
<body>
	<div id="header">
		<H2>Hello</H2>
	</div>



	<table>
		<tr>
			<td colspan="2">
		<tr>
			<td>Customer</td>
			<td><select id="customerList">
					<option value="-- Select Customer --">-- Select Customer --</option>
			</select></td>

		</tr>


	</table>

	<table id="appointmentList">

	
	</table>

	<a href="javascript:addAppointment();">Add appointment</a>




</body>

</html>
