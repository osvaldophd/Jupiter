import { SwalService } from './../../services/swal.service';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class MessageService {

  constructor(private swal: SwalService) { }


  mensage(titulo: string,message: string, tipo: string) {
    this.swal.swalTitleText(titulo, message, tipo);
  }

  mensageTempo(titulo: string,message: string, valor:number,tipo: boolean) {
    this.swal.swalCustom(titulo, message, valor, tipo)
  }
  mensageRedirect(titulo: string,message: string, valor:number,tipo: boolean, rota:string) {
    this.swal.swalItervalRedirect(titulo, message, valor, tipo, rota);
  }
  swalSeaech() {
    this.swal.swalSeaech();
  }




}
