import { isNutrientFetch, fetchNutrients } from '../src/nutrients_fetch_handler.js'

const resourcesToCache = {
  '<%= asset_path "application.js" %>': {},
  '<%= asset_pack_path "application.js" %>': {},
  '<%= nutrients_url %>': { Accept: 'text/html,application/xhtml+xml,application/xml' },
  '<%= asset_path "application.css" %>': {},
  '/app.webmanifest': {}
}

function onInstall(e) {
  console.log('[ServiceWorker]', 'Installing!', e)
  e.waitUntil(
    Promise.all(
      Object.entries(resourcesToCache)
        .map(([name, headers]) => caches.open(name)
          .then(cache => {
            const request = new Request(name, { headers })
            return cache.add(request)
          }))))
}

function onActivate(e) {
  console.log('[ServiceWorker]', 'Activating!', e)
  e.waitUntil(
    caches.keys().then(keys =>
      // remember that caches are shared across the whole origin
      Promise.all(
        keys.filter(key => !Object.keys(resourcesToCache).includes(key))
          .map(key => caches.delete(key)))))
}

const offlineHandler = async (request) => {
  // if it fails, try to return request from the cache
  const response = await caches.match(request)
  if (response) return response
  // if not found in cache, return default offline content for navigate requests
  if (request.mode === 'navigate' ||
    (request.method === 'GET' && request.headers.get('accept').includes('text/html'))) {
    console.log('[ServiceWorker]', 'Fetching offline content')
    return await caches.match(new Request('<%= nutrients_url %>', { headers: resourcesToCache['<%= nutrients_url %>'] }))
  }
}

// Borrowed from https://github.com/TalAter/UpUp
async function onFetch(e) {
  const result = isNutrientFetch(e.request)
    ? fetchNutrients(e.request)
    : fetch(e.request).catch(() => offlineHandler(e.request))

  e.respondWith(result)
}

self.addEventListener('install', onInstall)
self.addEventListener('activate', onActivate)
self.addEventListener('fetch', onFetch)
