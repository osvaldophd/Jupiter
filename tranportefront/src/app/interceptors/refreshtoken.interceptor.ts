import { Injectable, Injector } from '@angular/core';
import { HttpEvent, HttpInterceptor, HttpHandler, HttpRequest, HttpErrorResponse, HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { catchError, tap, flatMap } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { SwalService } from '../services/swal.service';
import { Router } from '@angular/router';
import { TokenService } from '../services/token.service';
import { CookieService } from '../services/cookie.service';
/** Classe responsavel por passar token em uma url do site que é acessada */

@Injectable()
export class RefreshTokenInterceptor implements HttpInterceptor {

    api = environment.API;

    constructor(private injector: Injector,
        private swal: SwalService,
        private router: Router,
        private serviceToken: TokenService,
        private cookieService: CookieService
        ) { }

    intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {


        return next.handle(req).pipe(

            catchError((error: any, caught: Observable<any>): Observable<any> => {
                const keytoken = environment.keyToken;
                const valuetoken = localStorage.getItem(keytoken);

                if ((error.statusText === 'Unauthorized' || error.status === 401) && (valuetoken))  {

                    const http = this.injector.get(HttpClient);
                    return http.post(`${this.api}/refresh`, {}).pipe(
                        flatMap((data : {access_token: string}) => {
                            localStorage.setItem(keytoken, data.access_token);
                            const newReq = req.clone({ setHeaders : { Authorization: `Bearer ${data.access_token}`, 'Content-Type': 'application/json' }});
                            return next.handle(newReq);
                        })
                    )

                }

                if (error.status === 400) {
                    this.swal.swalTitleText('Acesso negado!', 'Verifique as suas credencias!', 'error');
                }

                if (error.status === 403) {
                    this.cookieService.setCookie('');
                    this.serviceToken.removerToken();
                    this.router.navigate(['login']);
                }

                if (error.status === 500) {
                    this.swal.swalTitleText('Não foi possível iniciar a sessão', 'O servidor remoto não está disponível, tente mais tarde!', 'error');
                }

                return error;
            }));




    }
}
