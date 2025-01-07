module.exports = cds.service.impl(async function(){

    const {POs, EmployeeSet} = this.entities;
    // console.log(this.entities);
    // Implementing the generic handle 
    this.before(['CREATE', 'PATCH'], EmployeeSet, (req)=>{
        if(req.data.salaryAmount >= 1000000){
            req.error(500, 'Hello Dear, you cant put the value higher that the 1000000');
        }
    });

    this.on('boost', async (req)=> {
        try {
            const ID = req.params[0];
            const tx = cds.tx(req)
            await tx.update(POs).with({
                GROSS_AMOUNT: { '+=' : 20000 }
            }).where(ID);
            
        } catch (error) {
            return 'Error = ' + error.toString();            
        }   
    });

    this.on('largestOrder', async (req)=> {
        try {
            const tx = cds.tx(req);
            const recordData = await tx.read(POs).orderBy({
                GROSS_AMOUNT : 'desc'    
            }).limit(1);    
            return recordData;
        } catch (error) {
            return 'Error = ' + error.toString();            
        }   
    });

    this.on('getOrderStatus', async(req, res)=>{
        try {
            return {
                "OVERALL_STATUS": 'N'
            }
        } catch (error) {
            return `Error = ${error.toString()}`
        }
    });

});