module.exports = async function (context, req) {
  context.log('HTTP trigger function processed a request.');

  const name = req.query.name || (req.body && req.body.name);

  context.res = {
    status: 200,
    body: `Hello World${name ? ', ' + name : ''}!`
  };
};