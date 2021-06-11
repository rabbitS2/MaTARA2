<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="com.matara.mail.*"%>
<%@page import="javax.mail.*"%>
<%@page import="java.util.Properties"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String mail= (String)session.getAttribute("mail");
	session.removeAttribute("user_mail");
%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>E-Mail check</title>
</head>
<body>

	<%
	request.setCharacterEncoding("UTF-8");
	session.setAttribute("user_mail",request.getParameter("user_mail"));
	String user_mail=(String)session.getAttribute("user_mail");
	String subject = "MaTARA 인증메일입니다.";
	String content = (String)session.getAttribute("content");
	response.setContentType("text/html;charset=UTF-8");
	String username="mataradamin@gmail.com";
	
	try {
		Properties properties = System.getProperties();
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host","smtp.gmail.com");
		properties.put("mail.smtp.auth","true");
		properties.put("mail.smtp.port","587");
		
		
		Authenticator auth = new SMTPAuthenticatior();
		
		Session s = Session.getDefaultInstance(properties, auth);
		Message message = new MimeMessage(s);
		Address sender_address = new InternetAddress(username);
		Address user_mail_address = new InternetAddress(user_mail);
		message.setHeader("content-type", "text/html;charset=UTF-8");
		message.setFrom(sender_address);
		message.setReplyTo(new Address[]{sender_address});
		message.addRecipient(Message.RecipientType.TO, user_mail_address);
		message.setSubject(subject);
		message.setContent("인증 번호는 "+content+" 입니다.","text/html;charset=UTF-8");
		message.setSentDate(new java.util.Date());
		message.saveChanges();
		Transport.send(message);
		%>
		<script>
		alert('메일이 성공적으로 발송되었습니다');
		location.href='rentMailChk.jsp';
		</script>
		
		<%
	} catch (Exception e) {
		out.println("SMTP 서버가 잘못설정되었거나 서비스에 문제가 있습니다.");
		e.printStackTrace();
	}
	%>
	
	
</body>
</html>







