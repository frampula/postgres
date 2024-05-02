class Product {
    static _client;
    static _tableName;

    static async bulkCreate(phonesArray) {
        // 1. Перетворити JS-об'єкти телефонів в SQL-запит (маємо отримати масив SQL values в INSERTі)
        const valuesString = phonesArray.map(({brand, model, price, quantity = 1, category}) => 
        `('${brand}', '${model}', '${price}', '${quantity}', '${category}')`)
        .join(',');

        // 2. Виконати сам запит та зберегти результат виконання
        const { rows } = await this._client.query(
            `INSERT INTO ${this._tableName}
            (brand, model, price, quantity, category) VALUES
            ${valuesString} RETURNING *;`
        );

        // 3. Результат запиту повернути як результат роботи методу моделі
        return rows;
    }

    static async findAll() {
        return await this._client.query(`SELECT * FROM ${this._tableName};`);
    }
}

module.exports = Product;