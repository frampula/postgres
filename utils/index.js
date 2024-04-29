module.exports.mapUsers = (usersArray) =>
    usersArray
        .map(
            ({ name: { first, last }, gender, email }) =>
                `('${first}', '${last}', '${email}', ${Boolean(
                    Math.random() > 0.5
                )}, '${gender}')`
        )
        .join(',');