import { Component, OnInit } from '@angular/core';
import contractAddress from '../../../env/contractAddress.json';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styles: [
  ]
})
export class HomeComponent implements OnInit {

  public address:any = contractAddress.Contract;
  constructor() { }
  ngOnInit(): void {
  }

}
