<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
  <head>
    <title>Login</title>


  </head>

  <body>
   
	<form:form modelAttribute="appointment" method="POST"
		action="addAppointment">
		
			<form:hidden path="customerId" />
		
		<table>
			<tr>
				<td colspan="2"><form:errors path="*" cssStyle="color : red;" /></td>
			</tr>

			<tr>
				<td><form:label path="startDate">Start Date: </form:label></td>
				<td><form:input path="startDate" size="10" /></td>
			</tr>
			<tr>
				<td><form:label path="endDate">End Date: </form:label></td>
				<td><form:input path="endDate" /></td>
			</tr>
			<tr>
				<td><form:label path="note">Note: </form:label></td>
				<td><form:input path="note" /></td>
			</tr>
			<tr>
				<td><form:label path="serviceId">Service:</form:label></td>
				<td><form:select path="serviceId" items="${services}"
						itemValue="id" itemLabel="description" /></td>
			</tr>

		</table>
		<input type="submit" value="Save" />
	</form:form>



  </body>
</html>
