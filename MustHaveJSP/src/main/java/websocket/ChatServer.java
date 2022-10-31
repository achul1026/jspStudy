package websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/ChatingServer") 
// @ServerEndpoint애너테이션으로 웹소켓 서버의 요청명을 지정하여, 해당 요청명으로 접속하는 클라이언트를 
// 이 클래스가 처리하게 한다. 요청명이 /ChatingServer이므로 이 웹소켓에 접속하기 위한 전체 URL은 아래와 같다.
// ws://호스트:포트번호/컨텍스트루트/ChatingServer
// 웹소켓은 http가 아닌 ws 프로토콜을 사용한다.
public class ChatServer {
	private static Set<Session> clients 
		= Collections.synchronizedSet(new HashSet<Session>());
	// 새로 접속한 클라이언트의 세션을 저장할 컬렉션을 생성한다. 
	// Collections 클래스의 synchronizedSet() 메서드는 멀티 스레드 환경에서도 안전한(thread-safe)
	// Set 컬렉션을 생성해 준다. 즉, 여러 클라이언트가 동시에 접속해도 문제가 생기지 않도록 동기화 해준다.
	
	@OnOpen	// 클라이언트 접속 시 실행
	public void onOpen(Session session) {
		clients.add(session); // 세션 추가
		System.out.println("웹 소켓 연결: "+ session.getId());
		// @OnOpen 애너테이션은 클라이언트가 접속했을 때 실행할 메서드를 정의한다. 이 메서드에서는 
		// 단순히 clients 컬렉션에 클라이언트의 세션을 추가한다.
	}
	
	@OnMessage // 메시지를 받으면 실행
	public void onMessage(String message, Session session) throws IOException {
		System.out.println("메시지 전송 : " + session.getId() + " : " + message);
		synchronized(clients) {
			for(Session client : clients) { // 모든 클라이언트에 메시지 전달
				if(!client.equals(session)) {
					// 단, 메시지를 보낸 클라이언트는 제외하고 전달
					client.getBasicRemote().sendText(message);
				}		
			}
		}
		// @OnMessage 애너테이션은 클라이언트로부터 메시지를 받았을 때 실행할 메서드를 정의한다. 
		// 클라이언트가 보낸 메시지와 클라이언트와 연결된 세션이 매개변수로 넘어온다. 동기화 블록내에서
		// 모든 클라이언트에게 메시지를 전송한다. 이때 메시지를 보낸 클라이언트를 제외한다.
	}
	
	@OnClose  // 클라이언트와의 연결이 끊기면 실행
	public void onClose(Session session) {
		clients.remove(session);
		System.out.println("웹소켓 종료 : " + session.getId());
		// @OnClose 애너테이션은 클라이언트가 접속을 종료했을 때 실행할 메서드를 정의한다.
		// clients에서 해당 클라이언트의 세션을 삭제한다.
	}
	
	@OnError // 에러 발생 시 실행
	public void onError(Throwable e) {
		System.out.println("에러 발생");
		e.printStackTrace();
		// @OnError 애너테이션은 에러가 발생했을 때 실행할 메서드를 정의한다.
	}
}
