import { Component, OnInit } from '@angular/core';
import { RelatorioService } from './services/relatorio.service';
import { Relatorio, Viagens, Motoristas, serchParams, ResponseRelatorios } from './Models/relatorio.model';
import { finalize } from 'rxjs/operators';
import * as moment from 'moment';
import { RelatoriosService } from './services/relatorios.service';

@Component({
  templateUrl: './relatorio.component.html',
  styleUrls: ['./relatorio.component.css']
})
export class RelatorioComponent implements OnInit {

  vans: any;
  viagens: Viagens[];
  motoristas: Motoristas[];

  total: number;
  loading: boolean = true;
  daterange: any = {};
  options: any = {
    locale: { format: 'YYYY-MM-DD' },
    alwaysShowCalendars: false,
  }
  serachParams: serchParams = {
    dataIni: '',
    dataFin: ''
  }




  constructor(
    private relatoriosService: RelatoriosService
  ) {

  }

  ngOnInit() {

    this.searchRelatorio();

    // this.relatoriosService.getAll().pipe(
    //   finalize(() => {
    //     this.loading = false;
    //   })
    // ).subscribe((res: any) => {

    //   this.total = res.data.total_vans;
    //   this.vans = res.data.vans_modelos;
    //   this.viagens = res.data.funcionario_viagens;

    // });

  }

  toDay(){
    const today = moment().format('YYYY-MM-DD');
    this.serachParams.dataIni =today;
    this.serachParams.dataFin = today;
  }


  searchRelatorio(){

    if(!this.serachParams.dataIni || !this.serachParams.dataFin){
      this.toDay();
    }
    console.log(this.serachParams);
    this.relatoriosService.getRelatorios(this.serachParams).subscribe(
      (response: ResponseRelatorios) => {
        this.motoristas = response.data.motoristas;
        this.viagens = response.data.viagens;
      },
      (erro) => {
        console.log(erro);
      }
    );
  }

  public selectedDate(value: any, datepicker?: any) {
    // this is the date  selected

    // any object can be passed to the selected event and it will be passed back here
    datepicker.start = value.start;
    datepicker.end = value.end;
    this.serachParams.dataIni = String((datepicker.start as moment.Moment).format('YYYY-MM-DD'));
    this.serachParams.dataFin = String((datepicker.end as moment.Moment).format('YYYY-MM-DD'));
    this.searchRelatorio();

    // use passed valuable to update state
    this.daterange.start = value.start;
    this.daterange.end = value.end;
    this.daterange.label = value.label;
  }

}
