import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { TokenService } from 'src/app/services/token.service';
import { Router } from '@angular/router';
import { environment } from 'src/environments/environment';
import { ShareContaService } from '../../services/share-conta.service';
import { DataUser, Role } from '../../../models/usuario.model';
import { CookieService } from 'src/app/services/cookie.service';
import { Usuario } from 'src/app/models/usuariologin';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  public apiPath: string = environment.path;
  usuario: Usuario;
  roles: boolean = false;
  usuarioPhoto: any;
  keyCookie = environment.keyCookie;
  keyToken = environment.keyToken;
  urlTorenRedirect = environment.urlTorenRedirect;
  domain: string = environment.domain;
  userToken: string = '';


  constructor(
    private ath: AuthService,
    private token: TokenService,
    private router: Router,
    private _shareconta: ShareContaService,
    private cookieService: CookieService
  ) {

    this._shareconta.actualiza.subscribe((resp: boolean) => {
      if (resp) { this.getUsuario();   }
    })
  }

  logout() {
    this.cookieService.clenCookie();
    this.cookieService.deleteCookie();
    this.ath.logout();
    if (!this.token.verifyToken()) {
      this.cookieService.deleteCookie();
      this.router.navigate(['/']);
    }
  }
  getUsuario() {

    this.userToken = localStorage.getItem(this.keyToken);
    const currentUser: Usuario = JSON.parse(localStorage.getItem('funcionario'));
    this.usuario = currentUser;
    this.usuarioPhoto = currentUser.funcionario.imagem;

    currentUser.roles.forEach((data) => {
      if (data.id == 2) {  this.roles = true;   }
    })

  }

  painelAdmin() { this.cookieService.setCookie(this.userToken);  }

  ngOnInit() {   this.getUsuario();   }

}
