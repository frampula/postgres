class Product {
    static _client;
    static _tableName;

    static async bulkCreate(phonesArray) {
        const valuesString = phonesArray.map(({brand, model, price, quantity = 1, category}) => {
        return `('${brand}', '${model}', '${price}', '${quantity}', '${category}')`
        }).join(',');

        const { rows } = await this._client.query(
            `INSERT INTO ${this._tableName}
            (brand, model, price, quantity, category) VALUES 
            ${valuesString} RETURNING *;`
        );

        return rows
    }
}

module.exports = Product