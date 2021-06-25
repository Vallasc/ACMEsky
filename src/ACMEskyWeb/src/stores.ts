import { writable } from 'svelte/store'

export const jwtToken = writable(null)
export const acmeskyHost = writable("")