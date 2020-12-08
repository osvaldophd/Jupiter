import { AuthGuard } from '../auth/auth.guard';
import { MotoristasComponent } from './componentes/motoristas/motoristas.component';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { EscalaComponent } from './componentes/escala/escala.component';
import { HomeComponent } from './componentes/home/home.component';
import { VansComponent } from './componentes/vans/vans.component';
import { ContaComponent } from './componentes/conta/conta.component';
import { FuncionarioComponent } from './funcionario.component';

const routes: Routes = [

  {
    path: '', component: FuncionarioComponent, canActivate: [AuthGuard], children:
      [
        { path: '', component: HomeComponent },
        { path: 'home', component: HomeComponent },
        { path: 'escala', component: EscalaComponent },
        { path: 'motorista', component: MotoristasComponent },
        { path: 'van', component: VansComponent },
        { path: 'conta', component: ContaComponent },

      ]
  },


];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FuncionarioRoutingModule { }
