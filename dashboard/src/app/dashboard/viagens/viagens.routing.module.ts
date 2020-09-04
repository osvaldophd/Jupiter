import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ViagensComponent } from './viagens.component';




const routes: Routes = [
  { path: '', component: ViagensComponent},

];

@NgModule({
  imports: [RouterModule.forChild(routes)],
exports: [RouterModule]
})
export class ViagensRoutingModule { }
