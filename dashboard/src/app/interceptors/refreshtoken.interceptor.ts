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


    constructor(private auth: AuthService, 
        private swal: SwalService, 
        private injector: Injector, 
        private router: Router,
        private token: TokenService,
        private serviceCookie: CookieService
        ) { }

    intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {

        return next.handle(req).pipe(

            catchError((error: any, caught: Observable<any>): Observable<any> => {    

                const keytoken = environment.keyToken;
                const valuetoken = localStorage.getItem(keytoken);

                if(error.status === 403){

                    this.serviceCookie.clenCookie();
                    this.auth.logout();
                    this.router.navigate(['login']);
                }

                if ((error.statusText === 'Unauthorized' || error.status === 401) && (valuetoken)) {

                    const http = this.injector.get(HttpClient);
                    return http.post(`${this.api}refresh`, {}).pipe(
                        flatMap((data: { access_token: string }) => {
                            console.log(data);
                            localStorage.setItem(this.keyToken, data.access_token);
                            const newReq = req.clone({ setHeaders: { Authorization: `Bearer ${data.access_token}`, 'Content-Type': 'application/json' } });
                            return next.handle(newReq);
                        })
                    )

                }
                if (error.status === 400) {
                    this.swal.swalTitleText('Acesso negado!', 'Verifique as suas credencias!', 'error');
                }


                if (error.status === 500) {
                    // localStorage.removeItem('usuario');
                    // document.cookie = null;
                    this.swal.swalTitleText('Não foi possível iniciar a sessão', 'O servidor remoto não está disponível, tente mais tarde!', 'error');

                    // function eraseCookie(name) {
                    //     document.cookie = name + '=; Max-Age=-99999999;';
                    // }
                    // eraseCookie('token');

                    // this.auth.logout();
                    // if (!this.token.verifyToken()) {
                    //     this.route.navigate(['/login']);
                    // }
                   
                }

                return error;
            }));




    }
}
