import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FuncionariosRoutingModule } from './funcionarios-routing.module';
import { ListComponent } from './componentes/list/list.component';
import { CreateComponent } from './componentes/create/create.component';
import { DeleteComponent } from './componentes/delete/delete.component';
import { UpdateComponent } from './componentes/update/update.component';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { FuncionariosComponent } from './funcionarios.component';
import { ListDetailComponent } from './componentes/list-detail/list-detail.component';
import { FullCalendarModule } from '@fullcalendar/angular';
import { TextMaskModule } from 'angular2-text-mask';
import { SharedModule } from '../../shared/shared.module';

@NgModule({
  declarations: [FuncionariosComponent, ListComponent, CreateComponent, DeleteComponent, UpdateComponent, ListDetailComponent],
  imports: [
    FuncionariosRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    FullCalendarModule,
    TextMaskModule,
    SharedModule
  ]
})
export class FuncionariosModule { }
