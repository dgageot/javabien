---
title: "Spring and GWT integration"
date: 2007-08-07T12:00:00+01:00
tags: ["gwt","spring"]
---

<a href="http://www.google.com/search?client=safari&rls=fr&q=spring+gwt+integration&ie=UTF-8&oe=UTF-8">Googling</a> for ways to integrate GWT with Spring, I didn't find any simple solution.

Here is what I need:

 + GWT RPC services should be Spring beans.
 + They should be POJOs NOT extending RemoteServiceServlet.
 + Mapping between Servlet paths and beans should be straightforward.

Here is what I came up with:

 + It's a very simple Servlet that receives every RPC request.
 + It then gets a Spring bean by the name of the Servlet path used for the call.
 + The method call to the bean is done with reflection.

```java
public class SpringDispatchService extends RemoteServiceServlet {
    private final ClassPathXmlApplicationContext context;

    public SpringDispatchServiceImpl() {
        context=new ClassPathXmlApplicationContext(“beans.xml”);
    }

    public String processCall(String payload)
        throws SerializationException {
        try {
            Object target=context.getBean(getServletName());

            RPCRequest rpcRequest=RPC.decodeRequest(
                payload,target.getClass());

            Method method=rpcRequest.getMethod();
            Object[] params=rpcRequest.getParameters();

            Object result=method.invoke(target,params);

            return RPC.encodeResponseForSuccess(method,result);
        } catch(Throwable ex) {
            return RPC.encodeResponseForFailure(null,ex);
        }
    }
}
```
