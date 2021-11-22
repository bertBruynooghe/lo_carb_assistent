export const nutrientsUrl = location.origin + '<%= nutrients_path %>'
export const isNutrientFetch = r => r.method === 'GET' && r.url.indexOf(nutrientsUrl) === 0

const dbOpenRequest = self.indexedDB.open('nutrientsCalculator', 1)

dbOpenRequest.onupgradeneeded = ({ target: { result: db }, oldVersion }) => {
  switch (oldVersion) { // existing db version
    case 0:
      const nutrients = db.createObjectStore('nutrients', { keyPath: '_id', autoIncrement: true })
      nutrients.createIndex('id_idx', 'id', { unique: true })
  }
}

const dbConnection = new Promise((resolve, reject) => {
  dbOpenRequest.onerror = reject
  dbOpenRequest.onsuccess = ({ target: { result: db } }) => {
    db.onerror = ({ target: { errorCode } }) => console.error('Database error: ' + errorCode)
    resolve(db)
  }
})

export const fetchNutrients = r => {
  console.log('fetchNutrients')
  const acceptHeader = r.headers.get('accept')
  return (acceptHeader && acceptHeader.includes('application/json')
    ? fetchNutrientsJSON(r)
    : fetchNutrientsHTML(r))
}

const fetchNutrientsHTML = async request => {
  const oldResponse = await caches.match(request)

  const newResponse = fetch(request)
  newResponse.then(response => caches.open(request.url)
    .then(cache => cache.put(request, response))
    .catch(e => console.log('could not fetch nutrients', e)))
  return oldResponse || (await newResponse).clone()
}

const fetchNutrientsJSON = async request => {
  const searchString = new URL(request.url).searchParams.get('q[name_cont]').toLowerCase()

  const requestClone = new Request(nutrientsUrl, request)
  const allNutrientsResponse = await fetch(requestClone)
  const json = await allNutrientsResponse.clone().json()
  const transaction = (await dbConnection).transaction('nutrients', 'readwrite')
  const nutrients = transaction.objectStore('nutrients')
  await new Promise(resolve => nutrients.clear().onsuccess = resolve)
  await Promise.all(json.map(nutrient => new Promise(resolve => nutrients.add(nutrient).onsuccess = resolve)))
  const filtered = json.filter(nutrient => nutrient.name.toLowerCase().indexOf(searchString) >= 0)
  console.log('x', filtered)
  return new Promise(resolve => resolve(new Response(JSON.stringify(filtered), allNutrientsResponse)))
}