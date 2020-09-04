import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { TemplateComponent } from './componentes/template/template.component';



const routes: Routes = [
  {
    path: '', component: TemplateComponent, children:
    [
      { path: '', loadChildren: ()=> import('./calendario/calendario.module').then( mod => mod.CalendarioModule) },
      { path: 'viagens', loadChildren: ()=> import('./viagens/viagens.module').then( mod => mod.ViagensModule) },
      { path: 'calendario', loadChildren: ()=> import('./calendario/calendario.module').then( mod => mod.CalendarioModule) },
      { path: 'home', loadChildren: ()=> import('./calendario/calendario.module').then( mod => mod.CalendarioModule) },
      { path: 'funcionarios', loadChildren: ()=> import('./funcionarios/funcionarios.module').then( mod => mod.FuncionariosModule) },
      { path: 'vans', loadChildren: () => import('./vans/vans.module').then( mod => mod.VansModule) },
      { path: 'perfil', loadChildren: () => import('./profile/profile.module').then( mod => mod.ProfileModule) },
      { path: 'relatorios', loadChildren: () => import('./relatorio/relatorio.module').then( mod => mod.RelatorioModule) },

    ]
  },

];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DashboardRoutingModule { }
