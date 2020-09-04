import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ListComponent } from './componentes/list/list.component';
import { FuncionariosComponent } from './funcionarios.component';
import { CreateComponent } from './componentes/create/create.component';
import { ListDetailComponent } from './componentes/list-detail/list-detail.component';
import { UpdateComponent } from './componentes/update/update.component';
import { FullCalendarModule } from '@fullcalendar/angular';


const routes: Routes = [
  { path: '', component: FuncionariosComponent,
    children: [
          { path: '', component: ListComponent },
          { path: 'create', component: CreateComponent },
          { path: ':id', component: ListDetailComponent },
          { path: 'edit/:id', component: UpdateComponent}

    ]
  }
];

@NgModule({
  imports: [
    RouterModule.forChild(routes)
  ],
  exports: [RouterModule]
})
export class FuncionariosRoutingModule { }
