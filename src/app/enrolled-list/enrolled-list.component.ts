import { Component, OnInit } from '@angular/core';
import { ethers } from 'ethers';
import contractAddress from '../../../env/contractAddress.json';
import DAO from '../../../blockchain/artifacts/blockchain/contracts/Database.sol/Database.json';
@Component({
  selector: 'app-enrolled-list',
  templateUrl: './enrolled-list.component.html',
  styles: [],
})
export class EnrolledListComponent implements OnInit {
  public provider: any = new ethers.providers.JsonRpcProvider('https://rpc.testnet.fantom.network');
  public DAOInterface: any;
  public data: any;
  public isLoading: boolean = true;
  constructor() {
    this.DAOInterface = new ethers.Contract(
      contractAddress.Contract,
      DAO.abi,
      this.provider
    );
  }

  ngOnInit(): void {
    this.getData();
  }

  public async getData() {
    let data = await this.DAOInterface.getAllMembers();
    this.data = data;
    console.log(this.data);
    this.isLoading = false;
  }
}
