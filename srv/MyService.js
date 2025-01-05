const cds = require('@sap/cds');
const { employees } = cds.entities("yash.db.master");

module.exports = (srv) => {
    srv.on('pokemon', (req)=> {
        return `Hello ${req.data.name}`
    })

    srv.on('READ','ReadEmployeeSrv', async(req)=> {
        const tx = await cds.tx(req);

        // var results = await tx.run(SELECT.from(employees).limit(5));
        // // console.log(tx);
        // for (let i = 0; i < results.length; i++) {
        //     const element = results[i];
        //     element.nameMiddle = 'bhadiya!@'
        // }
        // return results;

        // Working with the condition
        let whereCondition = req.data;
        if(whereCondition.hasOwnProperty('ID')){
            return await tx.run(SELECT.from(employees).where(whereCondition));
        } else {
            return await tx.run(SELECT.from(employees).where({'sex':'F'}));
        }
    });
}