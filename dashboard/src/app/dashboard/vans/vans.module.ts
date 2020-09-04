import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { VansRoutingModule } from './vans-routing.module';
import { ListComponent } from './componentes/list/list.component';
import { CreateComponent } from './componentes/create/create.component';
import { VansComponent } from './vans.component';
import { ListDetailComponent } from './componentes/list-detail/list-detail.component';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { UpdateComponent } from './componentes/update/update.component';
import { ModelosComponent } from './componentes/modelos/modelos.component';
import { MarcasComponent } from './componentes/marcas/marcas.component';
import { TruncateModule } from 'ng2-truncate';
import { TextMaskModule } from 'angular2-text-mask';
import { SharedModule } from '../../shared/shared.module';


@NgModule({
  declarations: [VansComponent, ListComponent, CreateComponent, ListDetailComponent, UpdateComponent, ModelosComponent, MarcasComponent],
  imports: [
  CommonModule,
    VansRoutingModule,
    FormsModule,
    TruncateModule ,
    ReactiveFormsModule,
    TextMaskModule,
    SharedModule
  ]
})
export class VansModule { }
