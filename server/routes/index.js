// Express config
const express = require("express"),
    router = express.Router(),
    employessRoutes = require("./employee.routes"),
    tasksRoutes = require("./request.routes");

// Using Employees router
router.use("/employee", employessRoutes);
router.use("/request", tasksRoutes);

module.exports = router;
