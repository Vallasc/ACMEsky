import { jwtToken, acmeskyHost } from "./stores"

let showToast : any

let token : string | null = null;
jwtToken.subscribe(value => {
    token = value;
})

let acmesky : string
acmeskyHost.subscribe(value => {
    acmesky = value;
    console.log(acmesky)
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

export async function signin(email: string, password: string, remainSignin: boolean) : Promise<boolean> {
    const response = await fetch(acmesky + "/auth/", 
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
        showToast("Sei dentro!!!","", true)
        let token : string = (await response.json()).token
        jwtToken.set(token);
        if(remainSignin){
            localStorage.setItem("jwtToken", token)
        }
        return true
    } else {
        showToast("Errore", "Credenziali errate", true)
        return false
    }
}

export async function signup(email: string, password: string, token: string) : Promise<boolean> {
    const response = await fetch(acmesky + "/users/", 
        {
            method: 'POST',
            cache: 'no-cache',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                email: email,
                password: password,
                prontogramToken: token
            })
        })
    console.log(response)
    if (response.status == 201) {
        showToast("Esito","Registrazione avvenuta con successo", true)
        return true
    } else {
        showToast("Errore", "Errore nella registrazione", true)
        return false
    }
}

export function signout() : void {
    jwtToken.set(null)
    localStorage.removeItem("jwtToken")
}

export async function refreshToken() : Promise<any> {
    console.log("Refreshing token")
    const response = await Fetch(acmesky + "/auth/refresh", "PUT")
    if (response.status == 200) {
        let token  : string = (await response.json()).token
        jwtToken.set(token);
        if(localStorage.getItem("jwtToken") != null){
            localStorage.setItem("jwtToken", token)
        }
    } 
    return null
}

export async function getUser() : Promise<any> {
    const response = await Fetch(acmesky + "/users/me", "GET")
    if (response.status == 200) {
        return await response.json()
    } 
    return null
}

export async function updateUser(email: string, password: string, newPassword: string, newToken: string) : Promise<any> {
    const response = await Fetch(acmesky + "/users/me", "PUT", {
        email: email,
        password: password,
        newPassword: newPassword,
        newProntogramToken: newToken
    })
    if (response.status == 200) {
        showToast("Esito","Profilo aggiornato", true)
        return await response.json()
    } else if (response.status == 400) {
        showToast("Esito","Errore credenziali errate", true)
        return null
    }
    showToast("Esito","Errore "+ response.status, true)
    return null
}

export async function deleteUser(email: string, password: string) : Promise<boolean> {
    const response = await Fetch(acmesky + "/users/me", "DELETE", {
        email: email,
        password: password,
    })
    if (response.status == 200) {
        showToast("Esito","Profilo eliminato", true)
        signout()
        return true
    } else if (response.status == 400) {
        showToast("Esito","Errore credenziali errate", true)
        return false
    }
    showToast("Esito","Errore "+ response.status, true)
    return false
}

export async function createInterest() : Promise<any> {
    //TODO
}