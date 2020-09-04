import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { Daterangepicker } from 'ng2-daterangepicker';

import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RelatorioRoutingModule } from './relatorio.routing.module';
import { RelatorioComponent } from './relatorio.component';
import { RelatorioService } from './services/relatorio.service';
import { SharedModule } from '../../shared/shared.module';


@NgModule({
  declarations: [
    RelatorioComponent
  ],
  imports: [
    CommonModule,
    RelatorioRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    SharedModule,
    Daterangepicker
  ],
  providers: [RelatorioService]
})
export class RelatorioModule { }
