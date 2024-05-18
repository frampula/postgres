class Thing {
    static _tableName = 'things';
    static _client;
    static name = 'Thing';

    static _attributes = {
        body: 'string',
    };

    static async create(insertValues) {
        // 1. Відсіяли "ліві" атрибути, яких ми не очікуємо
        const insertAttr = Object.entries(this._attributes)
            .filter(([attr, domain]) => attr in insertValues)
            .map(([attr]) => attr);

        // 2. До кожного атрибута доклеюємо кавички і додаємо кому в кінці
        // Робимо строку, яка визначає стовпці, які ми вставляємо та порядок, в якому ми ці стовпці будемо передавати
        const insertSchema = insertAttr
            .map((currentAttr) => `"${currentAttr}"`)
            .join(',');

        // 3. Робимо строчку запиту на створення, огортаючи її в одинарні лапки
        const insertValueStr = insertAttr
            .map((currentAttr) => {
                const value = insertValues[currentAttr];
                // Якщо лежить строка - загортаємо її в кавички
                // Якщо лежить не строчка - не загортаємо її в кавички
                return typeof value === 'string' ? `'${value}'` : value;
            })
            .join(',');

        // 4. Безпосередньо сам запит до БД
        const queryStr = `
        INSERT INTO ${this._tableName} (${insertSchema})
        VALUES (${insertValueStr})
        RETURNING *;
        `;

        // 5. Виконуємо запит
        const { rows } = await this._client.query(queryStr);

        return rows;
    }

    static async findByPk(pk) {
        const { rows } = await this._client.query(`
        SELECT * FROM ${this._tableName}
        WHERE id = ${pk}; 
        `);

        return rows;
    }

    static async findAll() {
        const { rows } = await this._client.query(`
        SELECT * FROM ${this._tableName};
        `);

        return rows;
    }

    static async updateByPk({ id, updateValues }) {
        const insertAttr = Object.entries(this._attributes)
            .filter(([attr, domain]) => attr in updateValues)
            .map(([attr]) => attr);

        const insertValueStr = insertAttr
            .map((attr) => {
                const value = updateValues[attr];

                return `${attr} = ${
                    typeof value === 'string' ? `'${value}'` : value
                }`;
            })
            .join(',');

        const { rows } = await this._client.query(`
        UPDATE ${this._tableName}
        SET ${insertValueStr}
        WHERE id = ${id}
        RETURNING *;
        `);

        return rows;
    }

    static async deleteByPk(pk) {
        const { rows } = await this._client.query(`
        DELETE FROM ${this._tableName}
        WHERE id = ${pk}
        RETURNING *;
        `);

        return rows;
    }
}

module.exports = Thing;