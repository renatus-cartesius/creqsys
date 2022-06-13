// Requests router important requiries
const express = require("express"), 
    db = require("../controllers/db"),
    bodyParser = require("body-parser"),
    router = express.Router();


router.get("/requests", async (req, res)=>{
    try {
        console.log(`IP: ${req.ip} = [?] Giving list of all client requests`);
        const result = await db.pool.query(`
        select Requests.ID, Reqt, About, Request_status, Creation_time, Clients.Name, Clients.Surname, Clients.Phone, Clients.Email 
        from Requests inner join Clients
            on Requests.CID = Clients.ID
        `);
        res.send(result);
    }
    catch(err){
        throw err;
    }
});

router.post("/create_request", async(req, res)=>{
    let about = req.body.description;
    let cid = req.body.cid;
    let reqt = req.body.reqt;
    try {
        console.log(`IP: ${req.ip} = [+]Adding new requests: About: \"${about}\", Client_ID: ${cid}`);cid
        const result = await db.pool.query(`insert into Requests (Reqt, About, CID) values (\"${reqt}\", \"${about}\", ${cid})`);
        res.send({status: "Succesfull added", about, cid});
    } catch (error) {
        throw error;
    }
});

router.post("/close_request", async(req, res)=>{
    let rid = req.body.rid;
    try {
        console.log(`IP: ${req.ip} = [-] Closing request with Request_ID: ${rid}`);
        const result = await db.pool.query(`update Requests set Request_status = "Закрыт" where ID = ${rid}`);
        res.send({status: "Succesfull close requests", rid})
    } catch (error) {
        throw error;
    }
});

router.post("/delete_request", async (req, res)=>{
    try{
		console.log(`IP: ${req.ip} = [-] Deleting Request with ID: ${req.body.rid}`);
		const result = await db.pool.query(`delete from Requests where ID=\"${req.body.rid}\"`);
		res.send(result.status);
	}catch(err){
		throw err;
	}
});

router.get("/holder_employee", async(req, res)=>{
    let rid = req.query.rid;
    try{
        console.log(`IP: ${req.ip} = [?] Giving employee by request ID=${rid}`)
        const task = await db.pool.query(`select * from Requests where ID=${rid}`);
	const employee = await db.pool.query(`select * from Employees where ID=${task[0].EID}`);
        res.send(employee);

    }
    catch(err){
        throw err;
    }
});

module.exports = router;
