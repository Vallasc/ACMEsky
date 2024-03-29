import { jwtToken } from "./stores"
import { ACMESKY_HOST }  from "./env"
import type { Airport, Interest, User, Address, PaymentResponse, Offer} from "./types"

let showToast : any

let token : string | null = null;
jwtToken.subscribe(value => {
    token = value;
})

export function init(context : any) {
    showToast = context.showToast

    let token = localStorage.getItem("jwtToken")
    if( token != null ){
        jwtToken.set(token)
        refreshToken()
    }
}

export async function Fetch(path: string, method: string, body: any = null) : Promise<Response> {
    console.log(path)
    if(token != null) {
        let response = await fetch(path, {
            method: method,
            cache: 'no-cache',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + token
            },
            body: body != null ? JSON.stringify(body) : null})
        if(response.status == 401){
            jwtToken.set(null)
            localStorage.removeItem("jwtToken")
        }
        return response
    }
    return Promise.resolve(new Response(new Blob(),{ "status" : 401  }))
}

// Login
export async function signin(email: string, password: string, remainSignin: boolean) : Promise<boolean> {
    const response = await fetch(ACMESKY_HOST + "/auth/", 
        {
            method: 'POST',
            cache: 'no-cache',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                username: email,
                password: password
            })
        })
    console.log(response)
    if (response.status == 200) {
        let token : string = (await response.json()).token
        jwtToken.set(token);
        if(remainSignin){
            localStorage.setItem("jwtToken", token)
        }
        return true
    } else {
        showToast("Credenziali errate", true)
        return false
    }
}

export async function signup(user: User) : Promise<boolean> {
    const response = await fetch(ACMESKY_HOST + "/users/", 
        {
            method: 'POST',
            cache: 'no-cache',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(user)
        })
    console.log(response)
    if (response.status == 201) {
        showToast("Registrazione avvenuta con successo", true)
        return true
    } if (response.status == 409) {
        showToast("Utente non disponibile", true)
        return false
    } else {
        showToast("Errore interno", true)
        return false
    }
}

export function signout() : void {
    jwtToken.set(null)
    localStorage.removeItem("jwtToken")
}

export async function refreshToken() : Promise<any> {
    console.log("Refreshing token")
    const response = await Fetch(ACMESKY_HOST + "/auth/refresh", "PUT")
    if (response.status == 200) {
        let token  : string = (await response.json()).token
        jwtToken.set(token);
        if(localStorage.getItem("jwtToken") != null){
            localStorage.setItem("jwtToken", token)
        }
    } 
    return null
}

export async function getUser() : Promise<User | null> {
    const response = await Fetch(ACMESKY_HOST + "/users/me", "GET")
    if (response.status == 200) {
        return await response.json()
    } 
    return Promise.resolve(null)
}

export async function updateUser(name: string, surname: string, email: string, password: string, 
                    newPassword: string, newProntogramUsername: string) : Promise<User | null> {
    const response = await Fetch(ACMESKY_HOST + "/users/me", "PUT", {
        name: name,
        surname: surname,
        email: email,
        password: password,
        newPassword: newPassword,
        newProntogramUsername: newProntogramUsername
    })
    if (response.status == 200) {
        showToast("Profilo aggiornato", true)
        return await response.json()
    } else if (response.status == 400) {
        showToast("Credenziali errate", true)
        return Promise.resolve(null)
    }
    showToast("Errore interno"+ response.status, true)
    return Promise.resolve(null)
}

export async function deleteUser(email: string, password: string) : Promise<boolean> {
    const response = await Fetch(ACMESKY_HOST + "/users/me", "DELETE", {
        email: email,
        password: password,
    })
    if (response.status == 200) {
        showToast("Profilo eliminato", true)
        signout()
        return true
    } else if (response.status == 400) {
        showToast("Credenziali errate", true)
        return false
    }
    showToast("Errore interno"+ response.status, true)
    return false
}

export async function fetchAirports(query: string) : Promise<Array<Airport>> {
    const response = await Fetch(ACMESKY_HOST + "/airports?query="+query, "GET" )
    if (response.status == 200) {
        return await response.json()
    } 
    return Promise.resolve([])
}

export async function fetchAirport(code: string) : Promise<Airport | null> {
    const response = await Fetch(ACMESKY_HOST + "/airports/" + code, "GET" )
    if (response.status == 200) {
        return await response.json()
    } 
    return Promise.resolve(null)
}

export async function createInterest(interest : Interest) : Promise<boolean> {
    console.log(interest)
    const response = await Fetch(ACMESKY_HOST + "/interests", "POST", interest)
    if (response.status == 201) {
        showToast("Interesse creato", true)
        return true
    } else if (response.status == 400) {
        showToast("Errore nella richiesta", true)
        return false
    } 
    showToast("Errore interno", true)
    return false
}

export async function fetchInterests() : Promise<Array<Interest>> {
    const response = await Fetch(ACMESKY_HOST + "/interests/", "GET" )
    if (response.status == 200) {
        return await response.json()
    } 
    return Promise.resolve([])
}

export async function deleteInterests(code: string) : Promise<Boolean> {
    const response = await Fetch(ACMESKY_HOST + "/interests/" + code, "DELETE" )
    return response.status == 200
}

export async function confirmOffer(offerCode: string) : Promise<Offer> {
    const response = await Fetch(ACMESKY_HOST + "/offers/confirm", "PUT", {
        offerToken: offerCode
    })
    
    if (response.status == 200) {
        return await response.json()
    } else if (response.status == 404) {
        showToast("Offerta non trovata", true)
        return null
    } else if (response.status == 409) {
        //if(! await reset(offerCode)){
            showToast("Hai già confermato questa offerta, aspetta 5 minuti e riprova.", true)
            return null
        //} else {
        //    return confirmOffer(offerCode)
        //}
    }
    showToast("Errore interno "+ response.status, true)
    return null
}

export async function payOffer(address: Address) : Promise<PaymentResponse | null> {
    const response = await Fetch(ACMESKY_HOST + "/offers/paymentLink", "PUT", address)
    if (response.status == 200) {
        return await response.json()
    } else if (response.status == 404) {
        showToast("Offerta non trovata", true)
        return null
    } else if (response.status == 409) {
        showToast("Stai già pagando questa offerta, aspetta 5 minuti e riprova.", true)
        return null
    }
    showToast("Errore interno "+ response.status, true)
    return null
}

export async function reset(offerCode: string) : Promise<Boolean> {
    const response = await Fetch(ACMESKY_HOST + "/offers/reset", "PUT", {
        offerToken: offerCode
    })
    //console.log(await response.json())
    return response.status == 200
}

export async function fetchOffer(offerCode: string) : Promise<Offer> {
    const response = await Fetch(ACMESKY_HOST + "/offers/" + offerCode, "GET")
    if (response.status == 200) {
        return await response.json()
    }
    return null
}

export async function fetchOffers() : Promise<Array<Offer>> {
    const response = await Fetch(ACMESKY_HOST + "/offers", "GET")
    if (response.status == 200) {
        return await response.json()
    }
    return null
}

export async function downloadTickets(offer: Offer) : Promise<void> {
    const response = await Fetch(ACMESKY_HOST + "/offers/" + offer.token + "/ticket", "GET")
    let blob = await response.blob()
    var a = document.createElement("a")
    a.href = URL.createObjectURL(blob)
    a.setAttribute("download", "ACMEsky_" + offer.token + ".pdf")
    a.click()
}