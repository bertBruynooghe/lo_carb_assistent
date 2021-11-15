export default async () => {
  if (!navigator.serviceWorker) return
  await navigator.serviceWorker.register('/service_worker.js', { scope: '/' })
  console.log('[Companion]', 'Service worker registered!')
}
