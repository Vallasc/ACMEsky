<script lang="ts">
    import { jwtToken } from "../stores"
    import { signout } from "../logic";
    import { useLocation } from "svelte-navigator"
    import { slide } from 'svelte/transition';

    const location = useLocation()
	$: pathname = $location.pathname

</script>

<nav class="navbar navbar-light bg-light navbar-expand-lg ">
    <div class="container-md">
        <a href="/" class="navbar-brand">ACMEsky</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
            <div transition:slide class="collapse navbar-collapse justify-content-end" id="navbarCollapse">
                <ul class="navbar-nav">
                    {#if $jwtToken != null}
                        <li class="navbar-item">
                            <a href="/interest" class="nav-link" class:active = {pathname == "/interest"}>Aggiungi interessi</a>
                        </li>
                        <li class="navbar-item">
                            <a href="/offer" class="nav-link" class:active = {pathname == "/offer"}>Acquista offerta</a>
                        </li>
                        <li class="navbar-item">
                            <a href="/profile" class="nav-link" class:active = {pathname == "/profile"}>Profilo</a>
                        </li>
                        <li class="navbar-item">
                            <a href="/" class="nav-link" on:click={signout}>SignOut</a>
                        </li>
                    {:else}
                        <li class="navbar-item">
                            <a href="/signin" class="nav-link" class:active = {pathname == "/signin"}>SignIn</a>
                        </li>
                    {/if}
                </ul>
            </div>
    </div>
</nav>
