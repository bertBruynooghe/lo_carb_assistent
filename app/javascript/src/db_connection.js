const dbVersion = 3
const dbOpenRequest = self.indexedDB.open('nutrientsCalculator', dbVersion)

dbOpenRequest.onupgradeneeded = ({ target: { result: db }, oldVersion, currentTarget: { transaction } }) => {
  let mealsStore
  switch (oldVersion) { // existing db version
    case 0:
      const nutrients = db.createObjectStore('nutrients', { keyPath: '_id', autoIncrement: true })
      nutrients.createIndex('id_idx', 'id', { unique: true })
    case 1: 
      mealsStore = db.createObjectStore('meals', { keyPath: '_id', autoIncrement: true })
      mealsStore.createIndex('id_idx', 'id', { unique: true })
    case 2:
      mealsStore = mealsStore || transaction.objectStore('meals')
      mealsStore.createIndex('clientToken_idx', 'client_token')
  }
}

export default new Promise((resolve, reject) => {
  dbOpenRequest.onerror = reject
  dbOpenRequest.onsuccess = ({ target: { result: db } }) => {
    db.onerror = ({ target: { errorCode } }) => console.error('Database error: ' + errorCode)
    resolve(db)
  }
})