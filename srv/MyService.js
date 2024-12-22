module.exports = (srv) => {
    srv.on('pokemon', (req)=> {
        return `Hello ${req.data.name}`
    })
}