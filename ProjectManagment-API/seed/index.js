const connection = require("../database/index");
const fs = require('fs');
const path = require('path');


async function seedingData() {
    const getTabels = fs.readFileSync(path.join(__dirname, '../sql/PMS-DUMMY.sql')).toString();
    const [rows] = await connection.execute(getTabels, []);
    console.log('hello from seed')
    console.log(rows)
    return rows[0];
  }
seedingData()