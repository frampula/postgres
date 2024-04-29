const { Client } = require("pg");
const { mapUsers } = require("./utils")
const { configs } = require("./configs")
const { getUsers } = require('./api')

const client = new Client(configs);

const user = {
    firstName: 'John',
    lastName: 'Doe',
    email: 'doe@gmail.com',
    isSubscribed: true,
    gender: 'male'
}

async function runRequest() {
  await client.connect();

  const usersArray = await getUsers()

  const response = await client.query(
    `INSERT INTO users (first_name, last_name, email, is_subscribe, gender) VALUES
    ${mapUsers(usersArray)}`
  );

  console.log(response);

  await client.end()
}
 runRequest()