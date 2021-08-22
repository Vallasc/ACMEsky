<script lang="ts">
	import { Router, Route, links, navigate } from "svelte-navigator"
	import Interest  from "./components/Interest.svelte"
	import BuyOffer  from "./components/BuyOffer.svelte"
	import Profile  from "./components/Profile.svelte"
	import Offers  from "./components/Offers.svelte"
	import SignUp  from "./components/SignUp.svelte"
	import SignIn  from "./components/SignIn.svelte"
	import NavBar  from "./components/NavBar.svelte"
	import Show  from "./components/Show.svelte"
    import { Toast, ToastHeader } from 'sveltestrap'
	import { setContext, getContext} from 'svelte'
	import { jwtToken } from "./stores"
	import { init } from "./logic"

	$: {
		if($jwtToken == null)
			navigate("/")
	}

	

	let isOpen : boolean = false
	let toastMessage : string

    function closeToast() {
      isOpen = false
    }

	setContext("toast", {
		showToast : (message: string, autohide: boolean) => {
			toastMessage = message
			isOpen = true
			if( autohide ) {
				setTimeout(closeToast, 3000)
			}

		}
	})
	init(getContext("toast"))

	
</script>

<div class="main" use:links>
	<Router>
		<header>
			<NavBar/>
		</header>
		<main>
			<Route path="/">
				<div class="center mt-4">
					<h1 class="mt-4">Benvenuto in ACMEsky</h1>
					<p>Se non l'hai ancora fatto, registrati!</p>
					<div class="mt-4 mb-4"></div>
					<h4>1. <a href="/interest">Inserisci</a> le tue tratte di interesse</h4>
					<div class="button-down"></div>
					<h4>2. Riceverai la tua offerta riservata su <a href="http://localhost:8051/" target="_blank">Prontogram™</a></h4>
					<div class="button-down"></div>
					<h4>3. Accedi e <a href="/buy">acquista</a> l'offerta</h4>
					<div class="button-down"></div>
					<h4>4. Goditi il tuo viaggio :)</h4>
				</div>
			</Route>
			<Route path="/interest">
				{#if $jwtToken != null}
					<Interest/>
				{:else}
					{navigate("/signin")}
				{/if}
			</Route>
			<Route path="/show">
				{#if $jwtToken != null}
					<Show/>
				{:else}
					{navigate("/signin")}
				{/if}
			</Route>
			<Route path="/buy">
				{#if $jwtToken != null}
					<BuyOffer/>
				{:else}
					{navigate("/signin")}
				{/if}
			</Route>
			<Route path="/offers">
				{#if $jwtToken != null}
					<Offers/>
				{:else}
					{navigate("/signin")}
				{/if}
			</Route>
			{#if $jwtToken == null}
				<Route path="/signin">
					<SignIn/>
				</Route>
				<Route path="/signup">
					<SignUp/>
				</Route>
			{/if}
			<Route path="/profile">
				{#if $jwtToken != null}
					<Profile/>
				{:else}
					{navigate("/signin")}
				{/if}
			</Route>
			<Route>
				<div class="center mt-4">
					<h1 class="h1 fw-normal">404</h1>
					<p>Ops...</p>
				</div>
			</Route>
		</main>
	</Router>
</div>

<div class="main-toast ">
	<Toast {isOpen}>
			<ToastHeader toggle={closeToast}>{toastMessage}</ToastHeader>
	</Toast>
</div>

<style>
	.main {
		display: flex;
		flex-direction: column;
		align-items: stretch;
		background-color: #ffffff;
		height: 100%;
		width: 100%;
	}
	main { 
		flex: 1;
		overflow-y: auto;
	}

	.center {
		display: flex;
		flex-direction: column;
		align-items: center;
	}

	.main-toast {
		position: fixed;
		bottom: 40px;
		left: 50%;
		transform: translateX(-50%);
	}

	.button-down {
		position: relative;
		padding: 5px;
		margin: 10px auto;
		height: 50px;
		width: 50px;
	}

	.button-down::after {
		content: "";
		position: absolute;
		z-index: 11;
		display: block;
		width: 25px;
		height: 25px;
		border-top: 2px solid rgb(0, 0, 0);
		border-left: 2px solid rgb(0, 0, 0);
		transform: rotate(225deg);
		top: 0px;
		left: 13px;
	}
</style>