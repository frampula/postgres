const _ = require('lodash')

module.exports.mapUsers = (usersArray) =>
  usersArray
    .map(
      ({ name: { first, last }, gender, email }) =>
        `('${first}', '${last}', '${email}', ${Boolean(
          Math.random() > 0.5
        )}, '${gender}')`
    )
    .join(",");
const PHONES_BRANDS = [
    'Samsung',
    'Iphone',
    'Xiaomi',
    'Huawei',
    'Sony',
    'Nokia'
]

const generateOnePhone = modelNumber => ({
    brand: PHONES_BRANDS[_.random(0, PHONES_BRANDS.length - 1, false)],
    model: `model ${modelNumber}`,
    quantity: _.random(10, 1500, false),
    price: _.random(150, 10000, false),
    category: 'phones'
});

module.exports.generatePhones = (phonesCount = 100) => {
    const phonesArray = [];

    for (let i = 0; i < phonesCount; i++) {
        phonesArray.push(generateOnePhone(i))
    }

    return phonesArray;
}