import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { MensalComponent } from './componentes/mensal/mensal.component';
import { CalendarioComponent } from './calendario.component';
import { EscalaComponent } from '../componentes/escala/escala.component';
import { FullCalendarComponent } from '@fullcalendar/angular';
import { DefineescalaComponent } from './componentes/defineescala/defineescala.component';


const routes: Routes = [

  { path: '', component: CalendarioComponent,  children:
      [
        { path: '', component: MensalComponent},
      ]
  },
  { path: 'escala', component: DefineescalaComponent  }


];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CalendarioRoutingModule { }
