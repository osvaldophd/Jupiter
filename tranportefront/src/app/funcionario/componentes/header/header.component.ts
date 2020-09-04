import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { TokenService } from 'src/app/services/token.service';
import { Router } from '@angular/router';
import { UsuarioService } from 'src/app/services/usuario.service';
import { environment } from 'src/environments/environment';
import { ShareContaService } from '../../services/share-conta.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  public apiPath: string = environment.path;
  usuario: any;
  usuarioPhoto

  constructor(
    private ath: AuthService,
    private token: TokenService,
    private route: Router,
    private _shareconta: ShareContaService
  ) { 

    this._shareconta.actualiza.subscribe( (resp: boolean) => {
        if(resp){
          this.getUsuario();
        }
    })
  }

  logout() {
    this.ath.logout();
    if (!this.token.verifyToken()) {
      this.route.navigate(['/login']);
    }
  }
  getUsuario() {

    const currentUser: any = JSON.parse(localStorage.getItem('funcionario'));
    this.usuarioPhoto = currentUser.imagem;

  }
  ngOnInit() {

    this.getUsuario();

  }

}
