
export const testDB = async (client) => {
  try {
    const res = await client.query("SELECT NOW()");
    console.log("Conexión exitosa. Hora actual en la BD:", res.rows[0]);
  } catch (err) {
    console.error("Error al ejecutar la consulta", err.stack);
  }
};
