//DEPENDNCIAS ================================================
const { app } = require("@azure/functions");
const { DefaultAzureCredential } = require("@azure/identity");
const { KeyClient, CryptographyClient } = require("@azure/keyvault-keys");

const { Pool } = require("pg");
const { testDB, encryptData } = require("./utils");

// CONSTANTES ================================================
const connectionString = process.env.DB_CONNECTION;
const vaultUrl = process.env.KEYVAULT_URL;

const pool = new Pool({ connectionString: connectionString });



// FUNCION ========================================================
app.http("secureData", {
  methods: ["GET", "POST"],
  authLevel: "anonymous",
  handler: async (request, context) => {
    const client = await pool.connect();
    await testDB(client);

    try {
      const method = request.method;

      context.log(`Http function processed request for url "${request.url}"`);
      context.log(`Método recibido: ${method}`);

      if (method === "GET") {
        const queryKey = request.query.keys().next();

        if (queryKey.value === "id") {
          return getCardUser(request, client);
        }
        return getCardsUsers(request, client);
      }

      if (method === "POST") {
        const bodyData = await request.json();
        return await postCardUser(bodyData, client);
      }

      return { status: 405, body: "Método no soportado" };
    } catch (error) {
      context.error("Error en la funcion", error);
    } finally {
      context.log("Cerrando conexion");
      client.release();
    }
  },
});

async function getCardsUsers(request, client) {
  // Obtenemos el parámetro 'limit' de la URL (ej: /api/secureData?limit=5)
  // Si no se envía, por defecto traemos un máximo de 10 registros
  const limitParam = request.query.get("limit") || "10";
  const limit = parseInt(limitParam, 10);

  const queryText = "SELECT * FROM user_cards ORDER BY id DESC LIMIT $1;";
  const result = await client.query(queryText, [limit]);

  return {
    status: 200,
    jsonBody: {
      total: result.rowCount,
      data: result.rows,
    },
  };
}

async function getCardUser(request, client) {
  const id = parseInt(request.query.get("id"));

  const queryText = `
      SELECT id, user_id, card_data, created_at 
      FROM user_cards 
      WHERE id = $1 
      ORDER BY id DESC 
      LIMIT 1;
    `;

  const result = await client.query(queryText, [id]);
  const row = result.rows[0];

  const cryptoClient = await getCryptoClient();

  const decryptResult = await cryptoClient.decrypt({
    algorithm: "RSA-OAEP-256",
    ciphertext: row.card_data, // Pasamos el Buffer directamente
  });

  const decryptedText = new TextDecoder().decode(decryptResult.result);

  return {
      status: 200,
      jsonBody: {
        id: row.id,
        user_id: row.user_id,
        card_data: decryptedText,
        created_at: row.created_at
      }
    };
}

async function getCryptoClient(){
  const credential = new DefaultAzureCredential();
  const keyClient = new KeyClient(vaultUrl, credential);

  const key = await keyClient.getKey("secureData");
  return new CryptographyClient(key.id, credential);
}

async function postCardUser(bodyData, client) {
  const cryptoClient = await getCryptoClient();

  const encryptResult = await cryptoClient.encrypt({
    algorithm: "RSA-OAEP-256",
    plaintext: Buffer.from(bodyData.card_data),
  });

  const queryText = `
      INSERT INTO user_cards (user_id, card_data) 
      VALUES ($1, $2) 
      RETURNING id, created_at;
    `;

  const values = [bodyData.user_id, encryptResult.result];

  const result = await client.query(queryText, values);
  console.log("Tarjeta guardada con ID:", result.rows[0].id);

  return {
    status: 200,
    jsonBody: {
      message: "Tarjeta cifrada y guardada exitosamente",
      id: result.rows[0].id,
    },
  };
}
