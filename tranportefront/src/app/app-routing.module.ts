import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AuthGuard } from './auth/auth.guard';
import { LandingComponent } from './componentes/landing/landing.component';
import { RegisterComponent } from './componentes/register/register.component';



const routes: Routes = [
  { path: '', component: LandingComponent },
  // { path: 'registar-se', component: RegisterComponent },
  { path: 'user', loadChildren: () => import('./funcionario/funcionario.module').then(mod => mod.FuncionarioModule), canActivate: [AuthGuard] },
  { path: 'login', redirectTo: ''}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
