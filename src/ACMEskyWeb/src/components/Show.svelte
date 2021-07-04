<script lang="ts">
    import { fade } from "svelte/transition";
    import { Table } from "sveltestrap";
    import { fetchInterests } from "../logic";
    import type { Interest } from "../types";
    import { onMount } from "svelte";

    let interests : Array<Interest> = [];
    let loaded : boolean = false

    onMount(async () => {
        interests = await fetchInterests();
        loaded = true;
        console.log(interests);
    });
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
                        <th>Data Andata</th>
                        <th>A/R</th>
                        <th>Data Ritorno</th>
                    </tr>
                </thead>
                <tbody>
                    {#each interests as interest, i}
                        <tr>
                            <th scope="row">{i+1}</th>
                            <td>{interest.outboundFlight.departureAirportCode}</td>
                            <td>{interest.outboundFlight.arrivalAirportCode}</td>
                            <td>{(new Date(interest.outboundFlight.departureTimestamp)).toLocaleDateString()}</td>
                            {#if interest.flightBack != null }
                                <td>Si</td>
                                <td>{(new Date(interest.flightBack.departureTimestamp)).toLocaleDateString()}</td>
                            {:else}
                                <td>No</td>
                                <td></td>
                            {/if}
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
        max-width: 60%;
        margin-bottom: 40px;
    }

</style>
