<script lang="ts">
    import Steps from "./Steps.svelte"
    import { fade, fly } from 'svelte/transition'

    let step : number = 0

    function submit(){
        if(step < 3) 
            step++
        console.log(step)
    }
    function back(){
        step = step -1
        console.log(step)
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
                    <input type="text" class="form-control" placeholder="Inserisci il codice offerta" required>
                </div>
            {:else if step == 1}
                <div class="row g-3" in:fly={{ x: 200, duration: 300 }}>
                    <div class="col-md-6">
                        <label for="inputEmail4" class="form-label">Nome</label>
                        <input type="text" class="form-control" id="inputEmail4">
                    </div>
                    <div class="col-md-6">
                        <label for="inputPassword4" class="form-label">Cognome</label>
                        <input type="password" class="form-control" id="inputPassword4">
                    </div>
                    <div class="col-12">
                        <label for="inputAddress" class="form-label">Indirizzo</label>
                        <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
                    </div>
                    <div class="col-md-6">
                        <label for="inputCity" class="form-label">Città</label>
                        <input type="text" class="form-control" id="inputCity">
                    </div>
                    <div class="col-md-4">
                        <label for="inputState" class="form-label">Stato</label>
                        <select id="inputState" class="form-select">
                        <option selected>Choose...</option>
                        <option>...</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label for="inputZip" class="form-label">CAP</label>
                        <input type="text" class="form-control" id="inputZip">
                    </div>
                </div>
            {:else if step == 2}
                <div in:fly={{ x: 200, duration: 300 }}>
                        <h1 class="h3 fw-normal mb-4">Ti stiamo indirizzando al provider di pagamenti</h1>
                        <p>Per favore non chiudere questa pagina</p>
                </div>
            {:else if step == 3}
                <div in:fly={{ x: 200, duration: 300 }}>
                    <h1 class="h3 fw-normal mb-4">Il tuo viaggio è pronto</h1>
                    <p>Ecco i biglietti</p>
                </div>
            {/if}
            <div class="mt-4"></div>
            <div class="button-row">
                {#if step != 0}
                    <button class="mt-3 btn btn-light" type="button" on:click={back}>Indietro</button>
                {:else}
                    <div></div>
                {/if}
                {#if step != 3}
                    <button class="mt-3 btn btn-primary" type="submit">Avanti</button>
                {:else}
                    <button class="mt-3 btn btn-primary" type="submit">Fine</button>
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