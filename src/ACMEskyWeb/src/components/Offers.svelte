<script lang="ts">
    import { fade } from "svelte/transition";
    import { Table } from "sveltestrap";
    import { fetchOffers, downloadTickets } from "../logic";
    import type { Offer } from "../types";
    import { onMount } from "svelte";

    let offers : Array<Offer> = [];
    let loaded : boolean = false

    onMount(async () => {
        await fetch()
        loaded = true
        console.log(offers)
    });

    async function fetch(): Promise<void> {
        offers = await fetchOffers()
    }

</script>

<div class="main">
    <h1 class="h1 mt-4 fw-normal">Le tue offerte acquistate</h1>
    {#if loaded }
        {#if offers.length == 0}
            <p class="mt-4 mb-4">Nessuna offerta disponibile.</p>
        {:else}
            <div class="card mt-4 mb-4" in:fade = {{duration: 200}}>
                <Table hover responsive>
                    <thead>
                        <tr>
                            <th>Codice</th>
                            <th>Partenza</th>
                            <th>Arrivo</th>
                            <th>Data partenza</th>
                            <th>Data ritorno</th>
                            <th>Prezzo totale</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        {#each offers as offer, i (offer)}
                            <tr>
                                <th>{offer.token}</th>
                                <td>{offer.outboundFlight.departureAirportCode}</td>
                                <td>{offer.outboundFlight.arrivalAirportCode}</td>
                                <td>{(new Date(offer.outboundFlight.departureTimestamp)).toLocaleDateString()}</td>
                                <td>{(new Date(offer.flightBack.departureTimestamp)).toLocaleDateString()}</td>
                                <td>{offer.totalPrice}€</td>
                                <td style="padding: 12px;">                    
                                    <button on:click={() => downloadTickets(offer)} type="button" class="btn btn-outline-primary">
                                        Download
                                    </button>
                                </td>
                            </tr>
                        {/each}
                    </tbody>
                </Table>
            </div>
        {/if}
    {/if}
</div>

<style>
    .main {
        width: 100%;
        display: flex;
        align-items: center;
        flex-direction: column;
        justify-content: flex-start;
    }

    .card {
        max-width: 80%;
        margin-bottom: 40px;
    }

</style>
