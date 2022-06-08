// Requests router important requiries
const express = require("express"), 
    db = require("../controllers/db"),
    bodyParser = require("body-parser"),
    router = express.Router();


router.get("/requests", async (req, res)=>{
    try {
        console.log("[?] Giving list of all client requests");
        const result = await db.pool.query(`
        select About, Request_status, Creation_time, Clients.Name, Clients.Surname 
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
    try {
        console.log(`[+]Adding new requests: About: \"${about}\", Client_ID: ${cid}`);cid
        const result = await db.pool.query(`insert into Requests (About, CID) values (\"${about}\", ${cid})`);
        res.send({status: "Succesfull added", about, cid});
    } catch (error) {
        throw error;
    }
});

router.post("/close_request", async(req, res)=>{
    let rid = req.body.rid;
    try {
        console.log(`[-] Closing request with Request_ID: ${rid}`);
        const result = await db.pool.query(`update Requests set Request_status = "Closed" where ID = ${rid}`);
        res.send({status: "Succesfull close requests", rid})
    } catch (error) {
        throw error;
    }
});

router.get("/holder_employee", async(req, res)=>{
    let rid = req.query.rid;
    try{
        console.log(`[?] Giving employee by request ID=${rid}`)
        const task = await db.pool.query(`select * from Requests where ID=${rid}`);
	const employee = await db.pool.query(`select * from Employees where ID=${task[0].EID}`);
        res.send(employee);

    }
    catch(err){
        throw err;
    }
});

module.exports = router;
