package error;
import ballerina.test;


@Description { value:"Tests division with 0 error" }
function testDivision() {
    try {
       int a = devide(500, 0);
    }
    catch(error err) {
        println(err.msg);
        test:assertStringEquals(err.msg.trim(),"/ by zero","");
    }
}