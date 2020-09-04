import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ListComponent } from './componentes/list/list.component';
import { CreateComponent } from './componentes/create/create.component';
import { VansComponent } from './vans.component';
import { ListDetailComponent } from './componentes/list-detail/list-detail.component';
import { UpdateComponent } from './componentes/update/update.component';
import { ModelosComponent } from './componentes/modelos/modelos.component';
import { MarcasComponent } from './componentes/marcas/marcas.component';


const routes: Routes = [
  {
    path: '', component: VansComponent,
    children: [
      { path: '', component: ListComponent },
      { path: 'list/:id', component: ListDetailComponent },
      { path: 'list', component: ListComponent },
      { path: 'update/:id', component: UpdateComponent },
      { path: 'create', component: CreateComponent },
      { path: 'modelos', component: ModelosComponent },
      { path: 'marcas', component: MarcasComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class VansRoutingModule { }
