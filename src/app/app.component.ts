import { Component } from '@angular/core';
import contractAddress from '../../env/contractAddress.json';
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'Angular-Ethers-Hardhat-Template';
  public address:any = contractAddress.Contract;
}
