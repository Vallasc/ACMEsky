<script lang="ts">
    import { fade } from "svelte/transition";
    import { flip } from 'svelte/animate';
    import { Table } from "sveltestrap";
    import { fetchInterests, deleteInterests } from "../logic";
    import type { Interest } from "../types";
    import { onMount } from "svelte";

    let interests : Array<Interest> = [];
    let loaded : boolean = false

    onMount(async () => {
        await fetch()
        loaded = true
        console.log(interests)
    });

    async function fetch(){
        let interestsOut = await fetchInterests()
        interestsOut.sort(function(a, b){return b.id-a.id});
        interests = interestsOut
    }

    async function removeInterest(interest: Interest): Promise<void> {
        await deleteInterests(interest.id.toString())
        await fetch()
    }
</script>

<div class="main">
    <h1 class="h1 mt-4 fw-normal">I tuoi interessi</h1>
    {#if loaded }
        <div class="card mt-4 mb-4" in:fade = {{duration: 200}}>
            <Table hover responsive>
                <thead>
                    <tr>
                        <th></th>
                        <th>Partenza</th>
                        <th>Arrivo</th>
                        <th>Data Partenza</th>
                        <th>Data Ritorno</th>
                        <th>Prezzo Limite</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    {#each interests as interest, i (interest)}
                        <tr>
                            <th scope="row">{i+1}</th>
                            <td>{interest.outboundFlight.departureAirportCode}</td>
                            <td>{interest.outboundFlight.arrivalAirportCode}</td>
                            <td>{(new Date(interest.outboundFlight.departureTimestamp)).toLocaleDateString()}</td>
                            <td>{(new Date(interest.flightBack.departureTimestamp)).toLocaleDateString()}</td>
                            <td>{interest.priceLimit}€</td>
                            <td style="padding: 12px;">                    
                                <button on:click={() => removeInterest(interest)} type="button" class="btn btn-outline-danger">
                                    Elimina
                                </button>
                            </td>
                        </tr>
                    {/each}
                </tbody>
            </Table>
        </div>
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
