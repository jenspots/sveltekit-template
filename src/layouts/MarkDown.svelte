<script>
	export let title = '';
</script>

<svelte:head>
	{#if title !== ''}
		<title>{title}</title>
	{/if}
</svelte:head>

<div class="markdown">
	<slot />
</div>
