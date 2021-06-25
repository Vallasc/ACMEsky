<script lang="ts">
    import { signup } from "../logic";
    import { Input } from 'sveltestrap';
    import { navigate } from "svelte-navigator"

    let email : string
    let password : string
    let repeatPassword : string
    let invalidPass : boolean
    let token : string

    function validate() : boolean {
        if(password.trim().length == 0)
            return false
        if(password != repeatPassword){
            invalidPass = true
            return false
        }
        invalidPass = false
        return true
    }

    async function handleSubmit(): Promise<void> {
        if(!validate())
            return;
        if( await signup(email, password, token)){
            navigate("/signin")
        }
    }

</script>
  
<div class="form">
    <h1 class="h3 fw-normal">Please sign up</h1>
    <form class="needs-validation" on:submit|preventDefault={handleSubmit}>
        <div class="mb-3">
            <label for="cntrolInput1" class="form-label">Email</label>
            <input bind:value = {email} type="email" class="form-control" placeholder="Inserisci la tua email" required>
        </div>
        <div class="mb-3">
            <label for="controlInput1" class="form-label">Password</label>
            <input bind:value = {password} type="password" class="form-control" placeholder="Inserisci la tua password" required>
        </div>
        <div class="mb-3">
            <Input bind:value = {repeatPassword} invalid = {invalidPass} type="password" placeholder="Inserisci la tua password" feedback="Le password non combaciano" required />
        </div>
        <div class="mb-3">
            <label for="controlInput1" class="form-label">Prontogram token</label>
            <input bind:value = {token} type="text" class="form-control" placeholder="Inserisci il token" required>
        </div>
        <button class="mb-3 mt-3 w-100 btn btn-primary" type="submit" >Sign up</button>
    </form>
</div>

<style>
    .form {
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        flex-direction: column;
        justify-content: flex-start;
        padding-top: 130px;
    }

    form {
        width: 100%;
        max-width: 350px;
        padding: 30px;
    }

</style>
