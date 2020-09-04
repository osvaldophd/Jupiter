import { Component, OnInit } from '@angular/core';
import { Calendar } from '@fullcalendar/core';
import esLocale from '@fullcalendar/core/locales/es';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';
import { CalendarioService } from 'src/app/services/calendario.service';
import { GetFuncionarioEscalaModel } from '../../models/getfuncionarioescala.model';
import { CalendarioEvento } from '../../models/calendarioEvento.model';
import { finalize } from 'rxjs/operators';
import { stringify } from 'querystring';

@Component({
  selector: 'app-mensal',
  templateUrl: './mensal.component.html',
  styleUrls: ['./mensal.component.css']
})
export class MensalComponent implements OnInit {

  dados: any;
  events: any[];
  calendaryPlugin = [dayGridPlugin];
  data: GetFuncionarioEscalaModel;
  calendarioEvento: Array<CalendarioEvento>;
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


  constructor(private calendarioService: CalendarioService) {

  }

  addEvent() {
    this.calendarEvents = this.calendarEvents.concat(

      { title: 'event 2', date: '2019-04-02' }

    );
  }

  handleDateClick(arg) { // handler method

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

    this.calendarioService.getAll().pipe(
      finalize(() => {
        this.loading = false;
      })
    ).subscribe(
      (req: GetFuncionarioEscalaModel) => {


        this.data = req;

        this.data.funcionario_escala.forEach((data) => {

          const datas = `${data.escala.ano}-${this.fomatarData(data.escala.mes_id)}-${this.fomatarData(data.dia)}`;
          const resp: CalendarioEvento = {
            title: this.firstLastName(data.funcionario.nome),
            date: datas
          };
          this.calendarioEvento.push(resp);

        });

        this.calendarEvents = this.calendarioEvento;



      }
    );

  }

  firstLastName(data: string): string {
    const arraynome: Array<string> = data.split(' ');
    return arraynome[0] + ' ' + arraynome[(arraynome.length - 1)];
  }

}
