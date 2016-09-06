<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ncit.weixin.model.CustomRecordModel"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>wx_msg</title>
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">

<script type="text/javascript" src="../assets/js/jquery-1.10.2.min.js"></script>

<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

</head>
<body>
	<button id="tel_18911897366" class="btn btn-primary btn-lg">18911897366</button>

	<div class="modal fade" id="custom_record_modal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" >客户ＸＸＸＸ的来电</h4>
				</div>
				<div class="modal-body">
					<iframe style="border:0;width: 100%; height: 20em;" src=""></iframe>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function openCustomHistory(tel) {
			var m = $('#custom_record_modal');
			var src = 'custom_record.jsp?tel=' + tel;
			
			m.find('.modal-title').html('客户'+tel+'的来电');
			m.modal('toggle');
			
			
			m.find('iframe').attr('src', src);

		}
	</script>
	<script type="text/javascript">
		$('#tel_18911897366').on('click', function() {
			openCustomHistory(18911897366);
		});
	</script>
</body>
</html>