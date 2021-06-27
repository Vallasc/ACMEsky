<script lang="ts">
    import { jwtToken } from "../stores"
    import { signout } from "../logic";
    import { useLocation } from "svelte-navigator"
    import {
        Collapse,
        Navbar,
        NavbarToggler,
        NavbarBrand,
        Nav,
        NavItem,
        NavLink,
        Dropdown,
        DropdownToggle,
        DropdownMenu,
        DropdownItem
    } from 'sveltestrap';

    let isOpen = false;

    function handleUpdate(event) {
        isOpen = event.detail.isOpen;
    }

    const location = useLocation()
	$: pathname = $location.pathname

</script>

<Navbar color="light" light expand="md">
  <NavbarBrand href="/">ACMEsky</NavbarBrand>
  <NavbarToggler on:click={() => (isOpen = !isOpen)} />
  <Collapse {isOpen} navbar expand="md" on:update={handleUpdate}>
    <Nav navbar>
        {#if $jwtToken != null}
            <NavItem>
                <NavLink href="/interest" active = {pathname == "/interest"}>Aggiungi interessi</NavLink>
            </NavItem>
            <NavItem>
                <NavLink href="/offer" active = {pathname == "/offer"}>Acquista offerta</NavLink>
            </NavItem>
            <NavItem>
                <NavLink href="/profile" active = {pathname == "/profile"}>Profilo</NavLink>
            </NavItem>
        {/if}
    </Nav>
    <Nav navbar>
        {#if $jwtToken != null}
            <NavItem>
                <NavLink href="/" on:click={signout}>SignOut</NavLink>
            </NavItem>
        {:else}
            <NavItem>
                <NavLink href="/signin" active = {pathname == "/signin"}>SignIn</NavLink>
            </NavItem>
        {/if}
    </Nav>
  </Collapse>
</Navbar>