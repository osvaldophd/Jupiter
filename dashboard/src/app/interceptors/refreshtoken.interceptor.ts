import { MessageService } from './../shared/services/mensage.service';
import { Injectable, Injector } from '@angular/core';
import { HttpEvent, HttpInterceptor, HttpHandler, HttpRequest, HttpErrorResponse, HttpClient } from '@angular/common/http';
import { catchError, tap, flatMap } from 'rxjs/operators';
import { Observable } from 'rxjs';
import { AuthService } from '../services/auth.service';
import { SwalService } from '../services/swal.service';
import { environment } from 'src/environments/environment';
import { Router } from '@angular/router';
import { TokenService } from '../services/token.service';
import { CookieService } from '../services/cookie.service';


@Injectable()
export class RefreshTokenInterceptor implements HttpInterceptor {
  api = environment.API;
  keyToken = environment.keyToken
  lo

  constructor(private auth: AuthService,
    private swal: SwalService,
    private injector: Injector,
    private router: Router,
    private token: TokenService,
    private serviceCookie: CookieService,
    private messageService: MessageService
  ) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {

    return next.handle(req).pipe(

      catchError((error: any, caught: Observable<any>): Observable<any> => {

        const keytoken = environment.keyToken;
        const valuetoken = localStorage.getItem(keytoken);

        if (error.status === 403) {

          this.serviceCookie.clenCookie();
          this.auth.logout();
          this.router.navigate(['login']);
        }


        if ((error.statusText === 'Unauthorized' || error.status === 401) && (valuetoken)) {
          localStorage.removeItem('usuario');
          this.auth.logout();
          if (!this.token.verifyToken()) {
            this.router.navigate(['/login']);
          }

        }

        if (error.statusText === 'authorized') {

          const http = this.injector.get(HttpClient);

          return http.post(`${this.api}refresh`, {}).pipe(
            flatMap((data: { access_token: string }) => {
              localStorage.setItem(this.keyToken, data.access_token);
              const newReq = req.clone({ setHeaders: { Authorization: `Bearer ${data.access_token}`, 'Content-Type': 'application/json' } });
              return next.handle(newReq);
            })
          )

        }

        if (error.status === 400) {
          if(error.error.message[0] === 'The email has already been taken.'){
            this.messageService.mensage('E-mail já usado!', 'Este E-mail ja existe no Sistema!', 'warning');
          }else{
            this.messageService.mensage('Acesso negado!', 'Verifique as suas credencias!', 'error');
          }

        }

        if (error.status === 500) {
          if (error.error.message === 'nao_foi_possivel_excluir_modelo') {
            this.messageService.mensage('Não foi possivel excluir', 'O modelo está associado a uma van', 'warning');
          } else {
            if (error.error.message === 'nao_foi_possivel_excluir_marca') {
              this.messageService.mensage('Não foi possivel excluir', 'O Marca está associado a Modelo', 'warning');
            }
            if (error.error.message === 'nao_foi_possivel_adicionar_modelo') {
              this.messageService.mensage('Não foi Adicionar', 'Este modelo já existe', 'warning');
            }
            else {
              this.messageService.mensage('Não foi possível iniciar a sessão', 'O servidor remoto não está disponível, tente mais tarde!', 'error');
            }
          }

        }

        return error;
      }));




  }
}
