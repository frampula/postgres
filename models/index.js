const { Client } = require('pg');
const { configs } = require('../configs');
const User = require('./User');
const Product = require('./Product');
const Order = require('./Order');

const client = new Client(configs);

// Фаршируємо модель клієнтом і назвою таблиці

User._client = client;
User._tableName = 'users';

Product._client = client;
Product._tableName = 'products';

Order._client = client;
Order._tableNames = ['orders', 'orders_to_products']; // 0 - головна таблиця, 1 - підлегла таблиця

module.exports = {
    client,
    User, 
    Product, 
    Order 
}