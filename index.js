const { configs } = require("./configs")
const { getUsers } = require('./api')
const { User, client } = require('./models/index')

async function runRequest() {
  await client.connect();

  const usersArray = await getUsers()

  const response = await User.bulkCreate(usersArray)

  console.log(response);

  await client.end()
}
 runRequest()