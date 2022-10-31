<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<html>
<head>
<title>웹소켓 채팅</title>
<script>
	var webSocket = new WebSocket(
		"<%= application.getInitParameter("CAHT_ADDR") %>/ChatingServer");
	// web.xml에서 선언해 둔 웹소켓 접속 URL뒤에 요청명을 덧붙여 웹소켓 객체를 생성하고
	var chatWindow, chatMesage, chatId;
	
	// 채팅창이 열리면 대화창, 메시지 입력창, 대화명 표시란으로 사용할 DOM 객체 저장
	window.onload = function(){
		chatWindow = document.getElementById("chatWindow");
		chatMessage = document.getElementById("chatMessage");
		chatId = document.getElementById("chatId").value;
	// 채팅창이 열리면 대화창, 메시지, 대화명으로 사용할 DOM객체를 변수에 저장한다.
	}
	
	// 메시지 전송
	function sendMessage(){
		// 대화창에 표시
		chatWindow.innerHTML += "<div class='myMsg'>" + chatMessage.value +"</div>"
		webSocket.send(chatId + '|' + chatMessage.value); // 서버로 전송
		chatMessage.value = ""; // 메시지 입력창 내용 지우기
		chatWindow.scrollTop = chatWindow.scrollHeight; // 대화창 스크롤
		// sendMessage()는 클라이언트의 메시지를 전송하는 메서드이다. 메시지는 대화창에
		// 먼저 표시한 후 대화명| 메시지 형태로 조립하여 서버로 전송한다. 
		// 전송 후에는 편의를 위해 입력상자의 내용을 비우고, 스크롤바를 항상 아래로 내려준다.
	}
	
	// 서버와의 연결 종료
	function disconnect(){
		webSocket.close();
		// disconnect()는 서버와의 연결을 종료하는 메서드이다.
	}
	
	// 엔터 키 입력 처리
	function enterKey(){
		if(window.event.keyCode == 13){ // 13은 'Enter'키의 코드값
			sendMessage();
		// enterKey() 함수는 enter키가 눌리면 sendMessage()를 호출한다. 매번 [전송]버튼을 클릭하지
		// 않아도 enter를 누르면 즉시 메시지를 전송해주는 편의 기능이다.
		}
	}
	
	webScoket.onopen = function(event){
		chatWindow.innerHTML += "웹소켓 서버에 연결되었습니다.<br>";
	}
	
	// 웹소켓이 닫혔을 때(서버와의 연결이 끊겼을 때) 실행
	webSocket.onclose = function(event){
		chatWindow.innerHTML += "웹소켓 서버가 종료되었습니다.<br>";
	}
	
	// 에러 발생 시 실행
	webSocket.onerror = function(event){
		alert(alert.data);
		chatWindow.innerHTML += "채팅 중 에러가 발생했습니다.<br>";
	}
	
	// 메시지를 받았을 때 실행
	webSocket.onmessage = function(event){
		var message = event.data.split("|"); // 대화명과 메시지 분리
		var sender = message[0]; // 보낸사람의 대화명
		var content = message[1]; // 메시지 내용
		if(content != ""){
			if(content.match("/")){ // 귓속말
				if(content.match("/" + chatId)){ // 나에게 보낸 메시지만 출력
					var temp = content.replace(("/" + chatId), "[귓속말] : ");
					cahtWindow.innerHTML += "<div>" + sender + "" + temp + "</div>";
				}
			}
			else { // 일반 대화
				chatWindow.innerHTML += "<div>" + sender + " : " + content + "</div>";
			}
		}
		chatWindow.scrollTop = chatWindow.scrollHeight;
	}
</script>
<style>  <!-- 대화창 스타일 지정 -->  
#chatWindow{border:1px solid black; width:270px; height:310px; overflow:scroll; padding:5px;}
#chatMessage{width:236px; height:30px;}
#sendBtn{height:30px; position:relative; top:2px; left:-2px;}
#closeBtn{margin-bottom:3px; position:relative; top:2px; left:-2px;}
#chatId{width:158px; height:24px; border:1px solid #AAAAAA; background-color:#EEEEEE;}
.myMsg{text-align:right;}
</style>
</head>

<body>  <!-- 대화창 UI 구조 정의 --> 
    대화명 : <input type="text" id="chatId" value="${ param.chatId }" readonly />
    <button id="closeBtn" onclick="disconnect();">채팅 종료</button>
    <div id="chatWindow"></div>
    <div>
        <input type="text" id="chatMessage" onkeyup="enterKey();">
        <button id="sendBtn" onclick="sendMessage();">전송</button>
    </div>    
</body>
</html>