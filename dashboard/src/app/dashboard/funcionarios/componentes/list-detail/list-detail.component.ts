import {
  Component,
  OnInit
} from '@angular/core';
import {
  ActivatedRoute
} from '@angular/router';
import {
  FuncionariosService
} from '../../services/funcionarios.service';

import {
  environment
} from 'src/environments/environment';

import dayGridPlugin from '@fullcalendar/daygrid';

import {
  SwalService
} from 'src/app/services/swal.service';
import {
  CalendarioEvento
} from 'src/app/dashboard/calendario/models/calendarioEvento.model';
import {
  callbackify
} from 'util';
import { Funcionario } from './../../../calendario/models/funcionario.model';
import { finalize } from 'rxjs/operators';

@Component({
  selector: 'app-list-detail',
  templateUrl: './list-detail.component.html',
  styleUrls: ['./list-detail.component.css']
})
export class ListDetailComponent implements OnInit {

  funcionarios: any;
  escala: any;
  // tslint:disable-next-line: variable-name
  api_path = environment.API_IMG;

  dados: any;
  events: any[];
  calendaryPlugin = [dayGridPlugin];
  data;
  calendarioEvento: Array < CalendarioEvento > ;
  loading: boolean = true;


  buttonText = {
    today: 'Hoje',
    month: 'Mês',
    week: 'Semana',
    day: 'Dia',
    list: 'Lista'
  };

  bootstrapFontAwesome = {
    prev: 'fa-chevron-left',
    next: 'right-single-arrow',
    prevYear: 'left-double-arrow',
    nextYear: 'right-double-arrow'
  };

  buttonIcons = {
    prev: 'left-single-arrow',
    next: 'right-single-arrow',
    prevYear: 'left-double-arrow',
    nextYear: 'right-double-arrow'
  };

  calendarEvents = [];


  constructor(private route: ActivatedRoute,
    private funcionario: FuncionariosService,
    private swal: SwalService
  ) {

  }

  addEvent() {
    this.calendarEvents = this.calendarEvents.concat(

      {
        title: 'event 2',
        date: '2019-04-02'
      }

    );
  }

  handleDateClick(arg) {

  }

  modifyTitle(eventIndex, newTitle) {
    const calendarEvents = this.calendarEvents.slice(); // a clone
    const singleEvent = Object.assign({}, calendarEvents[eventIndex]); // a clone
    singleEvent.title = newTitle;
    calendarEvents[eventIndex] = singleEvent;
    this.calendarEvents = calendarEvents; // reassign the array
  }


  fomatarData(data: any): any {
    if (data <= 9) {
      return `0${data}`;
    } else {
      return data;
    }
  }


  ngOnInit() {

    this.calendarioEvento = [];

    const id: string = this.route.snapshot.params.id;

    this.funcionario.getById(+id).pipe(
      finalize(()=> {
        this.loading = false;
      })
    ).subscribe((res: any) => {
        this.funcionarios = res.data.funcionario[0];
      },
      (error) => {


      });

    this.funcionario.getEscala(+id).subscribe((res: any) => {
      this.escala = res.data;

      this.escala.forEach((data, i) => {

        const datas = `${data.escala.ano}-${this.fomatarData(data.escala.mes_id)}-${this.fomatarData(data.dia)}`;
        const resp: CalendarioEvento = {
          title: this.funcionarios.nome,
          date: datas
        };

        this.calendarioEvento.push(resp);
      });
      callback();
    });

    // Calendario


    const callback = () => {

      this.calendarEvents = this.calendarioEvento;


    };


  }


  delete(dados: any) {

    const handlerCallback = () => {
      this.funcionario.deteteFnc(+dados.id)
        .subscribe((res) => {

          this.swal.swalTitleText('Sucesso', `O colaborador <strong> ${dados.nome} <strong> foi eliminado!`, 'success');
          this.ngOnInit();
        });
    };



    this.swal.swalConfirmation(
      'Eliminar Colaborador',
      `Deseja eliminar o colaborador ${dados.nome}?`,
      'warning',
      `Sim, eliminar`,
      handlerCallback
    );
  }



}
