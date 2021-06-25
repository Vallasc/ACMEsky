<script lang="ts">
    import { onMount } from 'svelte'
    import { getUser, updateUser, deleteUser } from '../logic'
    import { navigate } from "svelte-navigator"
    
    let email : string
    let password : string
    let newPassword : string
    let prontogramToken : string

    let disabled : boolean = true

    onMount(async () => {
        let response = await getUser()
        if(response != null){
            email = response.email
            //password = response.password
            prontogramToken = response.prontogramToken
            disabled = false
        }
	})

    function validate() : boolean {
        if(password.trim().length == 0)
            return false
        return true
    }

    async function handleSubmit(event): Promise<void> {
        if(!validate())
            return;

        const {submitter: submitButton} = event;
        if(submitButton.id == "save") {
            await updateUser(email, password, newPassword == "" ? null : newPassword, prontogramToken)
        } else if(submitButton.id == "delete"){
            await deleteUser(email, password)
            navigate("/")
        }
    }

</script>

<div class="form" on:submit|preventDefault={handleSubmit}>
    <img class="mb-3 mt-4" src="profile.png" alt="profile" height="120" />
    <h1 class="h3 fw-normal">Your profile</h1>
    <form>
        <div class="mb-3">
            <label for="_" class="form-label">Email</label>
            <input bind:value={email} type="email" class="form-control" readonly>
        </div>
        <div class="mb-3">
            <label for="_" class="form-label">Password</label>
            <input bind:value={password} type="password" class="form-control" placeholder="" required disabled = {disabled}>
        </div>
        <div class="mb-3">
            <label for="_" class="form-label">Nuova password</label>
            <input bind:value={newPassword} type="password" class="form-control" placeholder="" disabled = {disabled}>
        </div>
        <div class="mb-3">
            <label for="_" class="form-label">Prontogram token</label>
            <input bind:value={prontogramToken} type="text" class="form-control" disabled = {disabled}>
        </div>
        <button id="save" class="w-100 mb-3 mt-3 btn btn-primary" type="submit" disabled = {disabled}>Save</button>
        <hr class="mb-3 dropdown-divider"/>
        <button id="delete" class="w-100 btn btn-danger" type="submit" disabled = {disabled} >Delete account</button>
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
    }

    form {
        width: 100%;
        max-width: 350px;
        padding: 30px;
    }
</style>