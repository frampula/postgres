module.exports.getUsers = async () => {
    const response = await fetch('https://randomuser.me/api?results=500&seed=ONL&pasge=2');
    const data = await response.json();
    return data.results;
}