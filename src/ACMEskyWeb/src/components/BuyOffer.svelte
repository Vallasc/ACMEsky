<script lang="ts">
    import Steps from "./Steps.svelte"
    import { fade, fly } from 'svelte/transition'
    import { Table } from 'sveltestrap';
    import { confirmOffer, payOffer, reset, fetchOffer, downloadTickets } from "../logic"
    import type { Address, PaymentResponse, Offer } from "../types";
    

    let step: number = 0
    let loading: boolean = false

    let offerCode: string

    let address: Address = {
        offerToken: "",
        postCode: "",
        address: "",
        cityName: "",
        country: ""
    }

    let payWindow: Window
    let timeout: NodeJS.Timeout

    let offer: Offer
    let paymentLink: string

    async function submit(): Promise<void> {
        switch(step){
            case 0:
                loading = true
                offer = await confirmOffer(offerCode);
                if(offer != null)
                    step = 1
                loading = false
                break;
            case 1:
                loading = true
                address.offerToken = offerCode
                let response: PaymentResponse | null = await payOffer(address)
                if(response != null) {
                    paymentLink = response.paymentLink;
                    let leftPos = (screen.width - 800)/2;
                    let topPos = (screen.height - 600)/2;
                    leftPos = leftPos < 0 ? 0 : leftPos;
                    topPos = topPos < 0 ? 0 : topPos;
                    payWindow = window.open(paymentLink, "ACMEpay", `width=800,height=600,top=${topPos}, left=${leftPos}`);
                    timeout = setTimeout(getOffer, 2000)
                    step = 2
                } else {
                    back()
                }
                break;
        }
    }

    function back(): void {
        loading = false
        step = 0
        reset(offerCode)
        clearTimeout(timeout)
    }

    async function getOffer(): Promise<void> {
        offer = await fetchOffer(offerCode)
        if(offer == null){
            timeout = setTimeout(getOffer, 2000);
        } else { 
            payWindow.close()
            step = 3
            loading = false
        }
    }

    function formatDate(timestamp: string): string {
        let date = new Date(timestamp)
        return date.toLocaleDateString() + " " + date.toLocaleTimeString()
    }
</script>

