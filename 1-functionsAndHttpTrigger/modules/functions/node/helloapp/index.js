const { BlobServiceClient } = require("@azure/storage-blob");
const Busboy = require("busboy");

module.exports = async function (context, req) {
  if (req.method !== "POST") {
    context.res = { status: 405, body: "Method not allowed" };
    return;
  }

  const blobServiceClient = BlobServiceClient.fromConnectionString(
    process.env.AzureWebJobsStorage
  );

  const containerName = "files";
  const containerClient = blobServiceClient.getContainerClient(containerName);

  const busboy = Busboy({ headers: req.headers });

  const uploads = [];

  busboy.on("file", (fieldname, file, filename) => {
    const folder = `uploads/${new Date().toISOString().split("T")[0]}`;
    const blobName = `${folder}/${filename.filename}`;

    const blockBlobClient = containerClient.getBlockBlobClient(blobName);

    const uploadPromise = blockBlobClient.uploadStream(file);
    uploads.push(uploadPromise);
  });

  busboy.on("finish", async () => {
    await Promise.all(uploads);

    context.res = {
      status: 200,
      body: "Archivo subido correctamente"
    };
  });

  req.pipe(busboy);
};
