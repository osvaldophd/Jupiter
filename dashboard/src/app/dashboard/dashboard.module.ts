import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { DashboardRoutingModule } from './dashboard-routing.module';
import { HeaderComponent } from './componentes/header/header.component';
import { SidebarComponent } from './componentes/sidebar/sidebar.component';
import { EscalaComponent } from './componentes/escala/escala.component';
import { TemplateComponent } from './componentes/template/template.component';
import { HomeComponent } from './componentes/home/home.component';
import { FuncionariosModule } from './funcionarios/funcionarios.module';
import { VansModule } from './vans/vans.module';
import { CalendarioModule } from './calendario/calendario.module';
import { NgxMaskModule } from 'ngx-mask';
import { TextMaskModule } from 'angular2-text-mask';
import { ViagensModule } from './viagens/viagens.module';
import { ProfileModule } from './profile/profile.module';
import { RelatorioModule } from './relatorio/relatorio.module';
import { SharedModule } from '../shared/shared.module';

@NgModule({
  declarations: [
    HomeComponent,
    HeaderComponent,
    SidebarComponent,
    EscalaComponent,
    TemplateComponent,

  ],
  imports: [
    SharedModule,
    DashboardRoutingModule,
    NgxMaskModule.forRoot(),
    TextMaskModule,
    ViagensModule,
    FuncionariosModule,
    VansModule,
    CalendarioModule,
    ProfileModule,
    RelatorioModule
  ]
})
export class DashboardModule { }
