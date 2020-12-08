import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { AuthService } from 'src/app/services/auth.service';
import { TokenService } from 'src/app/services/token.service';
import { Router } from '@angular/router';
import { catchError, finalize } from 'rxjs/operators';
import { Observable } from 'rxjs';
import { HttpErrorResponse } from '@angular/common/http';
import { UserLoginData } from 'src/app/models/usuariologin';
import { CookieService } from 'src/app/services/cookie.service';
import { MyUser } from 'src/app/models/myUser.model';
import { error } from 'protractor';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.css']
})
export class MenuComponent implements OnInit {


  formlogin: FormGroup;
  errors: any = null;
  closemodal: any;
  loading: boolean = false;
  keyToken = environment.keyToken;

  constructor(
    private formbuild: FormBuilder,
    private auth: AuthService,
    private token: TokenService,
    private route: Router,
    private serviceCookie: CookieService
  ) {

    this.formlogin = this.formbuild.group({
      email: ['', Validators.required],
      password: ['', Validators.required]
    });
  }

  ngOnInit() {

    const cookie = this.serviceCookie.getCookie();

    if (cookie) {

      localStorage.setItem(this.keyToken, cookie);
      this.auth.getUserReload().subscribe(
        (resp: MyUser) => {
          this.serviceCookie.clenCookie();
          this.serviceCookie.deleteCookie();
          localStorage.setItem(this.keyToken, cookie);
          localStorage.setItem('funcionario', JSON.stringify(resp));
          this.route.navigate(['user']);

        }
      )
    } else if (this.token.verifyToken()) {

      this.auth.getUserReload().subscribe(
        (resp: MyUser) => {
          this.serviceCookie.deleteCookie();
          localStorage.setItem(this.keyToken, cookie);
          localStorage.setItem('funcionario', JSON.stringify(resp));
          this.route.navigate(['user']);

        },
        (erro) => {
          // console.log(erro);
        }
      )

    }



  }

  closeModal(closemodal) {
    this.closemodal = closemodal;
  }

  login() {

    this.loading = true;

    this.auth.login(this.formlogin.value).subscribe(

      (resp: UserLoginData) => {
        this.loading = false;
        this.token.setToken(resp.token, resp.usuario);
        this.closemodal.click();
        this.route.navigate(['user']);
      }

    );

    window.setInterval(() => { this.reloading() }, 4000);


  }

  reloading() {
    this.loading = false;
  }


}
