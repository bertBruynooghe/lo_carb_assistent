export default async () => {
  if (!navigator.serviceWorker) return
  await navigator.serviceWorker.register('/serviceworker.js', { scope: '/' })
  console.log('[Companion]', 'Service worker registered!')
}
