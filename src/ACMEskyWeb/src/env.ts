//export const ACMESKY_HOST = process.env.ACMESKY_URL

let domain = window.location.origin;
let port = 8080;

export const ACMESKY_HOST = domain + ':' + port 