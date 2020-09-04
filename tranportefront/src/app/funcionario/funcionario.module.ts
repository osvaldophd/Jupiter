import { BuscarComponent } from '../componentes/buscar/buscar.component';
import { PrevisaoTempoComponent } from '../componentes/previsao-tempo/previsao-tempo.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MotoristasComponent } from './componentes/motoristas/motoristas.component';
import { FuncionarioRoutingModule } from './funcionario-routing.module';
import { HeaderComponent } from './componentes/header/header.component';
import { FooterComponent } from './componentes/footer/footer.component';
import { EscalaComponent } from './componentes/escala/escala.component';
import { HomeComponent } from './componentes/home/home.component';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { VansComponent } from './componentes/vans/vans.component';
import { BrowserModule } from '@angular/platform-browser';
import { SlickCarouselModule } from 'ngx-slick-carousel';
import { ContaComponent } from './componentes/conta/conta.component';
import { TextMaskModule } from 'angular2-text-mask';
import { FuncionarioComponent } from './funcionario.component';

@NgModule({
  declarations: [
    FuncionarioComponent,
    HomeComponent,
    HeaderComponent,
    FooterComponent,
    EscalaComponent,
    VansComponent,
    MotoristasComponent,
    PrevisaoTempoComponent,
    BuscarComponent,
    ContaComponent,
  ],
  imports: [
    CommonModule,
    FuncionarioRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    BrowserModule,
    SlickCarouselModule,
    TextMaskModule
  ]
})
export class FuncionarioModule { }
