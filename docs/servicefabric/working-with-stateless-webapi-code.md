# Working with Service Fabric stateless WebAPI services

Most of the time you can use most of your generated templates and just define your custom controller class and the methods defined will work as expected.

Note: Also define the objects that are used for the request and the response. I usually put these in a separate project called `<ServiceName>.Models`.

But if you want to ensure that your response does exactly what you want. _\(ie return a different HTTP status code\)_, you can overload with the following approach.

Here is a standard controller class:

```csharp
namespace HealthCheck.Controllers
{
    [ServiceRequestActionFilter]
    public class HealthCheckController : ApiController
    {
        // GET api/HealthCheck 
        public HealthCheckGetResponse Get()
        {
            ServiceEventSource.Current.Message("Health Check GET called");
            return new HealthCheckGetResponse() {Result = "Success"};
        }

        // POST api/HealthCheck 
        public HealthCheckPostResponse Post([FromBody]HealthCheckPost value)
        {
            ServiceEventSource.Current.Message("Health Check POST called with Mode of: {0}", value?.Mode);

            // TODO perform an action to store the Value of Mode somewhere.

            return new HealthCheckPostResponse() { Result = "Success" };
        }

        public HttpResponseMessage Post([FromBody]HealthCheckPost value)
        {
            ServiceEventSource.Current.Message("Health Check POST called with Mode of: {0}", value?.Mode);

            // TODO perform an action to store the Value of Mode somewhere.

            var resp =  new HealthCheckPostResponse() { Result = "Success" };
            return Request.CreateResponse(HttpStatusCode.OK, resp, Configuration.Formatters.XmlFormatter);
        }
    }
}
```

If you wanted the response to be XML \(instead of the default JSON and the HTTP Status code to be something different you could re-write the post method from:

```csharp
// POST api/HealthCheck 
public HealthCheckPostResponse Post([FromBody]HealthCheckPost value)
{
    ServiceEventSource.Current.Message("Health Check POST called with Mode of: {0}", value?.Mode);

    // TODO perform an action to store the Value of Mode somewhere.

    return new HealthCheckPostResponse() { Result = "Success" };
}
```

to

```csharp
public HttpResponseMessage Post([FromBody]HealthCheckPost value)
{
    ServiceEventSource.Current.Message("Health Check POST called with Mode of: {0}", value?.Mode);

    // TODO perform an action to store the Value of Mode somewhere.

    var resp =  new HealthCheckPostResponse() { Result = "Success" };
    return Request.CreateResponse(HttpStatusCode.OK, resp, Configuration.Formatters.XmlFormatter);
}
```

