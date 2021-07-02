<script lang="ts">
    import { fade, fly } from "svelte/transition"
    import { Input } from 'sveltestrap'
    import { fetchAirports, fetchAirport, createInterest } from "../logic"
    import type { Airport, Interest } from "../types"

    const INTEREST_WINDOW : number = 365

    let today : number = Date.now()
    let day : number = 1000 * 60 * 60 * 24
    let startDate : Date = new Date(today + day * 1)
    let endDate : Date =  new Date(today + day * INTEREST_WINDOW)

    function formatDate (date : Date) : string {
        return date.toISOString().split("T")[0]
    }

    let departureCode : string 
    let arrivalCode : string 
    let ar : boolean = false
    let dateA : string = Date()
    let dateR : string

    let invalidDeparture : boolean = false
    let invalidArrival : boolean  = false
    let invalidDateA : boolean = false
    let invalidDateR : boolean = false

    let airports : Array<Airport> = []
    let form : HTMLFormElement

    async function validate() : Promise<boolean> {
        if(departureCode === arrivalCode){
            invalidArrival = true
            return false
        }
        if(ar && (new Date(dateA)).getTime() >= (new Date(dateR)).getTime()){
            invalidDateR = true
            return false
        }

        let airport : Airport | null = await fetchAirport(departureCode)
        if(airport == null || airport.code !== departureCode){
            invalidDeparture = true
            return false
        }

        if( ar ){
            airport = await fetchAirport(arrivalCode)
            if(airport == null || airport.code !== arrivalCode){
                invalidArrival = true
                return false
            }
        }
        return true
    }

    function resetForm() : void {
        form.reset()
        invalidDeparture = false
        invalidArrival = false
        invalidDateA = false
        invalidDateR = false
        ar = false
    }


    let timer : NodeJS.Timeout;
    function fetch(target : any) : void {
        let value : string = target.value
        clearTimeout(timer);
        timer = setTimeout(async () => {
            //val = v;
            console.log(value)
            airports = await fetchAirports(value)
            console.log(airports)
        }, 300)
    }

    async function submit() {
        if( ! (await validate()) ) return

        let request : Interest = {
            outboundFlight : {
                departureAirportCode : departureCode,
                arrivalAirportCode : arrivalCode,
                departureTimestamp : (new Date(dateA)).toISOString()
            },
            flightBack : !ar ? null : {
                departureAirportCode : arrivalCode,
                arrivalAirportCode : departureCode,
                departureTimestamp : (new Date(dateR)).toISOString()
            }
        }
        createInterest(request)
        resetForm()
    }
</script>

<div class="main">
    <h1 class="h1 mt-4 fw-normal">Aggiungi voli di interesse</h1>
    <div class="card mt-4 mb-4" in:fade = {{duration: 200}}>
        <form on:submit|preventDefault={submit} bind:this={form}>
            <div class="row g-3">
                <div class="col-md-12">
                    <h1 class="h4 fw-normal">Andata</h1>
                </div>
                <datalist id="datalistOptions">
                    {#each airports as airport}
                        <option value={airport.code}>{airport.name} ({airport.code}) - {airport.cityName}</option>
                    {/each}
                </datalist>
                <div class="col-md-6">
                    <label for="_" class="form-label">Partenza</label>
                    <Input bind:value={departureCode} on:keyup={({target}) => fetch(target)} on:focus={() => airports = []}
                            invalid = {invalidDeparture} feedback="Seleziona il codice dalla lista"
                            class="form-control" list="datalistOptions" placeholder="Areoporto di partenza" required />
                </div>
                <div class="col-md-6">
                    <label for="_" class="form-label">Arrivo</label>
                    <Input bind:value={arrivalCode} on:keyup={({target}) => fetch(target)} on:focus={() => airports = []}
                        invalid = {invalidArrival} feedback="Seleziona il codice dalla lista"
                        class="form-control" list="datalistOptions" placeholder="Areoporto di partenza" required />
                </div>

                <div class="col-md-6">
                    <label for="_" class="form-label">Data</label>
                    <Input bind:value={dateA} type="date" class="form-control" 
                        min={formatDate(startDate)} max={formatDate(endDate)} 
                        invalid = {invalidDateA} feedback="Seleziona il codice dalla lista" required />
                </div>
                <div class="col-md-6 check">
                    <div class="checkbox">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" bind:checked={ar}/>
                            <label class="form-check-label" for="gridCheck">
                                Andata e ritorno
                            </label>
                        </div>
                    </div>
                </div>
                {#if ar}
                    <div class="col-md-12">
                        <h1 class="h4 fw-normal mt-3">Ritorno</h1>
                    </div>
                    <div class="col-md-6">
                        <label for="_" class="form-label">Partenza</label>
                        <input bind:value={arrivalCode} class="form-control" disabled>
                    </div>
                    <div class="col-md-6">
                        <label for="_" class="form-label">Arrivo</label>
                        <input bind:value={departureCode} class="form-control" disabled>
                    </div>
                    <div class="col-6">
                        <label for="_" class="form-label">Data</label>
                        <Input bind:value={dateR} type="date" class="form-control" 
                            min={formatDate(startDate)} max={formatDate(endDate)} 
                            invalid = {invalidDateR} feedback="Seleziona il codice dalla lista" required />
                    </div>
                {/if}
                <div class="mt-4" />
                <div class="button-row">
                    <button class="mt-3 btn btn-primary" type="submit">Salva</button>
                </div>
            </div>
        </form>
    </div>
</div>

<style>
    .main {
        width: 100%;
        display: flex;
        align-items: center;
        flex-direction: column;
        justify-content: flex-start;
    }

    form {
        width: 100%;
        padding: 30px;
    }

    .button-row {
        min-width: 400px;
        display: flex;
        justify-content: center;
        flex-direction: row;
        flex-wrap: nowrap;
    }

    .card {
        max-width: 60%;
        margin-bottom: 40px;
    }

    .check {
        display: flex;
        align-items: flex-end;
        justify-content: flex-start;
    }
</style>
