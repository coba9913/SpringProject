<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
</head>
<body>

	<h2>Ajax Test Page</h2>

	<div>
		<div>
			Replyer <input type="text" name="replyer" id="newReplyWriter">
		</div>
		<div>
			Replyer text <input type="text" name="replytext" id="newReplyText">
		</div>
		<button id="replyAddBtn">Add reply</button>
	</div>
	<p id="replyhtml"></p>
	<ul id="replies"></ul>
	<!-- jquery 2.1.4 -->
	
	<script>
		var bno = 100;

		$(document).ready(function() {

			$("#replyAddBtn").on("click", function() {
				alert("test");
				var replyer = $("#newReplyWriter").val();
				var replytext = $("#newReplyText").val();

				$.ajax({
					type : 'post',
					url : '/replies',
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					dataType : 'text',
					data : JSON.stringify({
						bno : bno,
						replyer : replyer,
						replytext : replytext
					}),
					success : function(result) {
						if (result == 'SUCCESS') {
							alert("등록되었습니다.");
							getAllList();
						}
					}
				});
			});

			$("#replies").on("click", ".replyLi button", function() {
				var reply = $(this).parent();
				var rno = reply.attr("data-rno");
				var replytext = reply.text()
				alert(rno + ":" + replytext);
			});

		});

		function getAllList() {

			$.getJSON("/replies/all/" + bno,function(data) {
				
				
				str = "";
				console.log(data.length);
				$(data).each(function() {
					str += "<li data-rno='"+this.rno+"' class = 'replyLi'>"
															
					+ this.rno
															
					+ ":"
														
					+ this.replytext
														
					+ "<button>MOD</button></li>";
												
				});
								
				$("#replyhtml").html(str);
							
			});
		}
	</script>
</body>
</html>