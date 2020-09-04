import { Component, OnInit } from '@angular/core';
import { FuncionariosService } from './services/funcionarios.service';

@Component({
  selector: 'app-funcionarios',
  templateUrl: './funcionarios.component.html',
  styleUrls: ['./funcionarios.component.css']
})


export class FuncionariosComponent implements OnInit {
  funcdata: any;

  constructor(private funcionarios: FuncionariosService) { }

  ngOnInit() {
    this.funcionarios.getAll().subscribe(
      (res) => {
        this.funcdata = res;
        this.funcdata = this.funcdata.data ;
      }
    )
  }

}
