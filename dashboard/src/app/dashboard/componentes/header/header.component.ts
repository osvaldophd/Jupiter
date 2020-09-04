import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { TokenService } from 'src/app/services/token.service';
import { Router } from '@angular/router';
import { environment } from './../../../../environments/environment';
import { CookieService } from 'src/app/services/cookie.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  usuario: any;
  Usertoken: string = '';
  api = environment.API_PATH;
  keyToken = environment.keyToken;

  constructor(
    private ath: AuthService, 
    private token: TokenService, 
    private route: Router, 
    private cookieService: CookieService
    ) { 
  }

  logout() {
    this.ath.logout();
    if (!this.token.verifyToken()) {
      this.route.navigate(['/login']);
    }
  }
  ngOnInit() {

    this.usuario = JSON.parse(localStorage.getItem('userprofile'));
    this.Usertoken = localStorage.getItem(this.keyToken);

  }

  utenteModule(){

    this.cookieService.setCookie(this.Usertoken);

  }

}
