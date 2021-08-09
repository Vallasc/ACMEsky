
package it.unibo.soseng.ws.generated;

import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceException;
import javax.xml.ws.WebServiceFeature;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.3.1
 * Generated source version: 2.2
 * 
 */
@WebServiceClient(name = "RentService", targetNamespace = "www.unibo.it.wsdl", wsdlLocation = "./rentService1.wsdl")
public class RentService
    extends Service
{

    private final static URL RENTSERVICE_WSDL_LOCATION;
    private final static WebServiceException RENTSERVICE_EXCEPTION;
    private final static QName RENTSERVICE_QNAME = new QName("www.unibo.it.wsdl", "RentService");

    static {
        RENTSERVICE_WSDL_LOCATION = it.unibo.soseng.ws.generated.RentService.class.getResource("./rentService1.wsdl");
        WebServiceException e = null;
        if (RENTSERVICE_WSDL_LOCATION == null) {
            e = new WebServiceException("Cannot find './rentService1.wsdl' wsdl. Place the resource correctly in the classpath.");
        }
        RENTSERVICE_EXCEPTION = e;
    }

    public RentService() {
        super(__getWsdlLocation(), RENTSERVICE_QNAME);
    }

    public RentService(WebServiceFeature... features) {
        super(__getWsdlLocation(), RENTSERVICE_QNAME, features);
    }

    public RentService(URL wsdlLocation) {
        super(wsdlLocation, RENTSERVICE_QNAME);
    }

    public RentService(URL wsdlLocation, WebServiceFeature... features) {
        super(wsdlLocation, RENTSERVICE_QNAME, features);
    }

    public RentService(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    public RentService(URL wsdlLocation, QName serviceName, WebServiceFeature... features) {
        super(wsdlLocation, serviceName, features);
    }

    /**
     * 
     * @return
     *     returns Rent
     */
    @WebEndpoint(name = "RentServicePort")
    public Rent getRentServicePort() {
        return super.getPort(new QName("www.unibo.it.wsdl", "RentServicePort"), Rent.class);
    }

    /**
     * 
     * @param features
     *     A list of {@link javax.xml.ws.WebServiceFeature} to configure on the proxy.  Supported features not in the <code>features</code> parameter will have their default values.
     * @return
     *     returns Rent
     */
    @WebEndpoint(name = "RentServicePort")
    public Rent getRentServicePort(WebServiceFeature... features) {
        return super.getPort(new QName("www.unibo.it.wsdl", "RentServicePort"), Rent.class, features);
    }

    private static URL __getWsdlLocation() {
        if (RENTSERVICE_EXCEPTION!= null) {
            throw RENTSERVICE_EXCEPTION;
        }
        return RENTSERVICE_WSDL_LOCATION;
    }

}