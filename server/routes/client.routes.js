// Clients router important requiries
const express = require("express"), 
    db = require("../controllers/db"),
    bodyParser = require("body-parser"),
    router = express.Router();

router.get("/", (req, res)=>{
    res.send("OK");
});

router.get("/clients", async (req, res)=>{
    try{
        console.log(`IP: ${req.ip} = [?] Giving list of all clients`);
        const result = await db.pool.query(`select * from Clients;`);
        res.send(result);
    }catch(err){

    }
});

router.get("/client", async (req, res)=>{
	try{
		const result = await db.pool.query(`select * from Clients where ID=${req.query.cid}`);
		console.log(`IP: ${req.ip} = [?] Giving information about concrete Client: `);
		res.send(result);
	}catch(err){	
		throw err;
	}
});

router.post("/create_client", async (req, res)=>{
	let name = req.body.name;
	let surname = req.body.surname;
	let phone = req.body.phone;
	let email = req.body.email;
	try{
        console.log(`IP: ${req.ip} = [+] Creating new client: (\"${name}\", \"${surname}\", \"${phone}\", \"${email}\")`);
		const result = await db.pool.query(`insert into Clients (Name, Surname, Phone, Email) values (\"${name}\", \"${surname}\", \"${phone}\", \"${email}\")`);
		res.send(result.status);
	}catch(err){
		throw err;
	}
});

router.post("/delete_client", async (req, res)=>{
	try{
		console.log(`IP: ${req.ip} = [-] Deleting Client with ID: ${req.body.cid}`);
		const result = await db.pool.query(`delete from Clients where ID=\"${req.body.cid}\"`);
		res.send(result.status);
	}catch(err){
		throw err;
	}
});


module.exports = router;