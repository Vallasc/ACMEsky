<script lang="ts">
    import { fade, fly } from "svelte/transition";

    let today : number = Date.now()
    let day : number = 1000 * 60 * 60 * 24
    let startDate : Date = new Date(today + day * 2)
    let endDate : Date=  new Date(today + day * 120)

    function formatDate (date : Date) : string {
        return date.toISOString().split("T")[0]
    }

    let departure : string 
    let arrival : string 
    let ar : boolean
    let airports : Array<string> = ["Roma", "Milano"]

    function validate() : boolean {
        if(departure == arrival)
            return true
        return false
    }

    let timer;
    function fetchAirport(target : HTMLInputElement) : void {
        let value : string = target.value
        clearTimeout(timer);
        timer = setTimeout(() => {
            //val = v;
            console.log(value)
        }, 300);
    }

    function submit() {}
</script>

<div class="main">
    <h1 class="h1 mb-4 mt-4 fw-normal">Aggiungi i tuoi interessi</h1>
    <div class="card mt-4">
        <form on:submit|preventDefault={submit}>
            <div class="row g-3">
                <div class="col-md-12">
                    <h1 class="h4 fw-normal">Andata</h1>
                </div>
                <div class="col-md-4">
                    <label for="_" class="form-label">Partenza</label>
                    <input bind:value={departure} on:keyup={({ target }) => fetchAirport(target)} class="form-control" list="datalistOptions" placeholder="Areoporto di partenza">
                    <datalist id="datalistOptions">
                        {#each airports as airport}
                            <option value={airport}>
                        {/each}
                    </datalist>
                </div>
                <div class="col-md-4">
                    <label for="_" class="form-label">Arrivo</label>
                    <input bind:value={arrival} class="form-control" list="datalistOptions" placeholder="Areoporto di arrivo">
                    <datalist id="datalistOptions">
                        <option value="Roma">
                        <option value="Parigi">
                        <option value="Berlino">
                    </datalist>
                </div>

                <div class="col-4">
                    <label for="_" class="form-label">Data</label>
                    <input type="date" class="form-control" min={formatDate(startDate)} max={formatDate(endDate)}>
                </div>
                <div class="checkbox mb-3">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" bind:checked={ar}/>
                        <label class="form-check-label" for="gridCheck">
                            Andata e ritorno
                        </label>
                    </div>
                </div>
                {#if ar}
                    <div class="col-md-12">
                        <h1 class="h4 fw-normal">Ritorno</h1>
                    </div>
                    <div class="col-md-4">
                        <label for="_" class="form-label">Partenza</label>
                        <input bind:value={arrival} class="form-control" disabled>
                    </div>
                    <div class="col-md-4">
                        <label for="_" class="form-label">Arrivo</label>
                        <input bind:value={departure} class="form-control" disabled>
                    </div>
                    <div class="col-4">
                        <label for="_" class="form-label">Data</label>
                        <input type="date" class="form-control" min={formatDate(startDate)} max={formatDate(endDate)}>
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
        height: 100%;
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
        max-width: 70%;
    }
</style>
