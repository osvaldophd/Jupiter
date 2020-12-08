import { BrowserModule } from '@angular/platform-browser';
import { NgModule, LOCALE_ID } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms'
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HttpClientModule } from '@angular/common/http';
import { httpInterceptorProviders } from './interceptors/index.interceptor';
import { registerLocaleData } from '@angular/common';
import localePtBr from '@angular/common/locales/pt';
import { LandingComponent } from './componentes/landing/landing.component';
import { RegisterComponent } from './componentes/register/register.component';
import { MenuComponent } from './componentes/menu/menu.component';
import { TextMaskModule } from 'angular2-text-mask';
import { FuncionarioModule } from './funcionario/funcionario.module';
import { SwalService } from './services/swal.service';
registerLocaleData(localePtBr);

@NgModule({
  declarations: [
    AppComponent,
    LandingComponent,
    RegisterComponent,
    MenuComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FuncionarioModule,
    HttpClientModule,
    ReactiveFormsModule,
    TextMaskModule
  ],
  providers: [
    SwalService,
    httpInterceptorProviders,
    { provide: LOCALE_ID, useValue: 'pt-br' }

  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
