const dbVersion = 2
const dbOpenRequest = self.indexedDB.open('nutrientsCalculator', dbVersion)

dbOpenRequest.onupgradeneeded = ({ target: { result: db }, oldVersion }) => {
  switch (oldVersion) { // existing db version
    case 0:
      const nutrients = db.createObjectStore('nutrients', { keyPath: '_id', autoIncrement: true })
      nutrients.createIndex('id_idx', 'id', { unique: true })
    case 1:
      const meals = db.createObjectStore('meals', { keyPath: '_id', autoIncrement: true })
      meals.createIndex('id_idx', 'id', { unique: true })
  }
}

export default new Promise((resolve, reject) => {
  dbOpenRequest.onerror = reject
  dbOpenRequest.onsuccess = ({ target: { result: db } }) => {
    db.onerror = ({ target: { errorCode } }) => console.error('Database error: ' + errorCode)
    resolve(db)
  }
})