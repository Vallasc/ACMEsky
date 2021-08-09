<script lang="ts">
    import { signup } from "../logic";
    import { Input } from 'sveltestrap';
    import { navigate } from "svelte-navigator"
    import { fade } from 'svelte/transition'
    import type { User } from "../types";

    let user : User = {    
        email : "",
        password : "",
        name : "",
        surname : "",
        prontogramUsername : ""
    }

    let invalidPass : boolean
    let repeatPassword : string

    function validate() : boolean {
        if(user.password.trim().length == 0)
            return false
        if(user.password != repeatPassword){
            invalidPass = true
            return false
        }
        invalidPass = false
        return true
    }

    async function handleSubmit(): Promise<void> {
        if(!validate())
            return;
        if( await signup(user)){
            navigate("/signin")
        }
    }

</script>
  
<div class="form" in:fade = {{duration: 200}}>
    <h1 class="h3 fw-normal">Registrati</h1>
    <form class="needs-validation" on:submit|preventDefault={handleSubmit}>
        <div class="mb-3">
            <label for="_" class="form-label">Nome</label>
            <input bind:value = {user.name} type="text" class="form-control" placeholder="Il tuo nome" required>
        </div>
        <div class="mb-3">
            <label for="_" class="form-label">Cognome</label>
            <input bind:value = {user.surname} type="text" class="form-control" placeholder="Il tuo cognome" required>
        </div>
        <div class="mb-3">
            <label for="_" class="form-label">Email</label>
            <input bind:value = {user.email} type="email" class="form-control" placeholder="La tua email" required>
        </div>
        <div class="mb-3">
            <label for="_" class="form-label">Password</label>
            <input bind:value = {user.password} type="password" class="form-control" placeholder="La tua password" required>
        </div>
        <div class="mb-3">
            <Input bind:value = {repeatPassword} invalid = {invalidPass} type="password" placeholder="Ripeti la tua password" feedback="Le password non combaciano" required />
        </div>
        <div class="mb-3">
            <label for="_" class="form-label">Prontogram username</label>
            <input bind:value = {user.prontogramUsername} type="text" class="form-control" placeholder="Il tuo username di Prontogram" required>
        </div>
        <button class="mb-3 mt-3 w-100 btn btn-primary" type="submit" >Sign up</button>
    </form>
</div>

<style>
    .form {
        width: 100%;
        display: flex;
        align-items: center;
        flex-direction: column;
        justify-content: flex-start;
        padding-top: 50px;
    }

    form {
        width: 100%;
        max-width: 350px;
        padding: 30px;
    }

</style>
