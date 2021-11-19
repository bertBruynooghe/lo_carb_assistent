import { isNutrientFetch, fetchNutrients } from '../src/nutrients_fetch_handler.js'

const resourcesToCache = [
  '<%= asset_path "application.js" %>',
  '<%= asset_pack_path "application.js" %>',
  '<%= asset_path "application.css" %>',
  '/offline.html'
]

function onInstall(e) {
  console.log('[ServiceWorker]', 'Installing!', e)
  e.waitUntil(Promise.all(resourcesToCache.map(name => caches.open(name).then(cache => cache.add(name)))))
}

function onActivate(e) {
  console.log('[ServiceWorker]', 'Activating!', e)
  e.waitUntil(
    caches.keys().then(keys =>
      // remember that caches are shared across the whole origin
      Promise.all(
        keys.filter(key => !resourcesToCache.includes(key))
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
    return caches.match('/offline.html')
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
