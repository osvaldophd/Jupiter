import { element } from 'protractor';
import { environment } from './../../../../environments/environment';
import { ClimaObject } from 'src/app/models/clima-object';
import { Component, OnInit } from '@angular/core';
import { ClimaService } from 'src/app/services/clima.service';
import { EscalaService } from 'src/app/services/escala.service';
import { FormGroup, FormControl } from '@angular/forms';
import { elementAt, finalize } from 'rxjs/operators';

@Component({
  selector: 'app-escala',
  templateUrl: './escala.component.html',
  styleUrls: ['./escala.component.css']
})
export class EscalaComponent implements OnInit {

  // formulario para buscar escala por data
  buscaForm = new FormGroup({
    dataBusca: new FormControl(''),
  });

  //declaração de variavel
  public escalaSemana: any;
  public enderecoIMG: string = environment.IMGS;
  public motorista: any[] = [];
  public dataArraySemana: Array<string> = [];
  public weekDays: Object[] = [];
  public escala_title = "Escala Semanal";
  public singular: boolean = false;
  loading: boolean = true;
  mensagem: string = "Carregando escala semanal";

  slideConfig = { "slidesToShow": 4, "slidesToScroll": 4 };

  dayActive: any;

  constructor(private escalaService: EscalaService) { }

  getMotoristas() {
    this.escalaService.getEscalaSemanal()
    .pipe( finalize(()=> {
      this.loading = false;
    }))
    .subscribe(
      (res) => {
        this.escalaSemana = res['data']['funcionario_escala'];
        if (this.escalaSemana[0]['funcionario']) {
          this.singular = true;
          this.mudarMotorista(this.escalaSemana[0].dia);
          this.escalaSemana.map((item) => {

            if (this.dataArraySemana.indexOf(item.dia) == -1) {
              this.dataArraySemana.push(item.dia);

              this.weekDays.push({
                id: item.escala.id,
                dia: item.dia,
                mes: item.escala.mes_id,
                ano: item.escala.mes_id
              });
            }

          });
        } else {
          this.motorista = [];
        }
      });

  }

  ngOnInit() {
    // busca a esca do funcionario escalado Semanal

    this.getMotoristas();

  }
  // selecionar motorista
  mudarMotorista(dia: any): void {
    this.motorista = [];
    this.escalaSemana.map((item) => {
      if (item.dia == dia) {
        this.dayActive = dia
        this.motorista.push(item.funcionario);
      }

    });

    this.slickInit(this.motorista);

  }
  //buscar escala por data
  buscarEscala() {
    this.dataArraySemana = [];
    this.weekDays = [];
    this.escala_title = "Escala Pesquisada";
    this.singular = false;
    this.escalaService.getEscaladata(this.buscaForm.value['dataBusca']).subscribe(
      (res) => {
        console.log(res['data'].length)
        this.escalaSemana = res['data']['funcionario_escala'];
        if (this.escalaSemana[0]['funcionario']) {
          this.singular = true;
          this.mudarMotorista(this.escalaSemana[0].dia);
          this.escalaSemana.map((item) => {
            if (this.dataArraySemana.indexOf(item.dia) == -1) {
              this.dataArraySemana.push(item.dia);
              this.weekDays.push({
                id: item.escala.id,
                dia: item.dia,
                mes: item.escala.mes_id,
                ano: item.escala.mes_id
              });
            }

          });
        } else {
          this.motorista = [];
        }
      });
  }
  data(dia, mes, ano): Date {

    return new Date(ano, mes - 1, dia);
  }


  removeSlide() {
    this.motorista.length = this.motorista.length - 1;
    console.log('1')
  }

  slickInit(e) {
    console.log('2')

  }

  breakpoint(e) {
    console.log('3')
  }

  afterChange(e) {
    console.log('4')
  }

  beforeChange(e) {
    console.log('5')
  }



}
