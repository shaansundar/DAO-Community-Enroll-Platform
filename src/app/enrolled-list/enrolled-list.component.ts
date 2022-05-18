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

  public timeConverter(UNIX_timestamp: any){
    var a = new Date(UNIX_timestamp * 1000);
    var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    var year = a.getFullYear();
    var month = months[a.getMonth()];
    var date = a.getDate();
    var hour = a.getHours();
    var min = "0"+ a.getMinutes();
    var sec = "0"+ a.getSeconds();
    var time = date + ' ' + month + ' ' + year + ' - ' + hour + ':' + min.substr(-2) + ':' + sec.substr(-2) ;
    return time;
  }
}
