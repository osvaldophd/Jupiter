import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AuthGuard } from './auth/auth.guard';
import { LandingComponent } from './componentes/landing/landing.component';
import { RegisterComponent } from './componentes/register/register.component';



const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: '/landing' },
  // { path: 'registar-se', component: RegisterComponent },
  { path: 'login', redirectTo:'landing'},
  { path: 'landing', component: LandingComponent },
  { path:'painel',
  loadChildren: () => import('./funcionario/funcionario.module').then(mod => mod.FuncionarioModule),
   canActivate: [AuthGuard] }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
