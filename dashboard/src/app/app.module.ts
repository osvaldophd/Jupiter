import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms'

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { DashboardModule } from './dashboard/dashboard.module';
import { LoginComponent } from './componentes/login/login.component';
import { HttpClientModule } from '@angular/common/http';
import { httpInterceptorProviders } from './interceptors/index.interceptor';
import { SwalService } from './services/swal.service';

import { NgxMaskModule, MaskApplierService } from 'ngx-mask';



@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
  ],
  imports: [
  BrowserModule,
    AppRoutingModule,
    DashboardModule,
    HttpClientModule,
    NgxMaskModule.forRoot(),
    ReactiveFormsModule
  ],
  providers: [httpInterceptorProviders, SwalService, MaskApplierService],
  bootstrap: [AppComponent]
})
export class AppModule { }
