const { getUsers } = require("./api");
const { User, client, Product } = require("./models");
const { generatePhones } = require("./utils");

async function runRequest() {
  await client.connect();

  // const usersArray = await getUsers();
  // const response = await User.bulkCreate(usersArray);

  const phonesArray = generatePhones(400);
  const response = await Product.bulkCreate(phonesArray);
  console.log(response);
  await client.end();
}

runRequest();