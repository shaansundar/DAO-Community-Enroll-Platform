const fs = require("fs");


function exportAddresses(Contract1, Contract2){ //Pass in interface after deploying the contractFactory
    let addresses = {
        "Contract1": Contract1,
        "Contract2": Contract2
    };
    let addressesJSON = JSON.stringify(addresses);
    fs.writeFileSync("env/contractAddress.json", addressesJSON);
}