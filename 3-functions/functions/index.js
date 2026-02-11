const { Firestore } = require('@google-cloud/firestore');

const firestore = new Firestore({
  projectId: process.env.PROJECT_ID,
  databaseId: process.env.FIRESTORE_DATABASE_ID
});

exports.getData = async (req, res) => {
  try {
    const snapshot = await firestore.collection('test').get();

    const data = snapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data()
    }));

    res.status(200).json(data);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error leyendo Firestore');
  }
};