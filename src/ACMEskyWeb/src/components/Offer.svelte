<script lang="ts">
    import Steps from "./Steps.svelte"
    import { fade, fly } from 'svelte/transition'
    import { confirmOffer, payOffer, reset, getOffer } from "../logic"
    import type { Address, PaymentResponse, Offer } from "../types";

    let step: number = 0

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
    async function submit(): Promise<void> {
        switch(step){
            case 0:
                if(await confirmOffer(offerCode))
                    step++
                break;
            case 1:
                address.offerToken = offerCode
                let response: PaymentResponse | null = await payOffer(address)
                if(response != null){
                    step++
                    payWindow = window.open(response.paymentLink, "ACMEpay", "width=900,height=600");
                    timeout = setTimeout(requestOffer, 2000)
                }
                break;
        }
    }

    function back(): void {
        step = 0
        reset(offerCode)
        clearTimeout(timeout)
    }

    async function requestOffer(): Promise<void> {
        offer = await getOffer(offerCode)
        if(offer == null){
            timeout = setTimeout(requestOffer, 2000);
        } else { 
            payWindow.close()
            step = 3
        }
    }
</script>

<div class="main">
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
                        <p>Per favore non chiudere questa pagina</p>
                </div>
            {:else if step == 3}
                <div in:fly={{ x: 200, duration: 300 }}>
                    <h1 class="h3 fw-normal mb-4">Il tuo viaggio è pronto!</h1>
                    <p>{offer}</p>
                    <p>Ecco i tuoi biglietti</p>
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
                    <div></div>
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
    }
</style>