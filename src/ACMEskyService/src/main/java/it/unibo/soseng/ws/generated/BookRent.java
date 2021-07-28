
package it.unibo.soseng.ws.generated;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Classe Java per anonymous complex type.
 * 
 * <p>Il seguente frammento di schema specifica il contenuto previsto contenuto in questa classe.
 * 
 * <pre>
 * &lt;complexType&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="clientName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="clientSurname" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="fromAddress" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="arrivalDateTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="toAddress" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "clientName",
    "clientSurname",
    "fromAddress",
    "arrivalDateTime",
    "toAddress"
})
@XmlRootElement(name = "bookRent")
public class BookRent {

    @XmlElement(required = true)
    protected String clientName;
    @XmlElement(required = true)
    protected String clientSurname;
    @XmlElement(required = true)
    protected String fromAddress;
    @XmlElement(required = true)
    protected String arrivalDateTime;
    @XmlElement(required = true)
    protected String toAddress;

    /**
     * Recupera il valore della proprietà clientName.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getClientName() {
        return clientName;
    }

    /**
     * Imposta il valore della proprietà clientName.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setClientName(String value) {
        this.clientName = value;
    }

    /**
     * Recupera il valore della proprietà clientSurname.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getClientSurname() {
        return clientSurname;
    }

    /**
     * Imposta il valore della proprietà clientSurname.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setClientSurname(String value) {
        this.clientSurname = value;
    }

    /**
     * Recupera il valore della proprietà fromAddress.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFromAddress() {
        return fromAddress;
    }

    /**
     * Imposta il valore della proprietà fromAddress.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFromAddress(String value) {
        this.fromAddress = value;
    }

    /**
     * Recupera il valore della proprietà arrivalDateTime.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getArrivalDateTime() {
        return arrivalDateTime;
    }

    /**
     * Imposta il valore della proprietà arrivalDateTime.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setArrivalDateTime(String value) {
        this.arrivalDateTime = value;
    }

    /**
     * Recupera il valore della proprietà toAddress.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getToAddress() {
        return toAddress;
    }

    /**
     * Imposta il valore della proprietà toAddress.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setToAddress(String value) {
        this.toAddress = value;
    }

}
