import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CalendarioRoutingModule } from './calendario-routing.module';
import { ComponentesComponent } from './componentes/componentes.component';
import { CalendarioComponent } from './calendario.component';
import { MensalComponent } from './componentes/mensal/mensal.component';
import { EscalaMensalComponent } from './componentes/escala-mensal/escala-mensal.component';
import {FullCalendarModule} from '@fullcalendar/angular';
import { DefineescalaComponent } from './componentes/defineescala/defineescala.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from '../../shared/shared.module';

@NgModule({
  declarations: [ComponentesComponent, CalendarioComponent, MensalComponent, EscalaMensalComponent, DefineescalaComponent],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    FullCalendarModule,
    CalendarioRoutingModule,
    SharedModule
  ]
})
export class CalendarioModule { }
