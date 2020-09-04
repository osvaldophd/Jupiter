import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './componentes/login/login.component';
import { AuthGuard } from './auth/auth.guard';



const routes: Routes = [
  { path: 'login', component: LoginComponent},
  { path:'', loadChildren: () => import('./dashboard/dashboard.module').then(mod => mod.DashboardModule), canActivate: [AuthGuard]  }
  // { path:'', loadChildren: () => import('./dashboard/dashboard.module').then(mod => mod.DashboardModule), canActivate: [AuthGuard] }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
