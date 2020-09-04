import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ViagensComponent } from './viagens.component';
import { ViagensRoutingModule } from './viagens.routing.module';
import { ViagemService } from './services/viagem.service';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from '../../shared/shared.module';


@NgModule({
  declarations: [
    ViagensComponent
  ],
  imports: [
    SharedModule,
    ViagensRoutingModule,
    FormsModule,
    ReactiveFormsModule
    
  ],
  providers: [ViagemService]
})
export class ViagensModule { }
