import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup, Validator, Validators } from '@angular/forms';
import { HttpErrorResponse, HttpClient, HttpHeaders } from '@angular/common/http';
import { AuthService } from 'src/app/services/auth.service';
import { TokenService } from 'src/app/services/token.service';
import { SwalService } from 'src/app/services/swal.service';
import { Funcionario } from './../../dashboard/calendario/models/funcionario.model';
import { environment } from 'src/environments/environment';
import { CookieService } from 'src/app/services/cookie.service';
import { DataUser } from 'src/app/models/user';
import { DataLogin } from 'src/app/models/Login.model';
import { take, map, flatMap, switchAll, switchMap } from 'rxjs/operators';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  formLogin: FormGroup;
  returnlogin: { status: boolean, message: string };
  api = environment.API;
  keyCookie = environment.keyCookie;
  keyToken = environment.keyToken;

  constructor(
    private auth: AuthService, private token: TokenService,
    private route: Router, private fb: FormBuilder,
    private swalService: SwalService,
    private http: HttpClient,
    private cookieService: CookieService
  ) {

    this.formLogin = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required]
    });

    this.returnlogin = { status: false, message: '' };

  }

  get email() { return this.formLogin.get('email'); }

  get password() { return this.formLogin.get('password'); }

  ngOnInit() {

    console.log(document.cookie);

    var cookie = this.cookieService.getCookie();
    console.log(cookie);

    if (cookie) {

      localStorage.setItem(this.keyToken, cookie.replace('"', ''));

      this.auth.getUserReload().subscribe(
        (res: DataUser) => {

          res.roles.forEach(data => {

            if (data.id == 2) {

              localStorage.setItem('userprofile', JSON.stringify(res.funcionario));

              this.cookieService.clenCookie();
              this.cookieService.deleteCookie();
              this.route.navigate(['/home']).finally(() => {
                this.swalService.swalCustom('Sincronizando aplicação', 'Carregando os dados', 2000, true);
              });

            }
          }

          )

          this.swalService.swalCustom('Acesso Negado', 'Voce não tem permissão para aceder', 2000, true);


        }
      )



    } else if (this.auth.VerifyisLoged) {

      this.auth.getUserReload().subscribe(
        (res: DataUser) => {

          res.roles.forEach(data => {

            if (data.id == 2) {
              localStorage.setItem('userprofile', JSON.stringify(res.funcionario));
              this.cookieService.clenCookie();
              this.route.navigate(['/home']).finally(() => {
                this.swalService.swalCustom('Sincronizando aplicação', 'Carregando os dados', 2000, true);
              });

            }
          }

          )

          this.swalService.swalCustom('Acesso Negado', 'Voce não tem permissão para aceder', 2000, true);


        }
      )

    }

    // window.indexedDB.open('token', 1);

    // var data
    // var app = window.indexedDB.open('token', 1);
    // app.onerror = function(){
    //   alert('Erro ao accessar o banco de dados');
    // }
    // app.onsuccess = function(res){
    //   data = app.result;
    //   alert(data);
    // }

    // console.log(app);

  }

  verificaPermissao() {

  }

  login() {

    this.returnlogin.status = false;

    this.auth.login(this.formLogin.value)
      .subscribe((res: DataLogin) => {

        res.usuario.roles.forEach(user => {
          if (user.id == 2) {

            this.returnlogin.status = true;
            this.returnlogin.message = 'Login feito com sucesso!';
            this.token.setToken(res.token);
            localStorage.setItem('userprofile', JSON.stringify(res.usuario.funcionario));

            this.route.navigate(['/home']).finally(() => {
              this.swalService.swalCustom('Bem vindo', 'Carregando os dados', 2000, true);
            });

          }
        });

        this.swalService.swalCustom('Acesso Negado', 'Voce não tem permissão para aceder', 2000, true);


      },
        (error: HttpErrorResponse) => {

          console.log('Error', error);

          if (error.error.error === 'credencias_invalidas') {
            this.swalService.swalToast();
            this.swalService.swalCustom('Erro de Autenticação', '', 1000, true);
            this.returnlogin.status = true;
            this.returnlogin.message = 'O seu Email e a Senha estão incorretos.';
          }
        }
      );

  }




}
