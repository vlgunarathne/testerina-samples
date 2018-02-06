package simple;

import ballerina.net.http;
import ballerina.test;

@Description { value:"Starts the service 'echo' before executing tests" }
function beforeTestFunc () {
    // the service URL returned is ignored
    _ = test:startService("echo");    
}

@Description { value:"Test function" }
function testEchoString () {

    string pl = "This is a sample string payload";
    var status, payload = callService(pl);
    test:assertIntEquals(status, 200, "Didn't recieve the expected status code");
    test:assertStringEquals(payload, pl, "Didn't recieve the expected payload");
}

@Description { value:"Starts the service 'echo' before executing tests" }
@Param{value:"pl: content of the payload"}
@Return{value:"int: status code of the response"}
@Return{value:"string: response payload"}
function callService (string pl) (int,string) {
    endpoint<http:HttpClient> httpEndpoint {
        create http:HttpClient("http://localhost:9090", {});
    }
    http:OutRequest req = {};
    req.setStringPayload(pl);

    http:InResponse resp = {};
    resp, _ = httpEndpoint.post("/echo", req);

    return resp.getStatusCode(), resp.getStringPayload();
}
