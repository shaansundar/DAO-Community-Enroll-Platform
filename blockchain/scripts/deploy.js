const fs = require("fs");


function exportAddresses(Contract){ //Pass in interface after deploying the contractFactory
    let addresses = {
        "Contract": Contract,
    };
    let addressesJSON = JSON.stringify(addresses);
    fs.writeFileSync("env/contractAddress.json", addressesJSON);
}