# 流程
![](../../images/spring/websocket.png)

# 配置
```java
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig extends AbstractWebSocketMessageBrokerConfigurer {
	
    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker("/topic/", "/queue/");
	    config.setApplicationDestinationPrefixes("/app");
    }
	 
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
	    registry.addEndpoint("/greeting");
    }	
}
```

- @EnableWebSocketMessageBroker 开启 stomp
- config.enableSimpleBroker 定义broker，负责从服务端收消息，转发给前端

# 验权
```java
@Override
public void registerStompEndpoints(StompEndpointRegistry registry) {
        
registry
  .addEndpoint("/greeting")
  .setHandshakeHandler(new DefaultHandshakeHandler() {

      public boolean beforeHandshake(
        ServerHttpRequest request, 
        ServerHttpResponse response, 
        WebSocketHandler wsHandler,
        Map attributes) throws Exception {
 
            if (request instanceof ServletServerHttpRequest) {
                ServletServerHttpRequest servletRequest
                 = (ServletServerHttpRequest) request;
                HttpSession session = servletRequest
                  .getServletRequest().getSession();
                attributes.put("sessionId", session.getId());
            }
                return true;
        }}).withSockJS();
    }
```
在 WebSocketConfig里可直接配置拦截器

或者单独配置拦截器，实现 `ExecutorChannelInterceptor` 或 `HandShakeInteceptor`

# 发送给用户
```java
@Controller
public class WebSocketController {

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;

    private Gson gson = new Gson();
 
    @MessageMapping("/message")
    @SendToUser("/queue/reply")
    public String processMessageFromClient(
      @Payload String message, 
      Principal principal) throws Exception {
	return gson
          .fromJson(message, Map.class)
          .get("name").toString();
    }
	
    @MessageExceptionHandler
    @SendToUser("/queue/errors")
    public String handleException(Throwable exception) {
        return exception.getMessage();
    }
}
```

@SendToUser 会自动加上前缀 /user/{sessionId}/...

# 前端
```javascript
function connect() {
    var socket = new WebSocket('ws://localhost:8080/greeting');
    ws = Stomp.over(socket);

    ws.connect({}, function(frame) {
        ws.subscribe("/user/queue/errors", function(message) {
            alert("Error " + message.body);
        });

        ws.subscribe("/user/queue/reply", function(message) {
            alert("Message " + message.body);
        });
    }, function(error) {
        alert("STOMP error " + error);
    });
}

function disconnect() {
    if (ws != null) {
        ws.close();
    }
    setConnected(false);
    console.log("Disconnected");
}
```

# 集群状态保持问题
### 收消息
由于websocket是有状态的，所以握手以后，后续消息必须发送到同一个服务实例
- 使用nginx ip hash
- 

### 广播

# 参见
- [Spring Websocket - baeldung](https://www.baeldung.com/spring-websockets-sendtouser)