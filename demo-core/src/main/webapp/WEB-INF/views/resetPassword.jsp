<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" tagdir="/WEB-INF/tags" %>

<html>
  <head>
    <title>Password reset</title>
    <style>
.error {
	color: #ff0000;
}
 
.errorblock {
	color: #000;
	background-color: #ffEEEE;
	border: 3px solid #ff0000;
	padding: 8px;
	margin: 16px;
}
</style>

    <script type="text/javascript" src="https://www.google.com/jsapi?key=ABQIAAAAiRnI39gW-hIxUgL_OQLmCRQGCTt7unRE4iokDwBRaJeSOI8HVRQyQwsLBUscU1XFztbkTP0Wvt0_qA"></script>
<script type="text/javascript">
google.load("jquery", "1.7.1");
    google.load("jqueryui", "1.8");
</script>

  </head>

  <body>
  
   <form:form id="reset-form" modelAttribute="emailForm" action="${formUrl}" method="POST">
   <form:errors path="*" > </form:errors>
			<fieldset>
				<html:inputField name="email" label="Enter your email:" />
			
				<div class="form-actions">
					<button type="submit" class="btn btn-primary">Reset</button>
				</div>
			</fieldset>
		</form:form>



<script type="text/javascript">
			function collectFormData(fields) {
				var data = {};
				for (var i = 0; i < fields.length; i++) {
					var $item = $(fields[i]);
					data[$item.attr('name')] = $item.val();
				}
				return data;
			}
				
			$(document).ready(function() {
				var $form = $('#reset-form');
				$form.bind('submit', function(e) {
					// Ajax validation
					var $inputs = $form.find('input');
					var data = collectFormData($inputs);
					
					$.post('${formJsonUrl}', data, function(response) {
						$form.find('.control-group').removeClass('error');
						$form.find('.help-inline').empty();
						$form.find('.alert').remove();
						
						if (response.status == 'FAIL') {
							for (var i = 0; i < response.errorMessageList.length; i++) {
								var item = response.errorMessageList[i];
								var $controlGroup = $('#' + item.fieldName + 'ControlGroup');
								$controlGroup.addClass('error');
								$controlGroup.find('.help-inline').html(item.message);
							}
						} else {
							// say OK
							window.location.href = "<%= request.getContextPath() %>/login";
						}
					}, 'json');
					
					e.preventDefault();
					return false;
				});
			});
		</script>
  </body>
</html>