<div class="main">
    <div class="progress-material" class:invisible = {!loading}>
        <div class="indeterminate"></div>
      </div>
    <h1 class="h1 fw-normal mb-4 mt-4">Acquista un'offerta</h1>
    <Steps selected={step} />
    <div class="mt-4"></div>
    <div class="card mt-4" in:fade = {{duration: 200}}>
        <form on:submit|preventDefault={submit}>
            {#if step == 0}
                <div class="row mb-3">
                    <label for="_" class="form-label">Codice offerta</label>
                    <input bind:value = {offerCode} type="text" class="form-control" placeholder="Inserisci il codice offerta" required>
                </div>
            {:else if step == 1}
                <div class="row g-3" in:fly={{ x: 200, duration: 300 }}>
                    <h3>Offerta {offer.token} {offer.outboundFlight.departureAirportCode}-{offer.outboundFlight.arrivalAirportCode} {formatDate(offer.outboundFlight.departureTimestamp)}</h3>
                    <div class="col-12">
                        <label for="inputAddress" class="form-label">Indirizzo</label>
                        <input bind:value = {address.address} type="text" class="form-control" id="inputAddress" placeholder="Via della libertà 12" required>
                    </div>
                    <div class="col-md-6">
                        <label for="inputCity" class="form-label">Città</label>
                        <input bind:value = {address.cityName} type="text" class="form-control" id="inputCity" placeholder="Bologna" required>
                    </div>
                    <div class="col-md-4">
                        <label for="inputState" class="form-label">Stato</label>
                        <select bind:value = {address.country} id="inputState" class="form-select">
                            <option selected>Italy</option>
                            <option>UK</option>
                            <option>France</option>
                            <option>Spain</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label for="inputZip" class="form-label">CAP</label>
                        <input bind:value = {address.postCode} type="text" class="form-control" id="inputZip">
                    </div>
                </div>
            {:else if step == 2}
                <div in:fly={{ x: 200, duration: 300 }}>
                        <h1 class="h3 fw-normal mb-4">Ti stiamo indirizzando al provider di pagamenti</h1>
                        <a href={paymentLink}>Link al pagamento</a>
                        <p>Per favore non chiudere questa pagina</p>
                </div>
            {:else if step == 3}
                <div in:fly={{ x: 200, duration: 300 }}>
                    <h1 class="h3 fw-normal mb-4">Il tuo viaggio è pronto!</h1>
                    <Table responsive>
                        <tbody>
                          <tr>
                            <th>Codice offerta</th>
                            <td>{offer.token}</td>
                          </tr>
                          <tr>
                            <th>Areoporto di partenza</th>
                            <td>{offer.outboundFlight.departureCity} ({offer.outboundFlight.departureAirportCode})</td>
                          </tr>
                          <tr>
                            <th>Areoporto di arrivo</th>
                            <td>{offer.outboundFlight.arrivalCity} ({offer.outboundFlight.arrivalAirportCode})</td>
                          </tr>
                          <tr>
                            <th>Andata e ritorno</th>
                            <td>Si</td>
                          </tr>
                          <tr>
                            <th>Data e ora andata</th>
                            <td>{formatDate(offer.outboundFlight.departureTimestamp)}</td>
                          </tr>
                          <tr>
                            <th>Data e ora ritorno</th>
                            <td>{formatDate(offer.flightBack.departureTimestamp)}</td>
                          </tr>
                          <tr>
                            <th>Trasporto in areoporto incluso</th>
                            <td>{offer.rent ? "Si" : "No"}</td>
                          </tr>
                          <tr>
                            <th>Ricevuta</th>
                            <td style="padding: 12px;">                    
                                <button on:click={() => downloadTickets(offer)} type="button" class="btn btn-primary">
                                    Download
                                </button>
                            </td>
                          </tr>
                        </tbody>
                    </Table>
                </div>
            {/if}
            <div class="mt-4"></div>
            <div class="button-row">
                {#if step == 1 || step == 2 }
                    <button class="mt-3 btn btn-light" type="button" on:click={back}>Indietro</button>
                {:else}
                    <div></div>
                {/if}
                {#if step == 0 || step == 1}
                    <button class="mt-3 btn btn-primary" type="submit">Avanti</button>
                {:else}
                    {#if step == 3}
                        <button class="mt-3 btn btn-outline-primary"
                        on:click={()=>location.reload()}>Acquista un'altra offerta</button>
                    {:else}
                        <div></div>
                    {/if}
                {/if}
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
        align-items: stretch;
        flex-direction: row;
        flex-wrap: nowrap;
        justify-content: space-between;
    }

    .card{
        max-width: 70%;
        margin-bottom: 40px;
    }

    .progress-material {
        position: relative;
        height: 5px;
        display: block;
        width: 100%;
        background-color: #eeeeee;
        overflow: hidden;
    }

    .invisible {
        visibility: hidden;
    }

    .progress-material .indeterminate {
        background-color: #000000;
    }
    .progress-material .indeterminate:before {
        content: "";
        position: absolute;
        background-color: inherit;
        top: 0;
        left: 0;
        bottom: 0;
        will-change: left, right;
        animation: indeterminate 2.1s cubic-bezier(0.65, 0.815, 0.735, 0.395) infinite;
    }
    .progress-material .indeterminate:after {
        content: "";
        position: absolute;
        background-color: inherit;
        top: 0;
        left: 0;
        bottom: 0;
        will-change: left, right;
        animation: indeterminate-short 2.1s cubic-bezier(0.165, 0.84, 0.44, 1) infinite;
        animation-delay: 1.15s;
    }

    @keyframes indeterminate {
        0% {
            left: -35%;
            right: 100%;
        }
        60% {
            left: 100%;
            right: -90%;
        }
        100% {
            left: 100%;
            right: -90%;
        }
    }
    @keyframes indeterminate-short {
        0% {
            left: -200%;
            right: 100%;
        }
        60% {
            left: 107%;
            right: -8%;
        }
        100% {
            left: 107%;
            right: -8%;
        }
    }
</style>