import { Component } from '@angular/core';
import { ContaComponent } from './componentes/conta/conta.component';

@Component({
  template: `
            <app-header></app-header>
            <div style="padding-top:30px">
            <router-outlet></router-outlet>
            </div>
            <app-footer></app-footer>
  `
})
export class FuncionarioComponent {
  constructor() { }

  actualizar(status: boolean){
      console.log(status);
  }
}
