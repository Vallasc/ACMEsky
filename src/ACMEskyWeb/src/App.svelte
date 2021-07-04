<script lang="ts">
	import { Router, Route, links, navigate } from "svelte-navigator"
	import Interest  from "./components/Interest.svelte"
	import Offer  from "./components/Offer.svelte"
	import Profile  from "./components/Profile.svelte"
	import SignUp  from "./components/SignUp.svelte"
	import SignIn  from "./components/SignIn.svelte"
	import NavBar  from "./components/NavBar.svelte"
	import Show  from "./components/Show.svelte"
    import { Toast, ToastBody, ToastHeader } from 'sveltestrap'
	import { setContext, onMount, getContext} from 'svelte'
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
					<h1>Home</h1>
				</div>
			</Route>
			<Route path="/interest">
				<Interest/>
			</Route>
			<Route path="/show">
				<Show/>
			</Route>
			<Route path="/offer">
				<Offer/>
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
				<Profile/>
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
</style>