package simple;


@Description { value:"Starts the service 'echo' before executing tests" }
function beforeTestStartServer () {
    // the service URL returned is ignored
    _ = test:startService("echo");    
}


function testEchoServiceDataDriven () {

     // Data set for data driven tests
     string[] payloads = ["simple", "space inbetween", "special !@@#$%%^&*()_+ characters", " ", "{}","<a>XML</a>"];

    foreach pl in payloads {
        println("Value: " + pl);
        var status, payload = callService(pl);
        test:assertIntEquals(status, 200, "Didn't recieve the expected status code");
        test:assertStringEquals(payload, pl, "Didn't recieve the expected payload");
    }  
}